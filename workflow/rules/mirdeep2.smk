def getReference(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return {'mirdeep2_genome': config['mirdeep2_hsa_genome'], 'mature_miRNA': config['mature_hsa_miRNA'], 'hairpin_miRNA': config['hairpin_hsa_miRNA'], 'organism': 'HUMAN'}
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return {'mirdeep2_genome': config['mirdeep2_mmu_genome'], 'mature_miRNA': config['mature_mmu_miRNA'], 'hairpin_miRNA': config['hairpin_mmu_miRNA'], 'organism': 'MOUSE'}

rule mirdeep2:
    input: collapsed_fa = "Sample_{sample}/{sample}_collapsed.fa", trimmed_arf = "Sample_{sample}/{sample}_trimmed.arf"
    output: "Sample_{sample}/{sample}_mirdeep2_complete.txt"
    singularity: 'docker://bunop/mirdeep2:latest'
    params: reference=getReference
    threads: 8
    resources:
        mem_gb_per_thread=8
    shell: 'cd Sample_{{sample}}; miRDeep2.pl {{sample}}_collapsed.fa {params.reference[mirdeep2_genome]} {{sample}}_trimmed.arf {params.reference[mature_miRNA]} none {params.reference[hairpin_miRNA]} -z {{sample}} -t {params.reference[organism]} -P 2>{{sample}}_mirdeep2.log; grep known result_*.bed > known.bed; grep novel result_*.bed > novel.bed; cat result_*.csv > {{sample}}_mirdeep2.txt; echo "mirdeep2 of {{sample}} is complete" > {output}'
