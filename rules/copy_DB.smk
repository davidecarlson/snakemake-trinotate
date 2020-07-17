rule copy_DB:
    input:
        DB=DB + "/Trinotate.sqlite",
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta"
    output:
        sample_DB=RESULTS + "/DBs/{sample}.Trinotate.sqlite"
    threads:
        1
    shell:
        "cp {input.DB} {output.sample_DB}"
