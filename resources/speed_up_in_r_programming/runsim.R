## parsing command arguments
for (arg in commandArgs(TRUE)) {
  eval(parse(text=arg))
}

## check if a given integer is prime
isPrime <- function(n) {
  if (n <= 3) {
    return (TRUE)
  }
  if (any((n %% 2:floor(sqrt(n))) == 0)) {
    return (FALSE)
  }
  return (TRUE)
}

## estimate mean only using observation with prime indices
estMeanPrimes <- function (x) {
  n = length(x)
  ind = sapply(1:n, isPrime)
  return (mean(x[ind]))
}

## generate random data
set.seed(seed)
Generate_data <- function(n, dist){
  if (dist=='gaussian'){
    x=rnorm(n,mean = 0)
  }
  else if (dist=='t1') {
    x=rt(n,df=1)
  }
  else {
    x=rt(n,df=5)
  }
  return(x)
}

## calculate MSEs for two methods
MSEterrible <- c()
MSEclassic <- c()
for (i in (1:rep)) {
  x <- Generate_data(n,dist)
  classicMean <- mean(x)
  terribleMean <- estMeanPrimes(x)
  MSEterrible[i] <- (terribleMean)^2 #true mean for all types of distribution are set as 0
  MSEclassic[i] <- (classicMean)^2
}
MSEterrible <- mean(MSEterrible)
MSEclassic <- mean(MSEclassic)

## print out the results
print(MSEterrible)
print(MSEclassic)
