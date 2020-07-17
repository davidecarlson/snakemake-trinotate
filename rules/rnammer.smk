RNAMMERTRANS=config['RNAMMERTRANS']
RNAMMER=config['RNAMMER']

rule rnammer:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta"
    output:
        results=RESULTS + "/rnammer/{sample}/{sample}_trinity.Trinity.fasta.rnammer.gff"
    threads:
        1
    params:
        wrapper=RNAMMERTRANS + "/RnammerTranscriptome.pl",
        rnammer=RNAMMER + "/rnammer",
        indir=RESULTS + "/rnammer/{sample}"
    log:
        RESULTS + "/logs/rnammer/{sample}.rnammer.log"
    shell:
        "cd {params.indir} && "
        "{params.wrapper} --transcriptome {input.assembly} "
        "--path_to_rnammer {params.rnammer} 2> {log} "
        " && cd -"
