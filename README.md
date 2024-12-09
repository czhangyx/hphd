# Welcome to the Human-Pathogen Herpesvirus Database!

## 1. Installation
We are assuming that you are using a Linux operating system (enabled Windows Subsystem), have jbrowse2 downloaded, and already have an Apache server set up!

### Clone Repo

  1. Create a new directory. Take note of this directory's name as all following commands will be run inside of this directory.
  2. Run `sudo service apache2 start` to start up the web server. Navigate to `http://ipaddress` (AWS terminal) or if running on a Linux system run the below code to get the IP address:

  ```
    # from within WSL, run the linux server launch command to launch the service, then print out you WSL IP address so you can access the server from your Windows browser
    # if the ip command isn't recognized, install iproute and then try again
    # sudo apt install iproute2
    ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
  ```
  Then run `http://localhost:8080/` with the IP address given from the above command. You should reach a page that has an orange button saying "It Works!"
  

  3. Clone our repo! `https://github.com/czhangyx/hphd.git` (also inside the directory created).

 ```
  git clone https://github.com/czhangyx/hphd.git

 ```

### Set APACHE_ROOT
1.In order for our bash scripts to work, you must set the APACHE_ROOT variable correctly as it is referenced in the scripts. In order to do this, run the below code. This variable must be reset with every new terminal instance.

```
#replace `/var/www/html` with either `/var/www` depending on where the directory is
export APACHE_ROOT='/var/www/html'
```

2. Inside the same directory as before, run the following command. This is to copy Jbrowse2 into our apache2 directory (root)

  ```
     jbrowse create output_folder
     sudo mv output_folder $APACHE_ROOT/jbrowse2
     sudo chown -R $(whoami) $APACHE_ROOT/jbrowse2
  ```

## 2. Uploading Data to Jbrowse 2

IMPORTANT: Please follow the below sections in order!! If you try to upload isolate files before genes, the reference genome will be missing!

### Uploading Genes

1. In order to upload the genes data to Jbrowse navigate to hphd:  `cd hphd`. Run `./jbrowse_upload.sh` inside this folder.
   
```
cd hphd
./jbrowse_upload.sh
```

    
3. Navigate to  `http://yourhost/jbrowse2/` and begin exploring!
   
### Uploading Isolates

1. Command line will prompt you to enter the name of the file that contains isolate information for a specific reference genome when the upload bash script is run. Navigate to hphd `cd hphd` and open the isolates.txt file with  `cat isolates.txt`
```
cd hphd
cat isolates.txt
```
You will see the name of the .txt file that holds isolate information for each type of herpesvirus followed by the name of the reference genome.
```
Format:
.txt file, reference_genome_name
```

2. Copy over the name of the text file that corresponds with the reference genome of interest as well as the name of the reference genome
3. In order to upload to isolate data to Jbrowse navigate to the isolate_info folder  `cd isolate_info`. Run `./isolate_upload.sh` inside this folder. When the command lines prompts you for a file name, paste the file from step 2. When the command line prompts you for a reference genome, paste the genome name from step 2.
   
```
cd isolate_info
./isolate_upload.sh
```

  Note: If you get a permission denied error when trying to run the executable, run the following command: `chmod +x ./isolate_upload.sh` follwed by `./isolate_upload.sh`.
```
chmod +x ./isolate_upload.sh
./isolate_upload.sh
```

4. Repeat steps 2 and 3 for all isolates and reference genomes of interest.
5. Navigate to  `http://yourhost/jbrowse2/` and begin exploring!


## 3. Navigating Through The Static Website

Go to https://romaankolekar.github.io/jbrowse2 to use our genome browser! Select one of the 9 pathogens to explore! Note: when selecting tracks the reference genome and first gene selctor (right under the reference genome) should be selected as it contains information about all the isolates. The isolate gene tracks works occasionally but do not always show up! You can still get all the information needed by selcting the gene track under the reference genome. Furthermore, select color by CDS in the purple track dropdown in order to explore amino acid coding sequences!

### Check our our last autosaved session for an example: 

1. Go to https://romaankolekar.github.io/jbrowse2
2. Navigate to Linear Genome View
3. Click the file drop down
4. Import Session
5. From this github repo, upload session.json






