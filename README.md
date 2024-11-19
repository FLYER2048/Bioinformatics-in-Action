##Bioinformatics in Action

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

|Resistance class
抗生素抗性分类|Gene|Notes|
|-|-|-|
|Cephalosporin 头孢菌素|$bla_{CTX-M-14}$ /$bla_{CTX-M-15}$ /$bla_{CTX-M-27}$|Resistance conferred by gene presence$^a$|
|Macrolide 大环内酯类|*mph*(A)|Resistance conferred by gene presence|
|Aminoglycoside 氨基糖苷类|*aadA5*|Resistance conferred by gene presence|
|Fluoroquinolone 氟喹诺酮|*gyrA*|Resistance conferred by specific mutations$^b$|

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
