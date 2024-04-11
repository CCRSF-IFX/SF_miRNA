#!/bin/bash
#SBATCH --partition=norm
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=4g
#SBATCH --mail-user=username@nih.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --time=96:00:00
#SBATCH --no-requeue
#SBATCH --job-name=submit.sh
snakemake --use-singularity --singularity-args '--bind /path/to/bind/in/singularity' --profile config/ >& snakemake.log
