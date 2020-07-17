TMHMM=config['TMHMM']

rule tmhmm:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        peps=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep"
    output:
        results=RESULTS + "/tmhmm/{sample}.tmhmm.out"
    threads:
        1
    params:
        prog=TMHMM +"/tmhmm"
    log:
        RESULTS + "/logs/tmhmm/{sample}.tmhmm.log"
    shell:
        "{params.prog} --short < {input.peps} > {output.results} 2> {log}"
