TRINOTATE=config['TRINOTATE']

rule load_results:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        map=INPUT + "/{sample}_trinity.Trinity.fasta.gene_trans_map",
        sample_DB=RESULTS + "/DBs/{sample}.Trinotate.sqlite",
        peps=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep",
        blastp=RESULTS + "/blastp/{sample}.blastp.outfmt6",
        blastx=RESULTS + "/blastx/{sample}.blastx.outfmt6",
        hmmer=RESULTS + "/hmmer/{sample}.TrinotatePFAM.out",
        signalp=RESULTS + "/signalp/{sample}.signalp.out",
        tmhmm=RESULTS + "/tmhmm/{sample}.tmhmm.out",
        rnammer=RESULTS + "/rnammer/{sample}/{sample}_trinity.Trinity.fasta.rnammer.gff"

    output:
        check=RESULTS + "/DBs/{sample}.load_results.ok"
    threads:
        1
    params:
        prog=TRINOTATE + "/Trinotate"
    log:
        RESULTS + "/logs/load_results/{sample}.log"
    shell:
        "{params.prog} {input.sample_DB} init --gene_trans_map {input.map} "
        "--transcript_fasta {input.assembly} --transdecoder_pep {input.peps} 2> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_swissprot_blastp {input.blastp} 2>> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_swissprot_blastx {input.blastx} 2>> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_pfam {input.hmmer} 2>> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_tmhmm {input.tmhmm} 2>> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_signalp {input.signalp} 2>> {log} "
        "&& {params.prog} {input.sample_DB} LOAD_rnammer {input.rnammer} 2>> {log} "
        "&& touch {output.check}"
