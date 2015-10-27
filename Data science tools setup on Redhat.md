#   Configuration and installation for Spirent data science enviornment

R and R Studio are applications that enable statistical computing which are widely used by statisticians and data scienctists.  As such they form the backbone of any data science toolkit.  To install both these applications you can follow the instructions listed below.  You must be logged on as root or have sudo capabilities to install these applications.

This tutorial should be read sequentially and as 3 major parts:
1.  Defining a new linux group for Spirent users (for R package management purposes)
2.  Installation of R an R-Studio Server
3.  Installation of an initial list of R packages
4.  Installation of Python packages

##  Filesystem details

For the 250GB total, I think we just need 2 partitions.
- (OS, root, user apps,  Etc…) sized at 50GB
- (data partition) sized at 196GB
- Swap space should be 4GB

Below are the values for the partitions.  The structure mirrors what was sent as part of the disk utility printout supplies on 10/13/15 by Srinivas.

-
    ```sh 
    Total       : 50GB
    /rootvol    : 16GB
    /boot       : 200MB
    /export     : 8GB
    /usr/apps   : 12GB
    /var        : 8GB 
    /var/core   : 4GB
    /var/crash  : 2GB
    ```
The data partition should be on a separate partition sized at 196GB.  This assumed the total space allocated for this project is 250GB.  If the amount is larger than 250GB, then the OS pariition should stay at 50GB and data partition to be scaled up to make up the difference.  E.g in the case of 500GB total space, the data partition should be 446GB.

#### Details on the data partition

The data partition should have read, write, and execute privelages.  Analysts will use this partition to load data, save workspaces and code files, as well as execute R and python scripts located here.  This partiton does not need to be segmented of further divided into enviornment specific segments (e.g. R, Python, etc...).  The analysts will create directories on a per project or task basis.   

### Access to installed applications
With regards to user access to R, R Studio, Python, and other installed packages, there is no need for additional configuration.  The applications have predefined install rules as part of their self-contained installer packages.  These paths are typically:
- /usr/bin/
- /usr/local/bin

R packages will be installed on the data partition mentioned in the preceeding section at location <data partition>/R/library.  There is no need for any additional configuration of directories or paths.  Each user account should be able to call 'R' and 'python3' from their user accounts.  

##  Installing pip utility for Python 3
For Python to be useful, users need to be able to install packages.  This is done using a utility called pip, which ought to be installed and made accessible to users.  Here are details on where to grab the package and install pip.  Python 3 should already be installed.  

You can check this by running: 
```sh
which python3       # This should return a path where the python3 binary is located.  Otherwise it is not installed.
```

**For RHEL 7.x and CentOS 7.x (x86_64)**
```sh
yum install epel-release
```

**For RHEL 6.x and CentOS 6.x (x86_64)**
```sh
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
```
**Now install PIP with the yum command and then confirm that it installed correctly**
```sh
yum install -y python-pip
which pip   # should give you a path location for pip
pip3 list   # will list all python packages installed
```
Note: Users in the spirent group should be able to execute this command.


##  List of users

 Name | id |
--------------------:|:---------
**Leihy, Pat** | **v0leipa** 
**Abdelmonem, Yousef** | **v0abdyo** 
**Malik, Sulaiman** | Not ready yet
**Chesal, Larry** | **c0chel2**
**Ahmed, Iman** | **v0ahmim**
**Hong-Hong** | **v0fanho**




##  Defining a new group and adding members
Before we start the installation, we will want to create a special group called 'spirent' which will be needed later when we configure package management in R.  This can be done by the following as root:
   
-   ```sh
    sudo groupadd spirent
    sudo usermod -aG spirent <username>     # do for all users listed above
    ```
___

##   Installing R & R Studio on Redhat Linux

***These install instructions assume the linux distribution is Redhat/CentOS 6 and 7 based.***

First install R by (in order):
  - Downloading the .RPM file for R and installing it using the Redhat package manager: 
  -     rpm -ivh http://mirror.chpc.utah.edu/pub/epel/6Server/x86_64/R-core-3.2.2-1.el6.x86_64.rpm
  -     yum install R

After installing the core R package, install R Studio Server:

-   Same as before, download the RPM and use Redhat package manager to install:
    ```sh
    wget https://download2.rstudio.org/rstudio-server-rhel-0.99.486-x86_64.rpm
    sudo yum install --nogpgcheck rstudio-server-rhel-0.99.486-x86_64.rpm
    ```
-   For the R Studio Server, you will need to enable the administrator dashboard by editing the reserver.conf                    configuration file.  This can be done by:
    ```sh
    1.  editing /etc/rstudio/rserver.conf in your text editor of choice
    2.  add 'admin-enabled=1' statement.  (all sans single quote marks)
    3.  add 'rsession-which-r=/usr/local/bin/R'
    4.  add 'r-cran-repos=http://cran.at.r-project.org/'
    5.  add 'r-libs-user=~ <name of data partition>/R/library'
    ```
-   Now create a separate directory where all R packages will be installed and live:
    ```sh
    mkdir <data partition>/R
    chown -R spirent:root <name of data partition>/R
    chmod -R 777 <name of data partition>/R
    mkdir <name of data partition>/R/library
    ```
-   Install initial list of R packages
    ```sh
    1.  wget https://raw.githubusercontent.com/smalik/R_package_list/master/install_packages.R
    2.  sudo R CMD BATCH -no-restore '--args path=<path to R library>' install_packages.R
    ```

***Note: R Studio Server listens on port 8787 by default.***


___


For questions contact sulaiman.malik@spirent.com
