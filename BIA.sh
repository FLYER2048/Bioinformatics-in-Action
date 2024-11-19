cd ~
mkdir BIA_groups
time for group_id in {1..11}; do
    cd ~/BIA_groups
    mkdir group_${group_id}
    cd group_${group_id}
    mkdir input_reads
    mkdir reference_sequence
    cp ~/data/BIA/groups/group${group_id}/*.gz input_reads/ # 把四个样品的测序结果拷贝到input_reads文件夹下
    cp ~/data/BIA/groups/group${group_id}/*.fasta reference_sequence/ # 把AMR基因文件和大肠杆菌的参考序列拷贝到reference_sequence文件夹下
    mkdir kraken_db
    cp -r ~/data/kraken/bact_20220725_4GB kraken_db/
    mkdir FastQC # 质控文件输出文件夹
    mkdir kraken_output # kraken鉴定的输出文件夹
    mkdir aligned_reads # kraken
    mkdir assemblies # spades输出的组装结果
    mkdir assembled_db # 组装结果数据库
    mkdir assembled_results # 组装结果与抗生素抗性基因BLAST后的结果

    # 物种鉴定
    conda activate kraken
    for i in {1..4}; do
        kraken2 --db kraken_db/bact_20220725_4GB \
                --threads 2 --output kraken_output/sample${i}.kraken2 \
                --report kraken_output/sample${i}.kreport2 \
                --paired input_reads/sample${i}_1.fastq.gz input_reads/sample${i}_2.fastq.gz
        
        bracken -i kraken_output/sample${i}.kreport2 \
                -d kraken_db/bact_20220725_4GB -r 100 -o kraken_output/sample${i}.bracken
        
        head kraken_output/sample${i}.bracken \
            | column -t -s$'\t' > sample${i}_species.txt
    done
    
    # 组装
    for i in {1..4}; do
        spades.py -t 2 -o assemblies/sample${i} -1 input_reads/sample${i}_1.fastq.gz -2 input_reads/sample${i}_2.fastq.gz
    done

    # bwa检测gyrA的点突变
    bwa index reference_sequence/NC_013654.fasta -p reference_sequence/Escherichia_SE15
    for i in {1..4}; do
        # 比对样品到参考基因组，排序，输出为bam文件
        bwa mem -t 2 reference_sequence/Escherichia_SE15 input_reads/sample${i}_1.fastq.gz input_reads/sample${i}_2.fastq.gz | samtools view -bh -F4 | samtools sort -o aligned_reads/sample${i}_sorted.bam
        # 索引bam文件，得到了bai文件，可以一起导入IGV
        samtools index aligned_reads/sample${i}_sorted.bam
        # 其实我觉得到这里就可以了，下一步可以直接导入IGV查看突变位点的情况
        # 检测gyrA基因的突变
        bcftools mpileup -f reference_sequence/NC_013654.fasta aligned_reads/sample${i}_sorted.bam | bcftools call -mv -Oz -o aligned_reads/sample${i}_variants.vcf.gz
        bcftools index aligned_reads/sample${i}_variants.vcf.gz
        # 检查S83L和D87N突变
        bcftools view aligned_reads/sample${i}_variants.vcf.gz | grep -E "2286204|2286193" > sample${i}_variants.txt
    done

    # BLAST检测五个抗性基因
    # 为每个样品的组装基因组创建BLAST数据库
    for assembly_dir in assemblies/sample*; do
        sample_name=$(basename "$assembly_dir" _assembly)
        contigs_file="$assembly_dir/contigs.fasta"
        # 创建BLAST数据库
        makeblastdb -in "$contigs_file" -dbtype nucl -out assembled_db/${sample_name}_db
    done

    # 对每个样品的组装基因组进行BLAST比对
    for assembly_dir in assemblies/sample*; do
        sample_name=$(basename "$assembly_dir")
        contigs_db=assembled_db/${sample_name}_db

        # 运行BLASTn
        blastn -query reference_sequence/AMR_genes.fasta \
            -db "$contigs_db" \
            -out ${sample_name}_AMR_blast_results.txt \
            -evalue 1e-10 -outfmt 6
    done
    rm -r input_reads
    rm -r reference_sequence
    rm -r kraken_db
    rm -r kraken_output
    rm -r FastQC 
    rm -r kraken_output 
    rm -r aligned_reads 
    rm -r assemblies 
    rm -r assembled_db 
    rm -r assembled_results
done