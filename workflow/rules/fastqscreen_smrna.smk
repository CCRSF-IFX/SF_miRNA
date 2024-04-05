def getConf_miRNA(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return config['fastqscreenConf_hsa_miRNA']
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return config['fastqscreenConf_mmu_miRNA']

rule fastqscreen_smrna:
    input: R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: outputName="Sample_{sample}/smrna_{sample}_fastqscreen_complete.txt"
    conda: 'envs/fastqscreen_smrna.yaml'
    threads: 8
    resources:
        mem_gb_per_thread=8
    params: conf_miRNA = getConf_miRNA
    shell: 'ln -sf {input.R1} Sample_{{sample}}/smRNA_{{sample}}_trimmed_R1.fastq; fastq_screen --outdir Sample_{{sample}} --threads {threads} --subset 0 --nohits --conf {params.conf_miRNA} --aligner bowtie Sample_{{sample}}/smRNA_{{sample}}_trimmed_R1.fastq 2>Sample_{{sample}}/smrna_{{sample}}_fastqscreen.err && echo "fastqscreen of {{sample}} is complete" > {output.outputName}'
