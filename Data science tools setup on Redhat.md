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
    /rootvol    : 16GB
    /boot       : 200MB
    /export     : 8GB
    /usr/apps   : 12GB
    /var        : 8GB
    /var/core   : 4GB
    /var/crash  : 2GB
    ```
The data partition should be on a separate partition sized at 196GB

#### The


***These install instructions assume the linux distribution is Redhat/CentOS 6 and 7 based.***

##  Defining a new group and adding members
Before we start the installation, we will want to create a special group called 'spirent' which will be needed later when we configure package management in R.  This can be done by the following as root:

-   ```sh
    sudo groupadd spirent
    sudo usermod -aG spirent <username>     # do for all users
    ```
___

##   Installing R & R Studio on Redhat Linux
First install R by (in order):
  - Downloading the .RPM file for R and installing it using the Redhat package manager:
  -     rpm -ivh http://mirror.chpc.utah.edu/pub/epel/6Server/x86_64/R-core-3.2.2-1.el6.x86_64.rpm
  -     yum install R

After installing the core R package, install R Studio Server:

-   Same as before, download the RPM and use Redhat package manager to install:
-       wget https://download2.rstudio.org/rstudio-server-rhel-0.99.486-x86_64.rpm
-       sudo yum install --nogpgcheck rstudio-server-rhel-0.99.486-x86_64.rpm
        ```sh
        For the R Studio Server, you will need to enable the administrator dashboard by editing the reserver.conf
        configuration file.  This can be done by:
        1.  editing /etc/rstudio/rserver.conf in your text editor of choice
        2.  add 'admin-enabled=1' statement.  (all sans single quote marks)
        3.  add 'rsession-which-r=/usr/local/bin/R'
        4.  add 'r-cran-repos=http://cran.at.r-project.org/'
        5.  add 'r-libs-user=~ <name of data partition>/R/library'
        ```
-   Now create a separate directory where all R packages will be installed and live:
    ```sh
    mkdir <data partition>/R
    chown spirent:root <name of data partition>/R
    chmod 777 <name of data partition>/R
    mkdir <name of data partition>/R/library
    ```
-   Install initial list of R packages
    ```sh
    1.  wget https://raw.githubusercontent.com/smalik/R_package_list/master/install_packages.R
    2.  sudo R CMD BATCH -no-restore '--args path=<path to R library>' install_packages.R
    ```

***Note: R Studio Server listens on port 8787 by default.***

Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.

### Version
3.2.0

### Tech

Dillinger uses a number of open source projects to work properly:

* [AngularJS] - HTML enhanced for web apps!
* [Ace Editor] - awesome web-based text editor
* [Marked] - a super fast port of Markdown to JavaScript
* [Twitter Bootstrap] - great UI boilerplate for modern web apps
* [node.js] - evented I/O for the backend
* [Express] - fast node.js network app framework [@tjholowaychuk]
* [Gulp] - the streaming build system
* [keymaster.js] - awesome keyboard handler lib by [@thomasfuchs]
* [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

### Installation

You need Gulp installed globally:

```sh
$ npm i -g gulp
```

```sh
$ git clone [git-repo-url] dillinger
$ cd dillinger
$ npm i -d
$ mkdir -p downloads/files/{md,html,pdf}
$ gulp build --prod
$ NODE_ENV=production node app
```

### Plugins

Dillinger is currently extended with the following plugins

* Dropbox
* Github
* Google Drive
* OneDrive

Readmes, how to use them in your own application can be found here:

* [plugins/dropbox/README.md] [PlDb]
* [plugins/github/README.md] [PlGh]
* [plugins/googledrive/README.md] [PlGd]
* [plugins/onedrive/README.md] [PlOd]

### Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantanously see your updates!

Open your favorite Terminal and run these commands.

First Tab:
```sh
$ node app
```

Second Tab:
```sh
$ gulp watch
```

(optional) Third:
```sh
$ karma start
```

### Todos

 - Write Tests
 - Rethink Github Save
 - Add Code Comments
 - Add Night Mode

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does it's job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [@thomasfuchs]: <http://twitter.com/thomasfuchs>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [marked]: <https://github.com/chjj/marked>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [keymaster.js]: <https://github.com/madrobby/keymaster>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]:  <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
