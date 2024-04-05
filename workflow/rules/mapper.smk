def getRefGen(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return config['refgen_hsa_miRNA']
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return config['refgen_mmu_miRNA']

rule mapper:
    input: R1 = 'Sample_{sample}/{sample}_trimmed_R1.fa'
    output: collapsed_fa=temp("Sample_{sample}/{sample}_collapsed.fa"), trimmed_arf=temp("Sample_{sample}/{sample}_trimmed.arf"), outputName="Sample_{sample}/{sample}_mapper_complete.txt"
    singularity: 'docker://bunop/mirdeep2:latest'
    params: refgen_miRNA=getRefGen
    threads: 8
    resources:
        mem_gb_per_thread=8
    shell: 'echo -e "{{sample}}_trimmed_R1.fa\txyz" > Sample_{{sample}}/config.txt; cd Sample_{{sample}}; mapper.pl config.txt -d -c -j -l 18 -m -q -p {params.refgen_miRNA} -s {{sample}}_collapsed.fa -t {{sample}}_trimmed.arf -v -o {threads} 2>{{sample}}_run_bowtie_trimmed.log 1>{{sample}}_run_bowtie_trimmed.err; echo "mapper of {{sample}} is complete" > {output.outputName}'
