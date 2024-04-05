# SF miRNA Mapping and Abundance Estimation
This repository contains workflows/scripts for processing Illumina short reads of small RNA librarires, mapping reads to the reference gneome and the miRNA database, and estimating the abundance of miRNAs.

## Description
The pipeline is designed to trim sequencing adapters from raw reads and map trimmed reads to the reference genome and the miRNA datase (including hapirins and mature miRNAs). The abudance of known/novel miRNAs is estimated according to the number of mapped reads.
![SF miRNA](/resource/miRNA_Workflow.png)
## Tools Used in the Pipeline
The Snakemake pipeline utilizes a series of tools designed for processing sequencing data:

1. **Trimmomatic**: Trims sequencing adapters from raw reads for downstream processing.

2. **FastQC**: Generates reports of sequence quality, GC content, length distribution and adapter content for quality control.

3. **FastQScreen**: Generates reports of reads mapped to a set of reference databases to check the composition of the library.

4. **miRDeep2**: Maps reads to the reference genome and the miRNA database (miRBase: https://mirbase.org/) to estimate the abundance of miRNAs.

5. **MultiQC**: Aggregates the results from multiple Bioinformatics tools across samples into a single report for visualiztion.

## Features
This repository presents a streamlined Snakemake pipeline to map reads of small RNA libraries and estimate the abundance of miRNAs for downstream analysis. Key features include:

- **Reads Processing**: Utilizes Trimmomatic to trim sequencing adapters from raw reads.
- **Quality Control**: Utilizes FastQC/FastQScreen to check sequencing contents and library compositions.
- **Mapping and Abundance Estimation**: Utizlizes miRDeep2 to aggregate results of Bowtie, RNAFold, and ranfold for abundance estimation of miRNAs.

This pipeline provides a complete solution to estimate the abundance of miRNAs for downstream analysis.

## Usage

### Step 1: Obtain a Copy of the Workflow

 **Clone the Repository**: Clone the new repository to your local machine, choosing the directory where you want to perform data analysis. Instructions for cloning can be found [here](https://help.github.com/en/articles/cloning-a-repository).

### Step 2: Configure the Workflow
Tailor the workflow to your project's requirements:
- Edit `config.yaml` in the `config/` directory to set up the workflow execution parameters.
- Modify `samples.tsv` to outline your sample setup, ensuring it reflects your specific data structure and requirements.

### Step 3: Install Snakemake and Singularity
Install Snakemake via conda with the following command:
```bash
conda create -c bioconda -c conda-forge -n snakemake snakemake
```

### Step 4: Execute the Workflow

1. **Activate the Conda Environment and load the module of Singularity**:
    ```bash
    conda activate snakemake
    module load singularity
    ```

2. **Test the Configuration**:
    Perform a dry-run to validate your setup:
    ```bash
    snakemake --use-conda --use-singularity -n
    ```

3. **Local Execution**:
    Execute the workflow on your local machine using `$N` cores:
    ```bash
    snakemake --use-conda --use-singularity --cores $N
    ```
    Here, `$N` represents the number of cores you wish to allocate for the workflow.

4. **Cluster Execution**:
    For cluster environments, submit the workflow as follows:
    ```bash
    snakemake --use-conda --use-singularity --cluster slurm --jobs 100
    ```
    Replace `100` with the number of jobs you intend to submit simultaneously. Ensure your cluster environment is correctly configured to handle Snakemake jobs.

## Output

Upon successful execution, the integrated pipeline comprising the two scripts generates a comprehensive set of files, encapsulating both raw and processed data alongside insightful visualizations.
