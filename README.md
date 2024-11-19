# Bioinformatics in Action

One application of bioinformatics is in the use of whole-genome sequencing for clinical microbiology diagnostics. Bacteria from an infection can be isolated and sequenced. The genomic data can then be queried for specific features in order to guide the most effective treatment. These features include antibiotic resistance genes, as well as markers that identify which species the bacterial isolate belongs to. This information can then be used to inform the most appropriate antibiotic(s) for treating the infection.

In this project, you will be given whole-genome sequencing data from several bacterial infections. Your job is to determine which bacterial species is responsible for each infection and which antibiotics could be used for treatment. 在本项目，您将获得来自以下来源的全基因组测序数据几种细菌感染。您的工作是确定哪个细菌种类是造成每次感染的原因，而抗生素可用于治疗。

**Bioinformatics in Action** assessment consists of **three parts**:

- **Part 1:** Group oral presentation

- **Part 2:** Group peer feedback

- **Part 3**: Individual short report

**Bioinformatics in Action: Part 1 Group Oral Presentation**

**In groups** you will analyse the given data sets and produce a group **presentation** (to be presented live during one of your classes). You will also need to submit a transcript of your presentation (submitted online by one group member on behalf of the group).

Each group will be provided with **four Illumina sequencing datasets**, each one **sequenced from a single pathogen isolate**.
Your **task** is to **determine which antibiotics may be effective** in treating these infections (or whether the isolates are resistant to all available antibiotics). 您的**任务**是**确定哪些抗生素可能有效** 治疗这些感染（或 分离株是否对所有可用的抗生素耐药）。

For the purposes of this assignment, you will focus on a single bacterial species (*Escherichia coli*), and a specific set of antibiotic resistance determinants, as detailed in the following table:

|Resistance class 抗生素抗性分类|Gene|Notes|
|-|-|-|
|Cephalosporin 头孢菌素|$bla_{CTX-M-14}$ / $bla_{CTX-M-15}$ / $bla_{CTX-M-27}$|Resistance conferred by gene presence $^a$|
|Macrolide 大环内酯类|*mph*(A)|Resistance conferred by gene presence|
|Aminoglycoside 氨基糖苷类|*aadA5*|Resistance conferred by gene presence|
|Fluoroquinolone 氟喹诺酮|*gyrA*|Resistance conferred by specific mutations $^b$|

a. Resistance is conferred by the presence of any one of these genes (i.e. $bla_{CTX-M-14}$ or $bla_{CTX-M-15}$ or $bla_{CTX-M-27}$ or any combination thereof).

b. *gyrA* is a core chromosomal gene in *E. coli*, with either or both of the following mutations known to confer fluoroquinolone resistance: S83L (i.e. substitution of Serine to Leucine at amino acid position 83) and D87N (substitution of Aspartic Acid to Asparagine at position 87). You will be provided with a reference sequence for the *E. coli* strain SE15 (NC_013654.fasta). SE15 is wildtype for *gyrA* (i.e. it encodes Serine at amino acid position 83 and Aspartic Acid at position 87). The nucleotide sequence for *gyrA* is found on the ***reverse strand*** at positions 2283824-2286451 in the SE15 reference. The S83L amino acid substitution corresponds to a G→A nucleotide substitution at position 2286204 in the reference (a TCG→TTG codon change). The D87N amino acid substitution corresponds to a C→T nucleotide substitution at position 2286193 in the reference (a GAC→AAC codon change).



Using the bioinformatic tools you have learned about in this course, you will analyse the datasets to:

1. determine the bacterial species for each dataset  **确定每个数据集的细菌种类**

2. determine antibiotic resistance profiles for all *Escherichia coli* isolates (you do not need to do this step for other bacterial species) 1. **确定所有*大肠杆菌*分离株的抗生素耐药性概况（您 不需要对其他细菌种类执行此步骤）**

You will present your results in a group presentation (***maximum* 5 minutes**). **Each group member** should present for approximately **equal time**, so you should divide up the presentation content accordingly.

In your presentation, you should **explain:**

- the **research question** you are addressing,

- your **approach** for each step of the analysis,

- the **results** you obtained, and your interpretation of the results.

You should include **simple, concise visual aids** to support your presentation – at a minimum these should display the code that you ran for your analysis.

You will give your **presentation** *live during class*, and provide an *online submission* of your **transcript**.

**Weighting**: 20%

**Transcript Online Submission Due**: 18/11/2024, 10:00pm.

---

# HOW TO START

Copy BIA.sh into your work directory, then run `BIA.sh`.

# SH File Overview

This Bash script is designed for processing BIA (antibiotic resistance genes) group data. The main steps of the script include data preparation, species identification, genome assembly, mutation detection, and BLAST alignment for resistance genes. Below is a detailed explanation of each step:

## 1. Create Directory Structure

- **Create Main Directory**: Creates a folder named `BIA_groups` in the user's home directory.
- **Loop to Create Group Directories**: For each group (1 to 11), it creates corresponding subfolders (e.g., `group_1`, `group_2`, ...) and within each group, the following directories are created:
  - `input_reads`: To store raw sequencing data.
  - `reference_sequence`: To store reference sequence files.
  - `kraken_db`: To store the Kraken database.
  - `FastQC`: To store quality control results.
  - `kraken_output`: To store Kraken classification results.
  - `aligned_reads`: To store the sorted BAM files after alignment.
  - `assemblies`: To store the assembly results of the genomes.
  - `assembled_db`: To store the BLAST database of the assembled results.
  - `assembled_results`: To store results of the BLAST analysis for resistance genes.

## 2. Data Copying

The script copies the sample sequencing data (`.gz` files) and resistance gene/reference sequence files (`.fasta` files) from specified paths into their respective folders.

## 3. Species Identification

- **Activate Kraken Environment**: The script activates the Kraken environment using `conda` for species identification.
- **Kraken Analysis**:
  - For each sample, `kraken2` is used to perform species identification and generate classification reports.
  - `bracken` is used to process the Kraken reports for species abundance analysis.
  - The first few lines of the results for each sample are saved in a text file named according to the sample number.

## 4. Genome Assembly

- The script uses the `spades.py` tool to assemble the sequencing data for each sample, generating the assembled genome files.

## 5. Mutation Detection

- **BWA Alignment**:
  - The `bwa` tool is used to align the sample sequencing data with the reference genome, producing sorted BAM files.
  - `samtools` is used to index the BAM files.
  
- **VCF Variant Calling**:
  - The `bcftools` tool is used to detect mutations in the `gyrA` gene, and variant information is saved in a text file.

## 6. Antibiotic Resistance Gene BLAST Detection

- **Create BLAST Database**: A BLAST database is created for the assembled genomes of each sample.
- **Resistance Gene Alignment**:
  - Each sample undergoes BLAST alignment, comparing against predefined antibiotic resistance gene sequences, with results stored in a text file.

## 7. Cleanup

After completing all analyses, the script removes temporary folders to save space.

## Environment Requirements

- The script requires the installation of `conda` and the following tools:
  - Kraken
  - SPAdes
  - BWA
  - SAMtools
  - BCFtools
  - BLAST

This script enhances the efficiency of processing microbiome data through automation, facilitating subsequent analyses.
