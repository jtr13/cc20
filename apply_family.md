# Apply family

Jie Mei and Ningxin Li




```r
library(ggplot2)
```

##Introduction

The apply family consists of functions which **minimize our need** to create loops.
It will apply an **R function or some R functions** to an **R data object**.
The biggest **difference** between using a function alone and using through apply family is the **object class** on which the function is applied and which will be returned.
We will explain the most common forms of apply functions **(apply, sapply, lapply, tapply)**, and there are also some other apply functions **(mapply, rapply, and vapply)** which will not be included here.

### apply

The apply() function is most often used to apply a function to the rows or columns of matrices, arrays and data frames. Apply can be used on lists too.

**First, let's see the usage of apply:**
```
> apply(X, MARGIN, FUN...)
```
**X**: an array, a matrix or a dataframe.
**MARGIN**: dimcode. 1 means apply to rows, 2 means apply to columns, and if they have names, we can use a character vector to select.
**FUN**: function
**...**: fargs(the optional parameter set of the function)

**Then, let's see the examples:**
For example:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/2
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,1,f)
```

```
##      [,1] [,2] [,3]
## [1,]  0.5  1.0  1.5
## [2,]  2.0  2.5  3.0
```

Basicly, we set a simple 3x2 matrix, and a simple function :deviding by 2.
And we got a 2x3 matrix, whose three columns means three results after applying the function to each row, and since each row has two values, there are also two values in a result, so the number of rows is two.

And, what if we make it more complex:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,1,f)
```

```
##      [,1] [,2] [,3]
## [1,]  0.5 1.00  1.5
## [2,]  1.0 1.25  1.5
```

Now, we changed the function to deviding by c(2,4).
And we still got a 2x3 matrix, but with different values in the second row. This is because we changed the function to two values, and when it applied, the first value was applied to the first row, and the second value was applied to the second row.

What if we have three values in the function:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4,8)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,1,f)
```

```
##       [,1] [,2]  [,3]
## [1,] 0.500 1.00 1.500
## [2,] 1.000 1.25 1.500
## [3,] 0.125 0.25 0.375
```

Now, we got a 3x3 matrix, with exactly the same answer we saw in b) and an additional row with some new values. It is easy to find that the third row is the result applying the third function value to the first column, which means when the amount of function value is larger than the amount of objects we want to apply, the objects will be applied cyclically.(like here, we actually applied the function /c(2,4,8) to 1,4,1 in the first row, where 1 is used twice, and we got 0.5,1,0.125)


If we try applying to the column:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4,8)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,2,f)
```

```
##       [,1] [,2]
## [1,] 0.500 2.00
## [2,] 0.500 1.25
## [3,] 0.375 0.75
```

Since there are exactly three values in the function, and three values in each column, we got the same size of applied matrix, which is 3*2. The columns in the result matrix just means the results.

What if the amount of function values is less than object values:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,2,f)
```

```
##      [,1] [,2]
## [1,]  0.5 2.00
## [2,]  0.5 1.25
## [3,]  1.5 3.00
```

The function values will be used cyclically.

Let's try applying to c(1,2):

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(z,c(1,2),f)
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,] 0.50  1.0 1.50
## [2,] 0.25  0.5 0.75
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    2 2.50  3.0
## [2,]    1 1.25  1.5
```

We will get two tables, one is applying to rows, and another is applying to columns.

What about dataframe:

```r
data.matrix<-matrix(1:12,c(3,4))
d <- data.frame(data.matrix)
d
```

```
##   X1 X2 X3 X4
## 1  1  4  7 10
## 2  2  5  8 11
## 3  3  6  9 12
```

```r
f <- function(x) {
         x*c(1,2,3)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d,2,f)
```

```
##      X1 X2 X3 X4
## [1,]  1  4  7 10
## [2,]  4 10 16 22
## [3,]  9 18 27 36
```

Here we can see that the application on dataframe is quite like matrix.

