SIGNALP=config['SIGNALP']

rule signalp:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        peps=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep"
    output:
        results=RESULTS + "/signalp/{sample}.signalp.out"
    threads:
        1
    params:
        prog=SIGNALP +"/signalp",
        format="short"
    log:
        RESULTS + "/logs/signalp/{sample}.signalp.log"
    shell:
        "{params.prog} -f {params.format} -n {output.results} {input.peps} > {log}"
