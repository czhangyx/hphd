# Welcome to the Human-Pathogen Herpesvirus Database!

## 1. Installation
We are assuming that you are using a Linux operating system (enabled Windows Subsystem), have jbrowse2 downloaded, and already have an Apache server set up!

### Clone Repo

  1. Create a new directory. Take note of this directory's name as all following commands will be run inside of this directory.
  2. Run sudo `service apache2 start` to start up the web server. Navigate to `http://ipaddress` (AWS terminal) or if running on a Linux system run the below code to get the IP address:

  ```
    # from within WSL, run the linux server launch command to launch the service, then print out you WSL IP address so you can access the server from your Windows browser
    # if the ip command isn't recognized, install iproute and then try again
    # sudo apt install iproute2
    ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
  ```
  Then run `http://localhost:8080/` with the IP address given from the above command. You should reach a page that has an organe button saying "It Works!"
  
  4. Inside the same directory, run the following command. This is to copy Jbrowse2 into our apache2 directory (root)

  ```
     jbrowse create output_folder
     sudo mv output_folder $APACHE_ROOT/jbrowse2
     sudo chown -R $(whoami) $APACHE_ROOT/jbrowse2
  ```

  3. Clone our repo! `https://github.com/czhangyx/hphd.git` (also inside the directory created.

 ```
  git clone https://github.com/czhangyx/hphd.git

 ```

### Set APACHE_ROOT
In order for our bash scripts to work, you must set the APACHE_ROOT variable correctly as it is referenced in the scripts. In order to do this, run the below code

```
#replace `/var/www/html` with either `/var/www` depending on where the directory is
export APACHE_ROOT='/var/www/html'
```

## 2. Uploading Data to Jbrowse 2

### Uploading Isolates

2. Command line will prompt you to enter the name of the file that contains isolate information for a specific reference genome when the upload bash script is run. Navigate to hphd `cd hphd` and open the isolates.txt file with  `cat isolates.txt`
3. Copy over the name of the text file that corresponds with the reference genome of interest
4. In order to upload to isolate data to Jbrowse navigate to the isolate_info folder  `cd isolate_info`. Run `./isolate_upload.sh` inside this folder. When the command lines promps you for a file name, paste the file from step 3.

  Note: If you get a permission denied error when trying to run the executable, run the following command: `chmod +x ./isolate_upload.sh` follwed by `./isolate_upload.sh`.
6. Repeat steps 3 and 4 for all isolates of interest.
6. Navigate to  `http://yourhost/jbrowse2/` and begin exploring!


###Uploading Genes

1. In order to upload to genes data to Jbrowse navigate to hphd:  `cd hphd`. Run `./jbrowse_upload.sh` inside this folder.
2. Navigate to  `http://yourhost/jbrowse2/` and begin exploring!





