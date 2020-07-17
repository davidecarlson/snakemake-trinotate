TRANSDECODER=config['TRANSDECODER']

rule transdecoder_long:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        map=INPUT + "/{sample}_trinity.Trinity.fasta.gene_trans_map"
    output:
        pep=RESULTS + "/transdecoder/{sample}/longest_orfs.pep"
    threads:
        1
    params:
        prog=TRANSDECODER + "/TransDecoder.LongOrfs",
        outdir=RESULTS + "/transdecoder/{sample}"
    log:
        RESULTS + "/logs/transdecoder/{sample}.longestorfs.log"
    shell:
        "{params.prog} -t {input.assembly} --gene_trans_map {input.map} "
        "--output_dir {params.outdir} 2> {log}"

rule transdecoder_predict:
    input:
        assembly=INPUT + "/{sample}_trinity.Trinity.fasta",
        pep=RESULTS + "/transdecoder/{sample}/longest_orfs.pep",
    output:
        final_pep=RESULTS + "/transdecoder/{sample}/{sample}_trinity.Trinity.fasta.transdecoder.pep"        
    threads:
        1
    params:
        prog=TRANSDECODER + "/TransDecoder.Predict",
        outdir=RESULTS + "/transdecoder/{sample}",
        indir=RESULTS + "/transdecoder/{sample}"
    threads:
        1
    log:
        RESULTS + "/logs/transdecoder/{sample}.predict.log"
    shell:
        "cd {params.indir} && "
        "{params.prog} -t {input.assembly} --output_dir {params.outdir} 2> {log}"
        " && cd -"
