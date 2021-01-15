import shutil

configfile:
    "config.yaml"

# read config file to get run-specific informatoin

INPUT=config['assemblies']
#print(INPUT)

DB=config['DB']

SAMPLES, = glob_wildcards(INPUT + "/{id}_trinity.Trinity.fasta")
#print(SAMPLES)

RESULTS = config['results_loc']
print("Output will be found in the following directory:", RESULTS)

onstart:
	print("The samples used in this analysis are:"),
	print(SAMPLES),
	print("Running the Trinotate annotation pipeline") 


rule all:
    input:
        expand(RESULTS + "/DBs/{sample}.Trinotate.sqlite", sample=SAMPLES),
        expand(RESULTS + "/transdecoder/{sample}/longest_orfs.pep", sample=SAMPLES),
        expand(RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep", sample=SAMPLES),
        expand(RESULTS + "/blastx/{sample}.blastx.outfmt6", sample=SAMPLES),
        expand(RESULTS + "/blastp/{sample}.blastp.outfmt6", sample=SAMPLES),
        expand(RESULTS + "/hmmer/{sample}.TrinotatePFAM.out", sample=SAMPLES),
        expand(RESULTS + "/signalp/{sample}.signalp.out", sample=SAMPLES),
        expand(RESULTS + "/tmhmm/{sample}.tmhmm.out", sample=SAMPLES),
        expand(RESULTS + "/rnammer/{sample}/{sample}_trinity.Trinity.fasta.rnammer.gff", sample=SAMPLES),
        expand(RESULTS + "/DBs/{sample}.load_results.ok", sample=SAMPLES),
        expand(RESULTS + "/reports/{sample}.trinotate_annotation_report.tsv", sample=SAMPLES)
	
include:        "rules/copy_DB.smk"
include:        "rules/transdecoder.smk"
include:        "rules/blastx.smk"
include:        "rules/blastp.smk"
include:        "rules/hmmer.smk"
include:        "rules/signalp.smk"
include:        "rules/tmhmm.smk"
include:        "rules/rnammer.smk"
include:        "rules/load_results.smk"
include:        "rules/make_report.smk"

onsuccess:
	print("Transcriptome annotation finished!")
	shutil.rmtree(".snakemake")