Let's try some other functions:
By columns:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d,2,quantile)
```

```
##       X1  X2  X3   X4
## 0%   1.0 4.0 7.0 10.0
## 25%  1.5 4.5 7.5 10.5
## 50%  2.0 5.0 8.0 11.0
## 75%  2.5 5.5 8.5 11.5
## 100% 3.0 6.0 9.0 12.0
```
By rows:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d,1,quantile)
```

```
##       [,1]  [,2]  [,3]
## 0%    1.00  2.00  3.00
## 25%   3.25  4.25  5.25
## 50%   5.50  6.50  7.50
## 75%   7.75  8.75  9.75
## 100% 10.00 11.00 12.00
```

By using some built-in functions, we can easily do data summary.

We can also select which column or row we want to apply on:
Select columns, apply column:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d[,3:4],2,quantile)
```

```
##       X3   X4
## 0%   7.0 10.0
## 25%  7.5 10.5
## 50%  8.0 11.0
## 75%  8.5 11.5
## 100% 9.0 12.0
```
Select rows, apply column:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d[1:2,],2,quantile)
```

```
##        X1   X2   X3    X4
## 0%   1.00 4.00 7.00 10.00
## 25%  1.25 4.25 7.25 10.25
## 50%  1.50 4.50 7.50 10.50
## 75%  1.75 4.75 7.75 10.75
## 100% 2.00 5.00 8.00 11.00
```
Select both, apply row:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(d[1:2,3:4],1,quantile)
```

```
##          1     2
## 0%    7.00  8.00
## 25%   7.75  8.75
## 50%   8.50  9.50
## 75%   9.25 10.25
## 100% 10.00 11.00
```

What about array, we use a built-in dataset 'Titanic' as an example.

```r
Titanic
```

```
## , , Age = Child, Survived = No
## 
##       Sex
## Class  Male Female
##   1st     0      0
##   2nd     0      0
##   3rd    35     17
##   Crew    0      0
## 
## , , Age = Adult, Survived = No
## 
##       Sex
## Class  Male Female
##   1st   118      4
##   2nd   154     13
##   3rd   387     89
##   Crew  670      3
## 
## , , Age = Child, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st     5      1
##   2nd    11     13
##   3rd    13     14
##   Crew    0      0
## 
## , , Age = Adult, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st    57    140
##   2nd    14     80
##   3rd    75     76
##   Crew  192     20
```

Since this array has more than 2 dimensions, we can use bigger number for MARGIN now.

Let's try apply to different dimensions:

```r
apply(Titanic, 1, sum)
```

```
##  1st  2nd  3rd Crew 
##  325  285  706  885
```

```r
apply(Titanic, 2, mean)
```

```
##     Male   Female 
## 108.1875  29.3750
```

```r
apply(Titanic, 3, quantile)
```

```
##       Age
##        Child Adult
##   0%     0.0   3.0
##   25%    0.0  18.5
##   50%    0.5  78.0
##   75%   13.0 143.5
##   100%  35.0 670.0
```

```r
apply(Titanic, 4, max)
```

```
##  No Yes 
## 670 192
```

As we can see, there are four dimensions, and we can apply functions to each dimension.

Can we apply to more than 1 dimension:

```r
apply(Titanic, c(1,2), mean)
```

```
##       Sex
## Class    Male Female
##   1st   45.00  36.25
##   2nd   44.75  26.50
##   3rd  127.50  49.00
##   Crew 215.50   5.75
```

```r
apply(Titanic, c(3,4), sum)
```

```
##        Survived
## Age       No Yes
##   Child   52  57
##   Adult 1438 654
```

```r
apply(Titanic, c(1,2,3), mean)
```

```
## , , Age = Child
## 
##       Sex
## Class  Male Female
##   1st   2.5    0.5
##   2nd   5.5    6.5
##   3rd  24.0   15.5
##   Crew  0.0    0.0
## 
## , , Age = Adult
## 
##       Sex
## Class   Male Female
##   1st   87.5   72.0
##   2nd   84.0   46.5
##   3rd  231.0   82.5
##   Crew 431.0   11.5
```

```r
f <- function(x) {
         x/2
}
apply(Titanic, c(1,2,3,4), f)
```

```
## , , Age = Child, Survived = No
## 
##       Sex
## Class  Male Female
##   1st   0.0    0.0
##   2nd   0.0    0.0
##   3rd  17.5    8.5
##   Crew  0.0    0.0
## 
## , , Age = Adult, Survived = No
## 
##       Sex
## Class   Male Female
##   1st   59.0    2.0
##   2nd   77.0    6.5
##   3rd  193.5   44.5
##   Crew 335.0    1.5
## 
## , , Age = Child, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st   2.5    0.5
##   2nd   5.5    6.5
##   3rd   6.5    7.0
##   Crew  0.0    0.0
## 
## , , Age = Adult, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st  28.5     70
##   2nd   7.0     40
##   3rd  37.5     38
##   Crew 96.0     10
```

Of course, we can apply functions to more than one dimensions.

### Lapply

The lapply function works on a list. It applies the chosen function on a list interating through each elements and returns a list in the end.

**First, let's see the usage of lapply:**
```
> lapply(X, FUN, ???)
```
**X**: the targeted list.
**FUN**: the function we want to perform on X.

**Then, let's see a sample code:**

In this example, the data_frame is a data frame and we want to get the total number of rows in lists 2 to 5.
Notice here that data frames are consisted of lists.

lapply(data_frame[, 2:5], function(x) nrow(x)) %>%
  unlist() %>%
  sum()


### Sapply

The sapply() function is quite like lapply(). The only **difference** is in the **return value**. 
Sapply() will try to simplify the result of lapply() if possible(that is why it called 's'apply). Actually, sapply() functions like lapply() and then does the following algorithm:
??? If the result is a list with each element's length equals 1, then it will return a vector.
??? If the result is a list with vectors of the same length, then it will return a matrix.
??? Otherwise, it will return a list.

**First, let's see the usage of sapply:**
```
> sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
```

If we set simplify = FALSE, and USE.NAMES = FALSE, then it will be the same as lapply(x,FUN)
**simplify**(cannot be abbreviated): logical/character; a vector, matrix or higher dimensional array. TRUE: returns a vector or matrix, whereas "array": returns an array of “rank??? (=length(dim(.))) one higher than the result of FUN(X[[i]]).
**USE.NAMES**(cannot be abbreviated): logical; TRUE and X is character: use X as names for the result unless it had names already.

**Then, let's see the examples:**
We just use the same dataset, and same function to see the different.

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(Titanic, c(1,2,3,4), mean)
```

