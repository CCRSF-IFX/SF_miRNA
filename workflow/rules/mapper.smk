def getRefGen(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return Path(str(pathlib.PurePath(config['refgen_hsa_miRNA']).parent)).resolve() / pathlib.PurePath(config['refgen_hsa_miRNA']).name
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return Path(str(pathlib.PurePath(config['refgen_mmu_miRNA']).parent)).resolve() / pathlib.PurePath(config['refgen_mmu_miRNA']).name

rule mapper:
    input: R1 = 'Sample_{sample}/{sample}_trimmed_R1.fa'
    output: collapsed_fa=temp("Sample_{sample}/{tranckingID}_collapsed.fa"), trimmed_arf=temp("Sample_{sample}/{tranckingID}_trimmed.arf"), outputName="Sample_{sample}/{tranckingID}_mapper_complete.txt"
    singularity: 'docker://btrspg/mirdeep2:latest'
    params: refgen_miRNA=getRefGen
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    shell: 'echo -e "{wildcards.sample}_trimmed_R1.fa\txyz" > Sample_{wildcards.sample}/config.txt; cd Sample_{wildcards.sample}; mapper.pl config.txt -d -c -j -l 18 -m -q -p {params.refgen_miRNA} -s {wildcards.sample}_collapsed.fa -t {wildcards.sample}_trimmed.arf -v -o {threads} 2>{wildcards.sample}_run_bowtie_trimmed.log 1>{wildcards.sample}_run_bowtie_trimmed.err; echo "mapper of {wildcards.sample} is complete" > {wildcards.sample}_mapper_complete.txt'
