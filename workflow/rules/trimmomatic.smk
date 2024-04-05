# Python scripts to extract barcodes and output results.
rule trimmomatic:
    input: 'fastq/{sample}_R1_001.fastq.gz'
    #output: f'Sample_{{sample}}/{{sample}}_trimmomatic_complete.txt'
    output: R1_fq=temp('Sample_{sample}/{sample}_trimmed_R1.fastq'), R1=temp('Sample_{sample}/{sample}_trimmed_R1.fa'), logname='Sample_{sample}/{sample}_trimmomatic.err', outputName='Sample_{sample}/{sample}_trimmomatic_complete.txt'
    conda: 'envs/trimmomatic.yaml'
    threads: 8
    resources:
        mem_gb_per_thread=8
    shell: 'trimmomatic SE -threads {threads} -phred33 {input} {output.R1_fq} ILLUMINACLIP:{adapters}:2:36:10 LEADING:10 TRAILING:10 MAXINFO:50:0.97 MINLEN:17 CROP:27 2>{output.logname} && sed -n "1~4s/^@/>/p;2~4p" {output.R1_fq} | sed "s/ /_/g" > {output.R1} && echo "trimmomatic of {{sample}} is complete" > {output.outputName}'