```
## , , Age = Child, Survived = No
## 
##       Sex
## Class  Male Female
##   1st     0      0
##   2nd     0      0
##   3rd    35     17
##   Crew    0      0
## 
## , , Age = Adult, Survived = No
## 
##       Sex
## Class  Male Female
##   1st   118      4
##   2nd   154     13
##   3rd   387     89
##   Crew  670      3
## 
## , , Age = Child, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st     5      1
##   2nd    11     13
##   3rd    13     14
##   Crew    0      0
## 
## , , Age = Adult, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st    57    140
##   2nd    14     80
##   3rd    75     76
##   Crew  192     20
```

```r
print("This is what we got after sapplying the function:")
```

```
## [1] "This is what we got after sapplying the function:"
```

```r
sapply(Titanic, mean)
```

```
##  [1]   0   0  35   0   0   0  17   0 118 154 387 670   4  13  89   3   5  11  13
## [20]   0   1  13  14   0  57  14  75 192 140  80  76  20
```

We can see very clearly that the 'apply' function returns a array, while the 'sapply' function returns a vector.

If we do not simplify:

```r
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
apply(Titanic, c(1,2,3,4), mean)
```

```
## , , Age = Child, Survived = No
## 
##       Sex
## Class  Male Female
##   1st     0      0
##   2nd     0      0
##   3rd    35     17
##   Crew    0      0
## 
## , , Age = Adult, Survived = No
## 
##       Sex
## Class  Male Female
##   1st   118      4
##   2nd   154     13
##   3rd   387     89
##   Crew  670      3
## 
## , , Age = Child, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st     5      1
##   2nd    11     13
##   3rd    13     14
##   Crew    0      0
## 
## , , Age = Adult, Survived = Yes
## 
##       Sex
## Class  Male Female
##   1st    57    140
##   2nd    14     80
##   3rd    75     76
##   Crew  192     20
```

