# autoSim.R

## parsing command arguments
for (arg in commandArgs(TRUE)) {
  eval(parse(text=arg))
}

## using R to call R
nVals <- seq(100, 500, by=100)
distTypes = c("gaussian", "t1", "t5")
for (dist in distTypes) {
  for (n in nVals){
    oFile <- paste("n", n,"dist",dist, ".txt", sep="")
    sysCall <- paste("nohup Rscript runSim.R n=", n, " dist=",shQuote(shQuote(dist)),
                     " seed=",seed," rep=",rep," > ", oFile, sep="")
    #For we are not allowed to write files into the community contribution repository, 
    #we commended the following 2 lines that print results in .txt files 
    #and write those files into current folder. If you would like to try parallel 
    #computing in this way, feel free to cancel the comments of those 2 lines below.
    #system(sysCall)
    #print(paste("sysCall=", sysCall, sep=""))
  }
}
