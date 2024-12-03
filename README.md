# Welcome to the Human-Pathogen Herpesvirus Database!

## Installation

### 1. Miniconda
Before installing our package, you should have Miniconda already installed on your computer. Miniconda is a Python environment manager that makes it easy to install HPHD and its dependencies without affecting other softwares on your computer. If you do not have Miniconda on your computer, please follow the instructions on [their official website](https://docs.anaconda.com/miniconda/install/).

### 2. Create and activate a Conda environment
You can use our scripts to automatically install all dependencies. Start by cloning the repository:  
```
git clone https://github.com/czhangyx/hphd
cd hphd
```
Run the following command to install a conda environment:  
`conda env create -f hphd.yaml`    
This might take several minutes as it needs to download some data to ensure smooth running of the program. Once the environment is successfully installed, activate this environment by running:
`conda activate hphd`    
To run the program, simply execute `hphd` in your terminal. When you are done with your search, you can run `conda deactivate hphd` to deactivate this environment.  
If you need to make another search in the future, simply activate the environment again and repeat what you did before.

### 3. Using HPHD
