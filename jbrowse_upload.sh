#!/bin/bash

set -x #for debugging


FILE="refgenomes.txt" #file with ref genomes and annotations

gene_accession_ref=""
ref_genome=""
gene_accession_gene=""
genes=""
assembly=""

while IFS= read -r line; do
        if [ -z "$line" ]; then
                if [ -n "$gene_accession"] && [ -n "$gene_accession_ref" ] &&  [ -n "$ref_genome"] && [ -n "$genes"]  && [ -n "$gene_accession_gene"]; then
                        echo "Complete Genome $gene_accession_ref being uploaded"

                        ####Downloading Data Section and uploading to Jbrowse#####

                        wget $ref_genome #download genome

                        ref_genome_name=$(basename "$ref_genome")

                        gunzip $ref_genome_name #unzip ref genome

                        ref_genome_name_fna=${ref_genome_name%.gz}

                        mv $ref_genome_name_fna $assembly #rename

                        samtools faidx $assembly #index ref genome

                        jbrowse add-assembly $assembly --out $APACHE_ROOT/jbrowse2 --load copy #load into jbrowse


                        #get genome annotations

                        wget $genes

                        genes_name=$(basename "$genes")

                        gunzip $genes_name

                        track="gene_${assembly}.gff"

                        jbrowse sort-gff $genes_name > $track #to override and add new tracks
                        bgzip $track
                        track_gz="${track}.gz"
                        tabix $track_gz

                        jbrowse add-track $track_gz --out $APACHE_ROOT/jbrowse2 --load copy --assemblyNames=$assembly #load annotation tracks to jbrowse

                        jbrowse text-index --out $APACHE_ROOT/jbrowse2 #index for search by gene
                 fi


        else
                if [ -z "$gene_accession_ref" ]; then
                        gene_accession_ref=$line
                elif [ -z "$ref_genome" ]; then
                        ref_genome="$line"
                elif [ -z "$gene_accession_gene" ]; then
                        gene_accession_gene="$line"
                elif [ -z "$genes" ]; then
                        genes="$line"
                else 
                        assembly="$line"
                fi
            fi
#make sure the file ends with an empty line
        done < "$FILE"

