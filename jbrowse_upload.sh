#!/bin/bash

set -x #for debugging


FILE="refgenomes.txt" #file with ref genomes and annotations

gene_accession_ref=""
ref_genome=""
gene_accession_gene=""
genes=""
assembly=""

counter=0

while IFS= read -r line || [ -n "$line" ]; do
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]]; then
                continue
        fi

        ((counter++)) #want to make sure we read 5 lines at a time

        case "$counter" in
                1) gene_accession_ref="$line" ;;
                2) ref_genome="$line" ;;
                3) gene_accession_gene="$line" ;;
                4) genes="$line" ;;
                5) 
                        assembly="$line" ;;
        
                        echo "Complete Genome Accession Reference: $gene_accession_ref"
                        echo "Reference Genome ftp link: $ref_genome"
                        echo "Gene annotations accession Reference: $gene_accession_gene"
                        echo "Gene annotations gff files: $genes"
                        echo "Assembly Name: $assembly"

                        ####Downloading Data Section and uploading to Jbrowse#####

                        wget "$ref_genome" #download genome

                        ref_genome_name=$(basename "$ref_genome")

                        gunzip "$ref_genome_name" #unzip ref genome

                        ref_genome_name_fna=${ref_genome_name%.gz}

                        mv "$ref_genome_name_fna" "$assembly" #rename

                        samtools faidx "$assembly" #index ref genome

                        jbrowse add-assembly "$assembly" --out $APACHE_ROOT/jbrowse2 --load copy #load into jbrowse


                        #get genome annotations

                        wget "$genes"

                        genes_name=$(basename "$genes")

                        gunzip "$genes_name"

                        track="gene_${assembly}.gff"

                        jbrowse sort-gff "$genes_name" > "$track" #to override and add new tracks
                        bgzip "$track"
                        track_gz="${track}.gz"
                        tabix "$track_gz"

                        jbrowse add-track "$track_gz" --out $APACHE_ROOT/jbrowse2 --load copy --assemblyNames="$assembly" #load annotation tracks to jbrowse

                        jbrowse text-index --out $APACHE_ROOT/jbrowse2 #index for search by gene

                        gene_accession_ref=""
                        ref_genome=""
                        gene_accession_gene=""
                        genes=""
                        assembly=""

                        counter=0
                        ;;
                esac
        
#make sure the file ends with an empty line
done < "$FILE"

