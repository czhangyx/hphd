#!/bin/bash

set -x #for debugging

read -p "Enter name of isolate you want to upload: " FILE
read -p "Enter reference genome:" reference


gene_accession_ref=""
ref_genome=""
gene_accession_gene=""
genes=""
assembly=""

counter=0

while IFS= read -r line; do
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]]; then
                continue
        fi

        ((counter++)) #want to make sure we read 5 lines at a time

        case "$counter" in
                1) gene_accession_ref=$(awk '{$1=$1};1' <<< "$line") ;;
                2) ref_genome=$(awk '{$1=$1};1' <<< "$line") ;;
                3) gene_accession_gene=$(awk '{$1=$1};1' <<< "$line") ;;
                4) genes=$(awk '{$1=$1};1' <<< "$line") ;;
                5) 
                        assembly=$(awk '{$1=$1};1' <<< "$line")
                        assembly="${assembly}.fna"
        
                        echo "Complete Genome Accession Reference: $gene_accession_ref"
                        echo "Reference Genome ftp link: $ref_genome"
                        echo "Gene annotations accession Reference: $gene_accession_gene"
                        echo "Gene annotations gff files: $genes"
                        echo "Assembly Name: $assembly"


                        #get genome annotations

                        wget "$genes"

                        genes_name=$(basename "$genes")

                        gunzip "$genes_name"

                        genes_name="${genes_name::-3}"

                        track="gene_${assembly}.gff"

                        jbrowse sort-gff "$genes_name" > "$track" #to override and add new tracks
                        bgzip "$track"
                        track_gz="${track}.gz"
                        tabix "$track_gz"

                        jbrowse add-track "$track_gz" --out $APACHE_ROOT/jbrowse2 --load copy --assemblyNames="$reference" --force #load annotation tracks to jbrowse

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
