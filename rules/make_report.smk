TRINOTATE=config['TRINOTATE']

rule report:
    input:
        sample_DB=RESULTS + "/DBs/{sample}.Trinotate.sqlite",
        check=RESULTS + "/DBs/{sample}.load_results.ok"
    output:
        report=RESULTS + "/reports/{sample}.trinotate_annotation_report.tsv"
    threads:
        1
    params:
        prog=TRINOTATE + "/Trinotate"
    log:
        RESULTS + "/logs/reports/{sample}.report.log"
    shell:
        "{params.prog} {input.sample_DB} report > {output.report} 2> {log}"
