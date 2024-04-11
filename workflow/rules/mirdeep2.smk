def getReference(wildcards):
    if samplepd['reference'][wildcards.sample] == 'hg38':
        return {'mirdeep2_genome': config['mirdeep2_hsa_genome'], 'mature_miRNA': config["mature_hsa_miRNA"], 'hairpin_miRNA': config["hairpin_hsa_miRNA"], 'mature_miRNA_fileName': os.path.basename(config["mature_hsa_miRNA"]), 'hairpin_miRNA_fileName': os.path.basename(config["hairpin_hsa_miRNA"]), 'organism': 'HUMAN'}
    elif samplepd['reference'][wildcards.sample] == 'mm10':
        return {'mirdeep2_genome': config['mirdeep2_mmu_genome'], 'mature_miRNA': config["mature_mmu_miRNA"], 'hairpin_miRNA': config["hairpin_mmu_miRNA"], 'mature_miRNA_fileName': os.path.basename(config["mature_mmu_miRNA"]), 'hairpin_miRNA_fileName': os.path.basename(config["hairpin_mmu_miRNA"]), 'organism': 'MOUSE'}

rule mirdeep2:
    input: collapsed_fa = "Sample_{sample}/{sample}_collapsed.fa", trimmed_arf = "Sample_{sample}/{sample}_trimmed.arf"
    output: "Sample_{sample}/{tranckingID}_mirdeep2_complete.txt"
    singularity: 'docker://btrspg/mirdeep2:latest'
    params: reference=getReference
    threads: 8
    resources:
        partition='norm',
        mem='64GB',
        time='48:00:00'
    shell: 'ln -f {params.reference[mature_miRNA]} Sample_{wildcards.sample}/; ln -f {params.reference[hairpin_miRNA]} Sample_{wildcards.sample}/; cd Sample_{wildcards.sample}; miRDeep2.pl {wildcards.sample}_collapsed.fa {params.reference[mirdeep2_genome]} {wildcards.sample}_trimmed.arf {params.reference[mature_miRNA_fileName]} none {params.reference[hairpin_miRNA_fileName]} -z {wildcards.sample} -t {params.reference[organism]} -P 2>{wildcards.sample}_mirdeep2.log; grep known result_*.bed > known.bed; grep novel result_*.bed > novel.bed; cat result_*.csv > {wildcards.sample}_mirdeep2.txt; echo "mirdeep2 of {wildcards.sample} is complete" > {wildcards.sample}_mirdeep2_complete.txt'
