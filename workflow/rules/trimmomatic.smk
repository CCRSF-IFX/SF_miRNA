# Python scripts to extract barcodes and output results.
rule trimmomatic:
    input: 'fastq/{sample}_R1_001.fastq.gz'
    output: R1_fq=temp('Sample_{sample}/{tranckingID}_trimmed_R1.fastq'), R1=temp('Sample_{sample}/{tranckingID}_trimmed_R1.fa'), logname='Sample_{sample}/{tranckingID}_trimmomatic.err', outputName='Sample_{sample}/{tranckingID}_trimmomatic_complete.txt'
    conda: 'envs/trimmomatic.yaml'
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    shell: 'trimmomatic SE -threads {threads} -phred33 {input} {output.R1_fq} ILLUMINACLIP:{adapters}:2:36:10 LEADING:10 TRAILING:10 MAXINFO:50:0.97 MINLEN:17 CROP:27 2>{output.logname} && sed -n "1~4s/^@/>/p;2~4p" {output.R1_fq} | sed "s/ /_/g" > {output.R1} && echo "trimmomatic of {wildcards.sample} is complete" > {output.outputName}'
