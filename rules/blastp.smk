rule blastp:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        peps=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep"
    output:
        results=RESULTS + "/blastp/{sample}.blastp.outfmt6"
    threads:
        8
    params:
        uniprot=DB +"/uniprot_sprot.pep",
        max=1,
        fmt=6,
        evalue=1e-3
    log:
        RESULTS + "/logs/blastp/{sample}.blastx.log"
    shell:
        "blastp -query {input.peps} -db {params.uniprot} "
        "-num_threads {threads} -max_target_seqs {params.max} "
        "-outfmt {params.fmt} -evalue {params.evalue} > {output.results} 2> {log}"
