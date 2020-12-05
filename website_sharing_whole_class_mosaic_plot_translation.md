# Website Sharing Whole Class and 2nd-part of the Website -- Mosaic Plot Translation to Chinese
 
Hanxiao Zhang and Lei Guo

We're trying to create a web site for sharing class resources publicly. 
In order to give the audiences an overall knowledge of EDA, our website includes the following three parts: 

## Three Parts of Our Website

**1. Course Slides**
  * We would give a brief introduction to each topics of EDA and provide the slides for further self-learning)

**2. Specific Topic Tutorial**
  * We are translating the external resources on Mosaic plot topic)

**3. A Reading List**
  * We would include the recommended reading materials for students to learn certain topics in depth). We have complete the general design of the website and would include more topics during the rest of the semester. 


## Links of All Parts of Website
  * Link to our website: https://leiguolg.wixsite.com/5702 
    ** The .Rmd and .html files for the 2nd part of our website rpub are also available on the button called ".Rmd and .html files" on the 2nd page of our website named "Specific Topic -- Mosaic plot". These two files can be downloaded through google drive.
  * Link to translated tutorial: https://rpubs.com/hz2660/Mosaic-plot 
  * Link to Excel file: resources/website_sharing_whole_class_mosaic_plot_translation/MusicIcecream.csv
  
## Codes of 2nd-part of Website 
  * The .Rmd is available on this Github branch named "Translation-Rcode" 


### Note for the Available Code
 * We used the "Wix" SaaS to generate a website that for sharing class resources publicly, where the code of building the website is not included in the Github since the website is created by "Wix" platform And we include here . This is the second part of our website, which is a specific topic .Rmd tutorial (we are translating the external resources on Mosaic plot topic). 

 * Since we didn't write the code for the Wix website excluding the 2nd part of the website that we wrote with .Rmd, we only include the 2nd part in the Github. 
 
 
