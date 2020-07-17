# only use 2 threads because hmmscan is limited by I/O and using more than 2 cores doesn't lead to better performance

rule hmmer:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        peps=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep"
    output:
        results=RESULTS + "/hmmer/{sample}.TrinotatePFAM.out"
    threads:
        2
    params:
        pfam=DB +"/Pfam-A.hmm"
    log:
        RESULTS + "/logs/hmmer/{sample}.signal.log"
    shell:
        "hmmscan --cpu {threads} --domtblout {output.results} "
        " {params.pfam} {input.peps} > {log}"
