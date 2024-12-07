from Bio import Entrez
import time


Entrez.email = "czhangyx@berkeley.edu"

prefixes = ['hsv1', 'hsv2', 'vzv', 'hcmv', 'hhv6a', 'hhv6b', 'hhv7', 'ebv', 'kshv']
for prefix in prefixes:
    # Parse accession numbers
    accessions = []
    with open(f'isolate_info/{prefix}_nums.txt', 'r') as f:
        accessions.extend([line.strip() for line in f])

    # Retrieve required information 
    data = []
    for accession in accessions:
        handle = Entrez.esearch(db='Assembly', term=accession)
        result = Entrez.read(handle)
        if not result['IdList']:
            continue
        search_id = result['IdList'][0]

        handle = Entrez.esummary(db='assembly', id=search_id)
        summary = Entrez.read(handle)['DocumentSummarySet']['DocumentSummary'][0]
        if 'virus' not in summary['Organism']:
            continue
        AssemblyAccession = summary['AssemblyAccession']
        FtpPath_GenBank = summary['FtpPath_GenBank']
        fna = f"{FtpPath_GenBank}/{FtpPath_GenBank.split('/')[-1]}_genomic.fna.gz"
        gff = f"{FtpPath_GenBank}/{FtpPath_GenBank.split('/')[-1]}_genomic.gff.gz"
        data.append((AssemblyAccession, fna, gff))

    # Write the information into {species}_isolate_genomes.txt
    with open(f"isolate_info/{prefix}_isolate_genomes.txt", "w") as out:
        for info in data:
            out.write(info[0] + '\n')
            out.write(info[1] + '\n')
            out.write(info[0] + '\n')
            out.write(info[2] + '\n')
            out.write(prefix+f'_{info[0]}' + '\n' + '\n')