For graders and Professor: this document is intended as a tutorial in Chinese on the content of Mosaic plots with R. We combined texts from three websites, wiki, *Mosaic plots with ggplot2* (https://cran.r-project.org/web/packages/ggmosaic/vignettes/ggmosaic.html) and the **Chart: Mosaic** section on [edav.info](https://edav.info/). 

We hope this document can effectively jumpstart any user (with limited language background to Chinese) with sufficient skills to assess Mosaic plots with R.

### This document is outlined as follows:

1. We first introduce the defination of the mosaic plot and its usage: what mosaic plots are, what features they have, what aesthetics they have. (This section is adapted from wiki website)
2. We then describe in detail what the basic parts of plots are. (This section is adapted from edav.info)
3. Finally, we walked through the conditions representation in mosaic plots, multiple variables in mosaic plots, and orders of variables from *Mosaic plots with ggplot2*.


### Introduction 介绍 (Mosaic plot 2019)

马赛克图(也称马里梅科图)是一种将两个或两个以上定性变量进行可视化的统计报告图[1]，它是自旋图的多维扩展，自旋图只对一个变量的信息进行展示[2]。它给出数据的整体概况，并让识别变量之间的关系更加简单。例如，当不同类别的方框都具有相同的面积时，表示变量之间是独立的[3]。Hartigan和Kleiner于1981年创建了马赛克图，Friendly于1994年对其进行了扩展[4]。由于马赛克图很像马里梅科印刷品，因此也被称为梅科图。这是非常好的进行定性变量数据可视化的方式之一。

与柱状图和自旋图一样，每个方框的面积，与该类别内的观测值数量成正比[5]。

### Basic Parts of Mosaic Plots

本页是一个正在进行中的工作。我们感谢您的任何意见。如果你想帮助改善这个页面，请考虑向我们的repo贡献。

#### 综概


```r
library(readr)
library(vcd)
df = read_csv("resources/website_sharing_whole_class_mosaic_plot_translation/MusicIcecream.csv")
```

马赛克图需要一些时间来学习如何进行正确的阅读和绘制。特别是在刚开始的时候，我们建议循序渐进的学习绘制：先从划分一个变量开始，然后每次添加一个其他的变量。完整的马赛克图会对每个变量都进行一次拆分。

* 需要注意：如果你的数据有一个列是频率，就像下面的例子一样，计数列必须称为Freq。(表格Tables和矩阵matrices也可以使用，更多细节请参见?vcd::structable。)

* 还要注意的是：所有这些图都是用vcd::mosaic()绘制的，而不是用R里的基本函数包mosaicplot()。


#### 数据如下。


```r
df
```

```
## [90m# A tibble: 8 x 4[39m
##   Age   Favorite   Music      Freq
##   [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m      [3m[90m<chr>[39m[23m     [3m[90m<dbl>[39m[23m
## [90m1[39m old   bubble gum classical     1
## [90m2[39m old   bubble gum rock          1
## [90m3[39m old   coffee     classical     3
## [90m4[39m old   coffee     rock          1
## [90m5[39m young bubble gum classical     2
## [90m6[39m young bubble gum rock          5
## [90m7[39m young coffee     classical     1
## [90m8[39m young coffee     rock          0
```

#### 划分变量

##### 仅按年龄划分。


```r
vcd::mosaic(~Age, df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

##### 先按年龄划分，再按照音乐。


```r
vcd::mosaic(Music ~ Age, df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

需要注意的是，第一组在"年轻 "和 "年长”中拆分，第二组拆分则将每个年龄段的人按照"古典 "和 "摇滚"进行再次划分。

##### 先按年龄划分，再按音乐划分，再按喜爱划分。


```r
vcd::mosaic(Favorite ~ Age + Music, df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

#### 划分的方向

请注意，在前面的例子中，分割的方向如下。

##### 年龄--横向分割

##### 音乐--垂直分割

##### 最喜欢的--横向分割

这是默认的方向模式：交替方向从水平方向开始。因此，我们得到如下同样的图：


```r
vcd::mosaic(Favorite ~ Age + Music, 
       direction = c("h", "v", "h"), df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />

可以根据需要改变方向。例如，要创建一个doubledecker图，除了最后一个变量，所有的分割都是垂直的。


```r
vcd::mosaic(Favorite ~ Age + Music,
       direction = c("v", "v", "h"), df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-6-1.png" width="672" style="display: block; margin: auto;" />

需要注意的是，方向向量是按照拆分的顺序（年龄、音乐、喜爱），而不是按照公式中变量出现的顺序。在公式中，最后一个要拆分的变量要在”~”前先列出来。


#### 填充颜色

填充颜色的分类是根据最后划分的维度——即因变量（本例中最喜欢的冰淇淋口味）。(如果不能正常运行，请更新到vcd的最新版本。)


```r
vcd::mosaic(Favorite ~ Age + Music, 
       highlighting_fill = c("grey90", "cornflowerblue"),
       df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-7-1.png" width="672" style="display: block; margin: auto;" />

#### 标签

想要看关于标签选项的官方文档，请参见Strucplot框架中关于标签的说明。

##### 旋转标签

rot_labels = 向量设置了图形四边的旋转度数--而不是变量分割顺序--这个顺序是：上、右、下、左。(与典型的基本图形顺序不同!)默认是 rot_labels = c(0, 90, 0, 90)。


```r
vcd::mosaic(Favorite ~ Age + Music, 
       labeling = vcd::labeling_border(rot_labels = c(45, -45, 0, 0)),
       df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-8-1.png" width="672" style="display: block; margin: auto;" />

##### 简称标签

标签按照分割的顺序进行缩写（写作direction=）。缩写算法在消除元音后（如果需要的话），会返回return指定的字符数。

关于更多的格式化选项，请参见>?vcd::labeling_border。


```r
vcd::mosaic(Favorite ~ Age + Music, 
       labeling = vcd::labeling_border(abbreviate_labs = c(3, 1, 6)), 
       df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-9-1.png" width="672" style="display: block; margin: auto;" />

#### 单元间距


```r
vcd::mosaic(Favorite ~ Age + Music,
       spacing = vcd::spacing_equal(sp = unit(0, "lines")),
       df)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-10-1.png" width="672" style="display: block; margin: auto;" />

想看更多细节, 请看 >?vcd::spacings

##### 使用vcd::doubledecker中的 Mosaic 


```r
data(Arthritis, package = "vcd")
vcd::doubledecker(Improved ~ Treatment + Sex, data=Arthritis)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-11-1.png" width="672" style="display: block; margin: auto;" />


```r
vcd::doubledecker(Music ~ Favorite + Age, 
                  xtabs(Freq ~ Age + Music + Favorite, df))
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-12-1.png" width="672" style="display: block; margin: auto;" />

##### 使用ggplot中的马赛克图

要在ggplot2框架中创建马赛克图，请使用ggmosaic包中的geom_mosaic()。

https://cran.r-project.org/web/packages/ggmosaic/vignettes/ggmosaic.html

#### 理论

#### 何时使用

当您想查看多个分类变量之间的关系时，请注意以下几点

#### 考虑因素

##### 标签

在马赛克图中，当有很多维度时，标签的可读性可能会较差。这可以通过以下方法来缓解： - 缩写名称 - 旋转标签。

##### 纵横比

* 长度比面积更容易判断，所以尽量使用相同宽度或高度的矩形。

* 更高更瘦的矩形判断效果更好（因为我们更擅长区分长度而不是面积）。

##### 矩形之间的间隙

* 无间隙=最高效率

然而，间隙可以帮助提高可读性，所以请尝试不同的组合。

* 可在划分处有间隙

* 可以在层次结构中改变间隙大小。

##### 颜色

* 对细分小组中的比率有好处

* 显示残余（residual）

* 强调特定群体

#### 其他资源

安东尼-尤文的《用R进行图形数据分析》第七章

本文第三部分（见以下详细内容）

### Part 3
#### ggmosaic的基础知识

* 用于分类数据的可视化。

* 可以生成条形图、堆叠条形图、马赛克图和双层图。

* 图是分层构造的，所以变量的排序是非常重要的。

* 集成在ggplot2中的geom里，允许分面(facetting)和分层(layering)。

#### 创建gmosaic

ggmosaic主要是使用ggproto和productplots包创建的。

ggproto能够让你在自己的包中扩展ggplot2。

* 使用了productplots包中的数据处理方法。

* 为了绘制geom，需要计算xmin、xmax、ymin和ymax。

#### ggplot2的缺陷

ggplot2不能处理总体数量在变化的变量群。

* 目前的解决方案：写成x=product(x1，x2)来同时读入变量x1和x2。

* product函数。

* 是为了wrapper list而设计的函数。

* 允许它通过代码检测。

这些限制也会导致标签的问题，但这些都可以手动修复。

#### geom_mosaic：设定规则。

规则如下：

* weight：选择一个权重变量

* x：选择要添加到公式中的变量

* 写为x = product(x1, x2, ...)

* fill : 选择一个要填充的变量

* 如果变量没有在x中被调用，它将被添加到公式的首位。

* conds : 选择一个变量作为条件

写为conds = product(cond1, cond2, ...)

然后通过productplots函数发送这些值，以创建所需分布的公式。


```r
#公式：
weight ~ fill + x | conds
```

```
## weight ~ fill + x | conds
```


##### 从规则到代码#

如何写成代码

* weight=1

* x = product(Y, X)

* fill=W

* conds = product(Z)

* 这些美学设置了分配的公式。

##### 1 ~ X


```r
library(ggplot2)
library(ggmosaic)
library(gridExtra)
 ggplot(data = fly) +
   geom_mosaic(aes(x = product(RudeToRecline), fill=RudeToRecline), na.rm=TRUE) +
   labs(x="Is it rude recline? ", title='f(RudeToRecline)') 
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-14-1.png" width="672" style="display: block; margin: auto;" />

##### 1 ~ Y + X


```r
ggplot(data = fly) +
   geom_mosaic(aes(x = product(DoYouRecline, RudeToRecline), fill=DoYouRecline), na.rm=TRUE) + 
  labs(x = "Is it rude recline? ", title='f(DoYouRecline | RudeToRecline) f(RudeToRecline)')
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-15-1.png" width="672" style="display: block; margin: auto;" />

##### 1 ~ X + Y / Z


```r
ggplot(data = fly) +
   geom_mosaic(aes(x = product(DoYouRecline, RudeToRecline), fill=DoYouRecline, conds=product(Gender)), na.rm=TRUE, divider=mosaic("v")) +  labs(x = "Is it rude recline? ", title='f(DoYouRecline, RudeToRecline| Gender)')
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-16-1.png" width="672" style="display: block; margin: auto;" />

##### Alternative to conditioning: facetting


```r
ggplot(data = fly) +
   geom_mosaic(aes(x = product(DoYouRecline, RudeToRecline), fill=DoYouRecline), na.rm=TRUE) +  labs(x = "Is it rude recline? ", title='f(DoYouRecline, RudeToRecline| Gender)') + facet_grid(Gender~.)
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-17-1.png" width="672" style="display: block; margin: auto;" />


#### Importance of ordering


```r
 ggplot(data = fly) +
   geom_mosaic(aes(x = product(DoYouRecline, RudeToRecline), fill=DoYouRecline), na.rm=TRUE) +  labs(x = "Is it rude recline? ", title='f(DoYouRecline | RudeToRecline) f(RudeToRecline)') + theme(plot.title = element_text(size = rel(1)))
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-18-1.png" width="672" style="display: block; margin: auto;" />

```r
 ggplot(data = fly) +
   geom_mosaic(aes(x = product(RudeToRecline, DoYouRecline), fill=DoYouRecline), na.rm=TRUE) + labs(x = "" , y = "Is it rude recline? ", title='f(DoYouRecline | RudeToRecline) f(RudeToRecline)') + coord_flip() + theme(plot.title = element_text(size = rel(1)))
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-18-2.png" width="672" style="display: block; margin: auto;" />

```r
par(mfrow=c(2,1))
```




#### geom_mosaic的其他特征

geom_mosaic独有的参数。

* divider: 用于声明要使用的分区的类型。
* offset：设置第一条spine之间的空间。

#### Divider function. 分割类型。
每个部分有四个选项。

* vspine：宽度不变，高度可变。
* hspine：高度不变，宽度可变。
* vbar：高度不变，宽度不同。
* hbar：宽度不变，高度不同。


```r
hbar <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq), fill=FlightFreq), divider="hbar", na.rm=TRUE) + labs(x=" ", title='divider = "hbar"') 


hspine <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq), fill=FlightFreq),  divider="hspine", na.rm=TRUE) + labs(x=" ", title='divider = "hspine"') 


