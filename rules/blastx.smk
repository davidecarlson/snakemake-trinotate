rule blastx:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
    output:
        results=RESULTS + "/blastx/{sample}.blastx.outfmt6"
    threads:
        8
    params:
        uniprot=DB +"/uniprot_sprot.pep",
        max=1,
        fmt=6,
        evalue=1e-3
    log:
        RESULTS + "/logs/blastx/{sample}.blastx.log"
    shell:
        "blastx -query {input.assembly} -db {params.uniprot} "
        "-num_threads {threads} -max_target_seqs {params.max} "
        "-outfmt {params.fmt} -evalue {params.evalue} > {output.results} 2> {log}"
