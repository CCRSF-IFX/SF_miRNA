rule fastqscreen:
    input: R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: outputName='Sample_{sample}/{tranckingID}_fastqscreen_complete.txt'
    conda: 'envs/fastqscreen.yaml'
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    shell: 'fastq_screen --outdir Sample_{wildcards.sample} --threads {threads} --subset 0 --nohits --conf {fastqscreenConf} --aligner bowtie {input.R1} 2> Sample_{wildcards.sample}/{wildcards.sample}_fastqscreen.err && echo "fastqscreen of {wildcards.sample} is complete" > {output.outputName}'