vbar <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq), fill=FlightFreq), divider="vbar", na.rm=TRUE) + labs(y=" ", x="", title='divider = "vbar"') 
 
vspine <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq), fill=FlightFreq), divider="vspine", na.rm=TRUE) + labs(y=" ", x="", title='divider = "vspine"') 

hbar
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-19-1.png" width="672" style="display: block; margin: auto;" />

```r
hspine 
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-19-2.png" width="672" style="display: block; margin: auto;" />

```r
vbar
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-19-3.png" width="672" style="display: block; margin: auto;" />

```r
vspine
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-19-4.png" width="672" style="display: block; margin: auto;" />

#### 使用一个或多个变量进行分区

* mosaic()
 + 默认
 + 将在交替的方向使用spine
 + 从横向的spine开始
* mosaic("v")
 + 从竖向spine开始，然后交替进行。
* ddecker()
 + 选择n-1个水平spine，并以竖向spine结束
* 定义每种类型的分区
 + c("hspine"、"vspine"、"hbar")
 

```r
h_mosaic <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=mosaic("h")) +
  theme(axis.text.x=element_blank(), legend.position="none") + 
  labs(x=" ", title='divider= mosaic()')

v_mosaic <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=mosaic("v")) +
  theme(axis.text.x=element_blank()) + 
  labs(x=" ", title='divider= mosaic("v")')


