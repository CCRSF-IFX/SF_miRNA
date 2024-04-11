def getConf_miRNA(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return config['fastqscreenConf_hsa_miRNA']
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return config['fastqscreenConf_mmu_miRNA']

rule fastqscreen_smrna:
    input: R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: outputName="Sample_{sample}/{tranckingID}_fastqscreen_smrna_complete.txt"
    conda: 'envs/fastqscreen_smrna.yaml'
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    params: conf_miRNA = getConf_miRNA
    shell: 'ln -sf {wildcards.sample}_trimmed_R1.fastq Sample_{wildcards.sample}/smRNA_{wildcards.sample}_trimmed_R1.fastq; fastq_screen --outdir Sample_{wildcards.sample} --threads {threads} --subset 0 --nohits --conf {params.conf_miRNA} --aligner bowtie Sample_{wildcards.sample}/smRNA_{wildcards.sample}_trimmed_R1.fastq 2>Sample_{wildcards.sample}/{wildcards.sample}_fastqscreen_smrna.err && echo "fastqscreen of {wildcards.sample} is complete" > {output.outputName}'
