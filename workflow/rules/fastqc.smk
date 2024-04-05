rule fastqc:
    input: R1_orig='fastq/{sample}_R1_001.fastq.gz', R1='Sample_{sample}/{sample}_trimmed_R1.fastq'
    output: forward="Sample_{sample}/{sample}_trimmed_R1_fastqc.html", logname="Sample_{sample}/{sample}_run_fastqc.err", outputName="Sample_{sample}/{sample}_fastqc_complete.txt"
    threads: 8
    conda: 'envs/fastqc.yaml'
    resources:
        mem_gb_per_thread=8
    shell: 'fastqc -o Sample_{{sample}} --noextract -k 5 -t {threads} -f fastq {input.R1_orig} {input.R1} 2>{output.logname} && echo "fastqc of {{sample}} is complete" > {output.outputName}'