doubledecker <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=ddecker()) +
  theme(axis.text.x=element_blank()) +
  labs(x=" ", title='divider= ddecker()')

h_mosaic
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-20-1.png" width="672" style="display: block; margin: auto;" />

```r
v_mosaic
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-20-2.png" width="672" style="display: block; margin: auto;" />

```r
doubledecker
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-20-3.png" width="672" style="display: block; margin: auto;" />
 


```r
mosaic4 <-  ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=c("vspine", "vspine", "hbar")) +
  theme(axis.text.x=element_blank()) +
  labs(x=" ", title='divider= c("vspine", "vspine", "hbar")') 

mosaic5 <-  ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=c("hbar", "vspine", "hbar")) +
  theme(axis.text.x=element_blank()) +
  labs(x=" ", title='divider= c("hbar", "vspine", "hbar")')

mosaic6 <-  ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=c("hspine", "hspine", "hspine")) +
  theme(axis.text.x=element_blank()) +
  labs(x=" ", title='divider= c("hspine", "hspine", "hspine")')

mosaic7 <-  ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Gender, Region), fill=FlightFreq), na.rm=T, divider=c("vspine", "vspine", "vspine")) +
  theme(axis.text.x=element_blank()) +
  labs(x=" ", title='divider= c("vspine", "vspine", "vspine")')

mosaic4
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-21-1.png" width="672" style="display: block; margin: auto;" />

```r
mosaic5
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-21-2.png" width="672" style="display: block; margin: auto;" />

