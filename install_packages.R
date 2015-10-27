args=(commangArgs(TRUE))

if(length(args) == 0) {
    print('No path argument supplied.  Please provide the path for installing R packages')
    print('E.G. <name of data partitio>/R/library')
} else {
    path = args[[i]]
    print(path)
    print('K\'plah!')
}

.libPaths(path)
plist <- read.csv('https://github.com/smalik/R_package_list/blob/master/packages.csv', stringsAsFactors=FALSE, header=TRUE)
install.packages(plist[,1])
