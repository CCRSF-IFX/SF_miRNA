rule multiqc:
    input: expand("Sample_{sample}/{sample}_trimmomatic_complete.txt", sample=samples), expand("Sample_{sample}/{sample}_fastqc_complete.txt", sample=samples), expand("Sample_{sample}/smrna_{sample}_fastqscreen_complete.txt", sample=samples), expand("Sample_{sample}/{sample}_fastqscreen_complete.txt", sample=samples), expand("Sample_{sample}/{sample}_mapper_complete.txt", sample=samples), expand("Sample_{sample}/{sample}_mirdeep2_complete.txt", sample=samples)
    output: projectName + "_multiqc.html"
    threads: 8
    resources:
        mem_gb_per_thread=8
    conda: 'envs/multiqc.yaml'
    shell: "multiqc -f -c {multiqcConf} -e kraken -e bowtie1 -n {output} ./"