```r
print("This is what we got after sapplying the function:")
```

```
## [1] "This is what we got after sapplying the function:"
```

```r
c<-sapply(Titanic, mean, simplify = FALSE, USE.NAMES = FALSE)
```


```r
is.list(c)
```

```
## [1] TRUE
```

Then, we will get a list.

Let's go back to the matrix:

```r
print("This is the matrix:")
```

```
## [1] "This is the matrix:"
```

```r
z <- matrix(1:6, nrow = 3)
z
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
f <- function(x) {
         x/c(2,4,8)
}
print("This is what we got after applying the function:")
```

```
## [1] "This is what we got after applying the function:"
```

```r
a <-apply(z,c(1,2),f)
a
```

```
## , , 1
## 
##       [,1] [,2]  [,3]
## [1,] 0.500 1.00 1.500
## [2,] 0.250 0.50 0.750
## [3,] 0.125 0.25 0.375
## 
## , , 2
## 
##      [,1]  [,2] [,3]
## [1,]  2.0 2.500 3.00
## [2,]  1.0 1.250 1.50
## [3,]  0.5 0.625 0.75
```

```r
print("This is what we got after sapplying the function:")
```

```
## [1] "This is what we got after sapplying the function:"
```

```r
b <-sapply(z,f)
b
```

```
##       [,1] [,2]  [,3] [,4]  [,5] [,6]
## [1,] 0.500 1.00 1.500  2.0 2.500 3.00
## [2,] 0.250 0.50 0.750  1.0 1.250 1.50
## [3,] 0.125 0.25 0.375  0.5 0.625 0.75
```

```r
is.array(a)
```

```
## [1] TRUE
```

```r
is.matrix(b)
```

```
## [1] TRUE
```

Since the sapply function do not have a MARGIN parameter, we can only apply this to all the dimensions. Here the apply result becomes an array, because we applied the function to both row and column, and the sapply result remains a matrix, which simplified the format.

### tapply

tapply() is used to apply a function over subsets of a vector: in cases we can group the datasets based on some variables.

**First, let's see the usage of tapply:**
```
> tapply(x, INDEX, FUN, ..., simplify = TRUE)
```

**x**: the target numerical or logical vector.
**INDEX**: a factor or a list of factors that divides the dataset into groups
**FUN**: the function we want to apply to each group

**Then, let's see an example:**

In this example, we wanted to examine the average price of diamonds based on cut.
The target dataset/vector x is diamonds\$price and the groupping is identified by diamonds\$cut.

```r
head(diamonds)
```

```
## [90m# A tibble: 6 x 10[39m
##   carat cut       color clarity depth table price     x     y     z
##   [3m[90m<dbl>[39m[23m [3m[90m<ord>[39m[23m     [3m[90m<ord>[39m[23m [3m[90m<ord>[39m[23m   [3m[90m<dbl>[39m[23m [3m[90m<dbl>[39m[23m [3m[90m<int>[39m[23m [3m[90m<dbl>[39m[23m [3m[90m<dbl>[39m[23m [3m[90m<dbl>[39m[23m
## [90m1[39m 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
## [90m2[39m 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
## [90m3[39m 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
## [90m4[39m 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
## [90m5[39m 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
## [90m6[39m 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
```

```r
tapply(diamonds$price, diamonds$cut, mean, na.rm = TRUE)
```

```
##      Fair      Good Very Good   Premium     Ideal 
##  4358.758  3928.864  3981.760  4584.258  3457.542
```