```r
mosaic6
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-21-3.png" width="672" style="display: block; margin: auto;" />

```r
mosaic7
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-21-4.png" width="672" style="display: block; margin: auto;" />


#### geom_mosaic: offset

offset。设置第一条spine之间的空间大小

* 默认值default=0.01
* 分区之间的空间会随着层数的增加而减小。

#### 调整offset


```r
offset1 <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Region), fill=FlightFreq), na.rm=TRUE) + labs(x="Region", y=" ",  title=" offset = 0.01") 

offset0 <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Region), fill=FlightFreq), na.rm=TRUE, offset = 0) + labs(x="Region", y=" ",  title=" offset = 0")

offset2 <- ggplot(data = fly) +
   geom_mosaic(aes(x = product(FlightFreq, Region), fill=FlightFreq), na.rm=TRUE, offset = 0.02) + labs(x="Region", y=" ",  title=" offset = 0.02")

offset1
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-22-1.png" width="672" style="display: block; margin: auto;" />

```r
offset0
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-22-2.png" width="672" style="display: block; margin: auto;" />

```r
offset2
```

<img src="website_sharing_whole_class_mosaic_plot_translation_files/figure-html/unnamed-chunk-22-3.png" width="672" style="display: block; margin: auto;" />


#### Plotly


```r
library(plotly)
gg <-ggplot(data = fly) +
   geom_mosaic(aes(x = product(DoYouRecline, RudeToRecline), fill=DoYouRecline), na.rm=TRUE) + labs(x = "Is it rude recline? ", title='f(DoYouRecline | RudeToRecline) f(RudeToRecline)')
ggplotly(gg)
```

