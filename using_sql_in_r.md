# Writing SQL in R

Jingyuan Liu

## 1. Introduction
SQL has been one of the go-to solutions for data scientists to perform data analysis and manage data pipelines. This is because SQL is fairly easy to read and learn --almost everybody knows it. As a result, it would be helpful for some to work with SQL under the R framework. This post will explore methods to incorporate SQL in R.

## 2. What is SQL?
SQL stands for Structured Query Language which let you access and manipulate databases. SQL is designed for managing data in relational database management systems(RDBMS).


## 3. R Packages
We will be trying out three R packages in this post in the following order:
[`sqldf`](https://www.rdocumentation.org/packages/sqldf/versions/0.4-11){target="_blank"}\,
[`DBI`](https://www.rdocumentation.org/packages/DBI/versions/0.5-1){target="_blank"}\,
[`dplyr`](https://www.rdocumentation.org/packages/dplyr){target="_blank"}\.

### Load packages

```r
library(proto)
library(gsubfn)
library(RSQLite)
library(sqldf)

library(dplyr)

library(DBI)
```

### Dataset
We will be using the dataset iris throughout this project. First we use DBI package to copy iris from Dataframe into the database. 

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
connection <- dbConnect(SQLite(), "")
dbWriteTable(connection, 'iris', iris)
iris_tbl = dbReadTable(connection, 'iris')
```


## sqldf
sqldf is the simplest way to use SQL in R among the three packages. It contains only one function `sqldf()` which we just pass in the SQL query we want. 

### SQL Queries

```r
sqldf("SELECT * FROM iris LIMIT 10")
```

```
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
```
### Where/And/Or
Notice that `sqldf` does not allow `.` in column names, so in this case we need to put column name in backticks.

```r
sqldf("SELECT Sepal.Length, Species FROM iris WHERE Species='setosa' LIMIT 10 "  )
```

```
## Error: no such column: Sepal.Length
```

```r
sqldf("SELECT `Sepal.Length`, Species FROM iris WHERE Species='setosa' LIMIT 10 "  )
```

```
##    Sepal.Length Species
## 1           5.1  setosa
## 2           4.9  setosa
## 3           4.7  setosa
## 4           4.6  setosa
## 5           5.0  setosa
## 6           5.4  setosa
## 7           4.6  setosa
## 8           5.0  setosa
## 9           4.4  setosa
## 10          4.9  setosa
```
### More sqldf Examples
Use `SELECT COUNT()`.

```r
sqldf("SELECT COUNT() FROM iris WHERE Species = 'setosa'")
```

```
##   COUNT()
## 1      50
```
Creating new table for data aggregation

```r
df = sqldf("SELECT Species, AVG(`Sepal.Length`) FROM iris GROUP BY Species")
df
```

```
##      Species AVG(`Sepal.Length`)
## 1     setosa               5.006
## 2 versicolor               5.936
## 3  virginica               6.588
```

### sqldf Summary:
We see that sqldf provided a surprisingly easy way to write SQL in R. The user simply specifies an SQL statement in R using data frame names in place of table names and a database with appropriate table layouts/schema is automatically created. Currently, sqdl supports (1) the SQLite backend database, (2) the H2 java database, (3) the PostgreSQL database and (4) MySQL. 

## DPLYR
DPLYR provides a way to write your code in consistent with R and translate to SQL with the `show_query()` function.

### DPLYR Queries
Select sepal.length and species with species `Virginica`.

```r
iris_tbl <- tbl(connection, 'iris')
q1 <- iris_tbl %>% select(Sepal.Length, Species) %>%
  filter(Species == 'virginica') %>%
  head(10)
show_query(q1)
```

```
## <SQL>
## SELECT *
## FROM (SELECT `Sepal.Length`, `Species`
## FROM `iris`)
## WHERE (`Species` = 'virginica')
## LIMIT 10
```

```r
q1
```

```
## [90m# Source:   lazy query [?? x 2][39m
## [90m# Database: sqlite 3.33.0 [][39m
##    Sepal.Length Species  
##           [3m[90m<dbl>[39m[23m [3m[90m<chr>[39m[23m    
## [90m 1[39m          6.3 virginica
## [90m 2[39m          5.8 virginica
## [90m 3[39m          7.1 virginica
## [90m 4[39m          6.3 virginica
## [90m 5[39m          6.5 virginica
## [90m 6[39m          7.6 virginica
## [90m 7[39m          4.9 virginica
## [90m 8[39m          7.3 virginica
## [90m 9[39m          6.7 virginica
## [90m10[39m          7.2 virginica
```
### More Examples
Count number of rows with species `setosa`

```r
q2 <- iris_tbl %>% select(Sepal.Length, Species) %>%
  filter(Species == 'setosa') %>%
  count()
show_query(q2)
```

```
## <SQL>
## SELECT COUNT(*) AS `n`
## FROM (SELECT `Sepal.Length`, `Species`
## FROM `iris`)
## WHERE (`Species` = 'setosa')
```

```r
q2
```

```
## [90m# Source:   lazy query [?? x 1][39m
## [90m# Database: sqlite 3.33.0 [][39m
##       n
##   [3m[90m<int>[39m[23m
## [90m1[39m    50
```

```r
q3 <- iris_tbl %>% select(Sepal.Length, Species) %>%
  group_by(Species) %>%
  summarize(mean(Sepal.Length, na.rm = TRUE))
show_query(q3)
```

```
## <SQL>
## SELECT `Species`, AVG(`Sepal.Length`) AS `mean(Sepal.Length, na.rm = TRUE)`
## FROM (SELECT `Sepal.Length`, `Species`
## FROM `iris`)
## GROUP BY `Species`
```

```r
q3
```

```
## [90m# Source:   lazy query [?? x 2][39m
## [90m# Database: sqlite 3.33.0 [][39m
##   Species    `mean(Sepal.Length, na.rm = TRUE)`
##   [3m[90m<chr>[39m[23m                                   [3m[90m<dbl>[39m[23m
## [90m1[39m setosa                                   5.01
## [90m2[39m versicolor                               5.94
## [90m3[39m virginica                                6.59
```

### DPLYR Summary
Dplyr provides a convenient way to translate R syntax into SQL. This feature is particular useful for some who are more familiar with R than SQL. However, Dplyr sometimes generate sub-optimal SQL queries that does not perform well with massive data set. Moreover, it takes sometime to get familiar with Dplyr functions. 

## DBI
DBI provides a most comprehensive way to use database in R. It allows the user to connect, write, read, and manage database directly with functions includes in the package. In this post, we mainly focus on the query part. 

### DBI Queries:
Again, select first ten rows from `iris`

```r
res <- dbSendQuery(connection, "SELECT * FROM iris LIMIT 10")
dbFetch(res)
```

```
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
```

```r
dbClearResult(res)
```

Select sepal.length and species with species `setosa`.

```r
res <- dbSendQuery(connection, "SELECT `Sepal.Length`, Species FROM iris WHERE Species='setosa' LIMIT 10  ")
dbFetch(res)
```

```
##    Sepal.Length Species
## 1           5.1  setosa
## 2           4.9  setosa
## 3           4.7  setosa
## 4           4.6  setosa
## 5           5.0  setosa
## 6           5.4  setosa
## 7           4.6  setosa
## 8           5.0  setosa
## 9           4.4  setosa
## 10          4.9  setosa
```

```r
dbClearResult(res)
```
Count number of rows with species `setosa`

```r
res <- dbSendQuery(connection, "SELECT COUNT() FROM iris WHERE Species = 'setosa'")
dbFetch(res)
```

```
##   COUNT()
## 1      50
```

```r
dbClearResult(res)
```

Select the average Sepal.Length for each of the species.

```r
res <- dbSendQuery(connection, "SELECT Species, AVG(`Sepal.Length`) FROM iris GROUP BY Species")
dbFetch(res)
```

```
##      Species AVG(`Sepal.Length`)
## 1     setosa               5.006
## 2 versicolor               5.936
## 3  virginica               6.588
```

```r
dbClearResult(res)
dbDisconnect(connection)
```

## Conclusion
In this project we explored different methods to work with SQL in R. The sqldf provides the most intuitive way by the single function `sqldf` which works directly with R's dataframe object. Dplyr allows user to translate their R syntax into SQL which is really helpful for some SQL newbies. DBI, on the other hand, is the most powerful database tool at this time. It allows the user to connect and work with database directly. However, it seems not as easy to use as sqldf. 

## Work Cited:
Dplyr Relational Databases, Alberto Munguia and Chengyi Chen 

https://jtr13.github.io/cc19/dplyr-relational-databases.html

Using DBI
https://db.rstudio.com/dbi
