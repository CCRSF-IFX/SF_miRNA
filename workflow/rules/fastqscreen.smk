rule fastqscreen:
    input: R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: outputName='Sample_{sample}/{sample}_fastqscreen_complete.txt'
    conda: 'envs/fastqscreen.yaml'
    threads: 8
    resources:
        mem_gb_per_thread=8
    shell: 'fastq_screen --outdir Sample_{{sample}} --threads {threads} --subset 0 --nohits --conf {fastqscreenConf} --aligner bowtie {input.R1} 2> Sample_{{sample}}/{{sample}}_fastqscreen.err && echo "fastqscreen of {{sample}} is complete" > {output.outputName}'
