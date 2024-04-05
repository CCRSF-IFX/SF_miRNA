from snakemake.utils import validate
import pandas as pd

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
#singularity: "docker://continuumio/miniconda3"

##### load config and sample sheets #####

configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

samplepd = pd.read_csv(config["samples"], sep=",").set_index("sampleName", drop=False)
samplepd.index.names = ["sampleName"]
#validate(samplepd, schema="../schemas/samples.schema.yaml")

analysis = config['analysispath']
projectName = config['projectname']
fastqscreenConf = config['fastqscreenConf']
multiqcConf = config['multiqcConf']
samples = samplepd["sampleName"].to_list()

adapters = config['adapters']
#whitelist = config.whitelist