<!--html_preserve--><div id="htmlwidget-6651b88b026e9fd99465" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-6651b88b026e9fd99465">{"x":{"data":[{"x":[0.423934426229508,0.423934426229508,1,1,0.423934426229508],"y":[0,0.237591285970801,0.237591285970801,0,0],"text":"Always<br>No, not rude at all<br>Frequency: 124","key":["Always","No, not rude at all"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(248,118,109,0.8)","hoveron":"fills","name":"Always","legendgroup":"Always","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.0914754098360656,0.0914754098360656,0.413934426229508,0.413934426229508,0.0914754098360656],"y":[0,0.0308069518429594,0.0308069518429594,0,0],"text":"Always<br>Yes, somewhat rude<br>Frequency: 9","key":["Always","Yes, somewhat rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(248,118,109,0.8)","hoveron":"fills","name":"Always","legendgroup":"Always","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0,0,0.0814754098360656,0.0814754098360656,0],"y":[0,0.04064203506043,0.04064203506043,0,0],"text":"Always<br>Yes, very rude<br>Frequency: 3","key":["Always","Yes, very rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(248,118,109,0.8)","hoveron":"fills","name":"Always","legendgroup":"Always","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.423934426229508,0.423934426229508,1,1,0.423934426229508],"y":[0.247125911863256,0.524954431748467,0.524954431748467,0.247125911863256,0.247125911863256],"text":"Usually<br>No, not rude at all<br>Frequency: 145","key":["Usually","No, not rude at all"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(163,165,0,0.8)","hoveron":"fills","name":"Usually","legendgroup":"Usually","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.0914754098360656,0.0914754098360656,0.413934426229508,0.413934426229508,0.0914754098360656],"y":[0.0403415777354153,0.132762433264293,0.132762433264293,0.0403415777354153,0.0403415777354153],"text":"Usually<br>Yes, somewhat rude<br>Frequency: 27","key":["Usually","Yes, somewhat rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(163,165,0,0.8)","hoveron":"fills","name":"Usually","legendgroup":"Usually","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0,0,0.0814754098360656,0.0814754098360656,0],"y":[0.0501766609528859,0.0908186960133159,0.0908186960133159,0.0501766609528859,0.0501766609528859],"text":"Usually<br>Yes, very rude<br>Frequency: 3","key":["Usually","Yes, very rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(163,165,0,0.8)","hoveron":"fills","name":"Usually","legendgroup":"Usually","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.423934426229508,0.423934426229508,1,1,0.423934426229508],"y":[0.534489057640923,0.691605875782904,0.691605875782904,0.534489057640923,0.534489057640923],"text":"About half the time<br>No, not rude at all<br>Frequency: 82","key":["About half the time","No, not rude at all"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,191,125,0.8)","hoveron":"fills","name":"About half the time","legendgroup":"About half the time","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.0914754098360656,0.0914754098360656,0.413934426229508,0.413934426229508,0.0914754098360656],"y":[0.142297059156749,0.262101871879369,0.262101871879369,0.142297059156749,0.142297059156749],"text":"About half the time<br>Yes, somewhat rude<br>Frequency: 35","key":["About half the time","Yes, somewhat rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,191,125,0.8)","hoveron":"fills","name":"About half the time","legendgroup":"About half the time","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0,0,0.0814754098360656,0.0814754098360656,0],"y":[0.100353321905772,0.100353321905772,0.100353321905772,0.100353321905772,0.100353321905772],"text":"About half the time<br>Yes, very rude<br>Frequency: 0","key":["About half the time","Yes, very rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,191,125,0.8)","hoveron":"fills","name":"About half the time","legendgroup":"About half the time","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.423934426229508,0.423934426229508,1,1,0.423934426229508],"y":[0.70114050167536,0.923403317583528,0.923403317583528,0.70114050167536,0.70114050167536],"text":"Once in a while<br>No, not rude at all<br>Frequency: 116","key":["Once in a while","No, not rude at all"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,176,246,0.8)","hoveron":"fills","name":"Once in a while","legendgroup":"Once in a while","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.0914754098360656,0.0914754098360656,0.413934426229508,0.413934426229508,0.0914754098360656],"y":[0.271636497771825,0.71320280752091,0.71320280752091,0.271636497771825,0.271636497771825],"text":"Once in a while<br>Yes, somewhat rude<br>Frequency: 129","key":["Once in a while","Yes, somewhat rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,176,246,0.8)","hoveron":"fills","name":"Once in a while","legendgroup":"Once in a while","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0,0,0.0814754098360656,0.0814754098360656,0],"y":[0.109887947798228,0.258908743019804,0.258908743019804,0.109887947798228,0.109887947798228],"text":"Once in a while<br>Yes, very rude<br>Frequency: 11","key":["Once in a while","Yes, very rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(0,176,246,0.8)","hoveron":"fills","name":"Once in a while","legendgroup":"Once in a while","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.423934426229508,0.423934426229508,1,1,0.423934426229508],"y":[0.932937943475984,1,1,0.932937943475984,0.932937943475984],"text":"Never<br>No, not rude at all<br>Frequency: 35","key":["Never","No, not rude at all"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(231,107,243,0.8)","hoveron":"fills","name":"Never","legendgroup":"Never","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0.0914754098360656,0.0914754098360656,0.413934426229508,0.413934426229508,0.0914754098360656],"y":[0.722737433413366,1,1,0.722737433413366,0.722737433413366],"text":"Never<br>Yes, somewhat rude<br>Frequency: 81","key":["Never","Yes, somewhat rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(231,107,243,0.8)","hoveron":"fills","name":"Never","legendgroup":"Never","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null},{"x":[0,0,0.0814754098360656,0.0814754098360656,0],"y":[0.26844336891226,1,1,0.26844336891226,0.26844336891226],"text":"Never<br>Yes, very rude<br>Frequency: 54","key":["Never","Yes, very rude"],"type":"scatter","mode":"lines","line":{"width":0.377952755905512,"color":"transparent","dash":"solid"},"fill":"toself","fillcolor":"rgba(231,107,243,0.8)","hoveron":"fills","name":"Never","legendgroup":"Never","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","_isSimpleKey":true,"_isNestedKey":false,"frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":136.62100456621},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"f(DoYouRecline | RudeToRecline) f(RudeToRecline)","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-0.05,1.05],"tickmode":"array","ticktext":["Yes, very rude","Yes, somewhat rude","No, not rude at all"],"tickvals":[0.0407377049180328,0.252704918032787,0.711967213114754],"categoryorder":"array","categoryarray":["Yes, very rude","Yes, somewhat rude","No, not rude at all"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Is it rude recline? ","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-0.05,1.05],"tickmode":"array","ticktext":["Always","Usually","About half the time","Once in a while","Never"],"tickvals":[0.020321017530215,0.0704976784831009,0.100353321905772,0.184398345409016,0.63422168445613],"categoryorder":"array","categoryarray":["Always","Usually","About half the time","Once in a while","Never"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"y","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.96751968503937},"annotations":[{"text":"DoYouRecline","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"1bb237515ac":{"x":{},"fill":{},"y":{},"x1__DoYouRecline":{},"x2__RudeToRecline":{},"type":"scatter"}},"cur_data":"1bb237515ac","visdat":{"1bb237515ac":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->



### 参考文献

1. Sandra D. Schlotzhauer (1 April 2007). Elementary Statistics Using JMP. SAS Institute. p. 407. ISBN 978-1-59994-428-9.

2. New Techniques and Technologies for Statistics II: Proceedings of the Second Bonn Seminar. IOS Press. 1 January 1997. p. 254. ISBN 978-90-5199-326-4.

3. Michael Friendly (1 January 1991). SAS System for Statistical Graphics. SAS Institute. pp. 512–. ISBN 978-1-55544-441-9.

4. SAS Institute (6 September 2013). JMP 11 Basic Analysis. SAS Institute. pp. 251–. ISBN 978-1-61290-684-3.

5. Martin Theus; Simon Urbanek (23 March 2011). Interactive Graphics for Data Analysis: Principles and Examples. CRC Press. ISBN 978-1-4200-1106-7.

6. Mosaic plot. (2019, June 16). Retrieved November 04, 2020, from https://en.wikipedia.org/wiki/Mosaic_plot
