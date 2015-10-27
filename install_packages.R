.libPaths(/<Data partition>/R/library)
plist <- read.csv('~/Downloads/packages.csv')
install.packages(as.character(plist[,1]))
