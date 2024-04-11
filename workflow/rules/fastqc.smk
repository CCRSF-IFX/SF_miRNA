rule fastqc:
    input: R1_orig='fastq/{sample}_R1_001.fastq.gz', R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: forward="Sample_{sample}/{tranckingID}_trimmed_R1_fastqc.html", logname="Sample_{sample}/{tranckingID}_run_fastqc.err", outputName="Sample_{sample}/{tranckingID}_fastqc_complete.txt"
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    conda: 'envs/fastqc.yaml'
    shell: 'fastqc -o Sample_{wildcards.sample} --noextract -k 5 -t {threads} -f fastq {input.R1_orig} {input.R1} 2>{output.logname} && echo "fastqc of {wildcards.sample} is complete" > {output.outputName}'
