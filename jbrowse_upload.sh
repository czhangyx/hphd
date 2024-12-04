#!/bin/bash

set -x #for debugging

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/858/285/GCF_000858285.1_ViralProj15198/GCF_000858285.1_ViralProj15198_genomic.fna.gz #download genome

gunzip GCF_000858285.1_ViralProj15198_genomic.fna.gz #unzip ref genome

mv GCF_000858285.1_ViralProj15198_genomic.fna vzv.fna #rename

samtools faidx vzv.fna #index ref genome

jbrowse add-assembly vzv.fna --out $APACHE_ROOT/jbrowse2 --load copy #load into jbrowse


#get genome annotations

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/858/285/GCF_000858285.1_ViralProj15198/GCF_000858285.1_ViralProj15198_genomic.gff.gz 

gunzip GCF_000858285.1_ViralProj15198_genomic.gff.gz 

jbrowse sort-gff GCF_000858285.1_ViralProj15198_genomic.gff.gz > genes.gff
bgzip genes.gff
tabix genes.gff.gz

jbrowse add-track genes.gff.gz --out $APACHE_ROOT/jbrowse2 --load copy --assemblyNames=vzv.fna #load annotation tracks to jbrowse

jbrowse text-index --out $APACHE_ROOT/jbrowse2 #index for search by gene



  
