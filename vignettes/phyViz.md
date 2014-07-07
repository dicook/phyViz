<!--
%\VignetteEngine{knitr::knitr}
%\VignetteDepends{knitr}
%\VignetteIndexEntry{phyViz: Phylogenetic Visualization}

-->

How to use the package **phyViz**
========================================================

**Author:** Lindsay Rutter (lrutter@iastate.edu)

**Date:** April 25, 2014

**Description:** The **phyViz** package allows phylogeneticists to visualize and interpret their trees in multiple ways, which each come with their pros and cons. This vignette is intended to walk you through the different options available to you with this package.

**Caution:** igraph must be used with version 0.7.0


**CONTENTS:**
-------------------------------------------------

Preprocessing Pipeline

Functions for Individual Vertices

Functions for Pairs of Vertices

Functions for the Whole Tree

Visualization of Pathway between Two Vertices

Visualization of Pathway between Two Vertices Superimposed on Tree

Generating Pairwise Matrix between Set of Vertices

Conclusion



Preprocessing Pipeline:
------------------------

There is a preprocessing pipeline that you must use before visualizing your phylogentic tree. First, you must load the necessary libraries: 


```r
options(warn = -1)
library(phyViz)
library(plyr)
library(reshape2)
library(ggplot2)
library(stringr)
library(igraph)

load(system.file("doc", "example", "tree.rda", package = "phyViz"))
```


In the **phyViz** package, there is an example file containing phylogenetic tree of soybean varieties called **tree.rda**. It may be helpful to load that example file so that you can follow along with the commands and options introduced in this vignette. To ensure that you have uploaded the correct, raw **tree.rda** file, you can observe the first ten lines of it:


```r
load(system.file("doc", "example", "tree.rda", package = "phyViz"))
head(tree)
```

```
##           child year yield year.imputed min.repro.year parent.type
## 1         5601T 1981    NA         TRUE            Inf      mother
## 2         Adams 1948  2734        FALSE           1960      mother
## 3          A.K. 1910    NA         TRUE           1912      mother
## 4 A.K. (Harrow) 1912  2665        FALSE           1955      mother
## 5        Altona 1968    NA        FALSE            Inf      mother
## 6         Amcor 1979  2981        FALSE            Inf      mother
##      parent
## 1 Hutcheson
## 2  Dunfield
## 3      <NA>
## 4      A.K.
## 5  Flambeau
## 6  Amsoy 71
```


Now that the tree file has been loaded, it must now be converted to its data frame object. The data frame should consist of only three columns, representing the two varieties connected by an edge weight of unity. We can see in this particular tree, there are 340 edges connecting the vertices. This **treeGraph** object will be needed in several of the subsequent graph theoretical functions derived from the **igraph** package:


```r
treeGraph = processTreeGraph(tree)
head(treeGraph)
```

```
##           child    parent edgeWt
## 1         5601T Hutcheson      1
## 2         Adams  Dunfield      1
## 4 A.K. (Harrow)      A.K.      1
## 5        Altona  Flambeau      1
## 6         Amcor  Amsoy 71      1
## 7         Amsoy     Adams      1
```

```r
dim(treeGraph)
```

```
## [1] 340   3
```


Next, the data frame object **treeGraph** must be convereted into an graph object that can be read by igraph package, using the following command:


```r
mygraph = graph.data.frame(treeGraph, directed = T)
```


As an side note, you could optionally write the **treeGraph** object into a .csv file that will be saved to your working directory, and could later be visualized in the software **Cytoscape**. However, we will not be covering this option in this vignette.


```r
sbTreeGraph = write.csv(treeGraph, "sbTreeGraphTest.csv")
```


At this point, you are complete with the preprocessing required to use the **phyViz** package. If you type in the command ls() into your terminal, you should see the tree object, treeGraph object, and mygraph object:


```r
ls()
```

```
## [1] "mygraph"     "sbTreeGraph" "tree"        "treeGraph"
```



Functions for Individual Vertices:
----------------------------------------------------

**phyViz** offers several back-of-the-envelope functions that you can use time-by-time on individual vertices. In this section, we will introduce them.

First, the function **isParent** can return a boolean variable to indicate whether or not the second variety is a parent of the first variety.


```r
isParent("Young", "Essex", tree)
```

```
## [1] TRUE
```

```r
isParent("Essex", "Young", tree)
```

```
## [1] FALSE
```


Similarly, the function **isChild** can return a boolean variable to indicate whether or not the first variety is a child of the second variety.


```r
isChild("Young", "Essex", tree)
```

```
## [1] TRUE
```

```r
isChild("Essex", "Young", tree)
```

```
## [1] FALSE
```


It is also possible to quickly derive the year of a given variety using the **getYear** function:


```r
getYear("Young", tree)
```

```
## [1] 1968
```

```r
getYear("Essex", tree)
```

```
## [1] 1962
```


Fortunately, these example results make consistent sense in that the "Young" variety is a child to the "Essex" variety by an age difference of six years.

In some cases, you may wish to have a list of all the parents of a given variety. This can be achieved using the **getparent** function:


```r
getparent("Young", tree)
```

```
## [1] "Davis" "Essex"
```

```r
getparent("Tokyo", tree)
```

```
## [1] NA NA
```

```r
getYear("Tokyo", tree)
```

```
## [1] 1907
```


We learn from this that "Essex" is not the only parent of "Young". We also see that as "Tokyo" is a grandparent of the dataset (with a very early year, for this particular dataset, of 1902), it does not have any documented parents.

Likewise, in other cases, you may wish to have a list of all the children of a given variety. This can be achieved using the **getchild** function:


```r
getchild("Tokyo", tree)
```

```
## [1] "Ogden"    "Volstate"
```

```r
getchild("Ogden", tree)
```

```
##  [1] "D55-4090"       "D55-4159"       "D55-4168"       "N45-745"       
##  [5] "Ogden x CNS"    "C1069"          "C1079"          "D51-2427"      
##  [9] "Kent"           "N44-92"         "N48-1101"       "Ralsoy x Ogden"
```


We find that even though the "Tokyo" variety is a grandparent of the dataset, it only had two children. However, one of its children, "Ogden", produced twelve children.


Functions for Pairs of Vertices:
----------------------------------------------------

Say you have a pair of vertices, and you wish to determine the degree of separation of the shortest path between them, where edges represent parent-child relationships. You can accomplish that with the **getDegree** function.


```r
getDegree("Tokyo", "Ogden", tree)
```

```
## [1] 1
```

```r
getDegree("Tokyo", "Holladay", tree)
```

```
## [1] 7
```


As expected, the shortest path between the "Tokyo" and "Ogden" varieties has a value of one, as they are a direct parent-child relationship. However, the shortest path between "Tokyo" and one of its great-reat-great-etc-granchildren, "Holladay" has a much higher degree. Note that degree calculations in this case are not limited to one linear string of parent-child relationships; cousins and siblings and products thereof will also have computatable degrees via nonlinear strings of parent-child relationships.

Functions for the Whole Tree:
----------------------------------------------------

There are many parameters about the tree that you may wish to know that cannot easily be obtained through images and tables. With the use of the **igraph** package, the below function **getBasicStatistics** can be used to return a list of information about typical graph theoretical measurements of the whole tree. For instance, is the whole tree connected? If not, how many separated components does it contain? In addition to these parameters, the **getBasicStatistics** function will also return the number of nodes, the number of edges, the average path length, the graph diameter, etc.:


```r
getBasicStatistics(mygraph)
```

```
## $isConnected
## [1] FALSE
## 
## $numComponents
## [1] 4
## 
## $avePathLength
## [1] 5.334
## 
## $graphDiameter
## [1] 13
## 
## $numNodes
## [1] 223
## 
## $numEdges
## [1] 340
## 
## $logN
## [1] 5.407
```


In this case, we learn that our tree is actually not all connected by parent-child edges, and that instead, it is composed of four separate components. We see that the average path length of the tree is 5.334, that the graph diameter is 13, and that the logN value is 5.407. We also see that the number of nodes in the tree is 223 that are connected by 340 edges.

Visualization of Pathway between Two Vertices:
------------------------------------------------------

As this data set deals with soy bean lineages, it may be useful for agronomists to track how two varieties are related to each other via parent-child relationships. Then, any dramatic changes in protein yield, SNP varieties, and other measures of interest can be tracked across the genetic timeline, and pinpointed to certain varieties along the way.

The **phyViz** software can allow you to select two varieties of interest, and view the shortest pathway between them. You can produce a neat visual that informs you of all the varieties involved in the path between the two varieties of interest, as well as the years of all varieties involved in the path.

To produce and view this plot, three functions must be called in the order presented below (**getPath**, **buildPathDF**, and **generatePathPlot**). We next introduce each of these three functions.

The **getPath** function determines the shortest path between the two inputted vertices, and takes into account whether or not the graph is directed. If there is a path, the list of vertices of the path (and their associated years) will be returned. For a directed graph, the direction matters. However, **getPath** will check both directions and return the path if it exists. The third parameter indicates the logical boolean of whether or not the graph is directed. Below, we look at all three possibilities (undirected and directed in reverse orders) between two varieties:


```r
getPath("Brim", "Bedford", F, mygraph)
```

```
## $pathVertices
## [1] "Brim"    "Young"   "Essex"   "T80-69"  "J74-40"  "Forrest" "Bedford"
## 
## $yearVertices
## [1] "1977" "1968" "1962" "1975" "1975" "1973" "1978"
```



```r
getPath("Brim", "Bedford", T, mygraph)
```

```
## [1] "Warning: There is no path between those two vertices"
```

```
## list()
```



```r
getPath("Bedford", "Brim", T, mygraph)
```

```
## [1] "Warning: There is no path between those two vertices"
```

```
## list()
```


We can derive from the empty list returned in the last two of the three commands that the varieties "Brim" and "Bedford" are not connected by a linear sequence of parent-child relationships. Rather, they are derived from a branch as some point, as siblings and/or cousins. Unless you are working with a dataset that must be analyzed as a directed phylogenetic graph, it is best to use the **getPath** function with the undirected specification (F) as the third parameter.

As such, we save the path between these two varieties to a variable called **path**:


```r
path = getPath("Brim", "Bedford", F, mygraph)
```


Now that we have a **path** object that consists of two lists (the variety names and years), we can build a data frame object from it using the **buildPathDF** function, as shown below.


```r
plotPathDF = buildPathDF(path)
plotPathDF
```

```
##     label xstart ystart xend yend    x y
## 1    Brim   1977    1.1 1968  1.9 1977 1
## 2   Young   1968    2.1 1962  2.9 1968 2
## 3   Essex   1962    3.1 1975  3.9 1962 3
## 4  T80-69   1975    4.1 1975  4.9 1975 4
## 5  J74-40   1975    5.1 1973  5.9 1975 5
## 6 Forrest   1973    6.1 1978  6.9 1973 6
## 7 Bedford   1978    7.1 1978  7.1 1978 7
```


As you can see from the output above, the **plotPathDF** is a dataframe of information about the path object that can later be used for visualization. The dataframe includes the edge position information for all edges in the path, with the columns **label** (name of each variety) of each node, **xstart** (the x-axis position of the outgoing edge (leaving to connect to the node at the next largest y-value)), **ystart** (the y-axis position of the outgoing edge (leaving to connect to the node at the next largest y-value), **xend** (the x-axis position of the outgoing edge (connected to the node at the next largest y-value)), **yend** (the y-axis position of the outgoing edge (connected to the node at the next largest y-value))), **x** (the year of the variety, the x-axis value for which the label and incoming/outgoing edges are centered), and **y** (the y-axis value, which is the index of the path, incremented by unity).

As you can see from the last row, the last variety of the path does not have an edge coming out of it (as **xstart** = **xend** and **ystart** = **yend**). This is because there is one less edge in the graph than there are vertices. 

If these columns do not make sense, that is not a problem. Just know that now we can feed this **plotPathDF** object into the next function **plotPathImage** as follows:


```r
plotPathImage = generatePathPlot(plotPathDF)
plotPathImage
```

![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19.png) 


Indeed, as predicted above, the image verifies that the two varieties "Brim" and "Bedford" are cousin-like relationships, and are not connected by a linear string of parent-child relationships. Also, as mentioned above, in this plot, the x-axis represents the years, meaning that the center of the text box for each variety represents its corresponding year.

If, for some reason, you are looking at *directed* phylogenetic trees, you will need to use the true logical condition for the third parameter of the function **getPath**. The example below will hopefully reassure you that if you use this condition on a pathway composed of linear parent-child relationships, then either ordering of the first two parameters will work:


```r
path = getPath("Narow", "Tokyo", T, mygraph)
plotPathDF = buildPathDF(path)
plotPathImage = generatePathPlot(plotPathDF)
plotPathImage
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 



```r
path = getPath("Tokyo", "Narow", T, mygraph)
plotPathDF = buildPathDF(path)
plotPathImage = generatePathPlot(plotPathDF)
plotPathImage
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21.png) 


Visualization of Pathway between Two Vertices Superimposed on Tree:
------------------------------------------------------

If you are curious to see the above-demonstrated shortest pathway between two vertices of interest, only now superimposed over all the varieties and edges in the whole tree, then **phyViz** also has a series of functions (**buildSpreadTotalDF**, **buildMinusPathDF**, **buildEdgeTotalDF**, **buildPlotTotalDF**, and **generateTotalPlot**) that can achieve just that. The first four functions each generate a different data frame, and all four of those data frames will then be used as input to the last function that generates the plot object. Although observing each data frame is not important for the end results, this procedure is outlined below:

First, the **buildSpreadTotalDF** function creates a dataframe where the varieties are spread such that their overlap is minimized, even though the x-axis position will represent years. (Note: the **numBin** and **binVector** variables will be explained in more detail at the end of this section).


```r
numBin = 12
binVector = c(1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 12)
spreadTotalDF = buildSpreadTotalDF(tree, numBin, binVector)
head(spreadTotalDF)
```

```
##           uniqueNode uniqueYears
## 218            Tokyo        1907
## 153         N48-1248        1955
## 176         Pershing        1964
## 81  Essex x L69-4143        1975
## 203         Richland        1938
## 49          D51-2427        1960
```


Next, the **buildMinusPathDF** function takes the **spreadTotalDF** object (from the buildSpreadTotalDF function) and the **path** object (from the **getPath** function) as inputs. From these objects, it creates a data frame object of the label, x, and y values of all nodes in the tree. However, the data frame object does not include the labels of the path varieties, as they will be treated differently.


```r
plotMinusPathDF = buildMinusPathDF(spreadTotalDF, path)
head(plotMinusPathDF)
```

```
##              label    x y
## 1             <NA> 1907 1
## 2         N48-1248 1955 2
## 3         Pershing 1964 3
## 4 Essex x L69-4143 1975 4
## 5         Richland 1938 5
## 6         D51-2427 1960 6
```


Third, the **buildEdgeTotalDF** function takes the **spreadTotalDF** object (from the **buildSpreadTotalDF** function) and the **treeGraph** object as inputs. From these objects, it creates a data frame object of the edges between all parent-child relationships in the graph that are appropriately spread out as specificed in the **spreadTotalDF** object:


```r
edgeTotalDF = buildEdgeTotalDF(treeGraph, spreadTotalDF)
head(edgeTotalDF)
```

```
##      x   y xend yend
## 1 1981  12 1979   92
## 2 1948 137 1923   85
## 3 1912  49 1910   13
## 4 1979  44 1971  195
## 5 1966  75 1948  137
## 6 1971 195 1961  194
```


Fourth, the **buildPlotTotalDF** function takes the **spreadTotalDF** object (from the **buildSpreadTotalDF** function) and the **path** object (from the **buildPath** function) to create a data frame object of the text label positions for the varieties in the path, as well as the edges only in the varieties in the path.


```r
plotTotalDF = buildPlotTotalDF(path, spreadTotalDF)
head(plotTotalDF)
```

```
##      label xstart ystart xend yend    x   y
## 1    Narow   1985    156 1972   23 1985 156
## 2  R66-873   1972     23 1954  105 1972  23
## 3  Jackson   1954    105 1942   41 1954 105
## 4 Volstate   1942     41 1907    1 1942  41
## 5    Tokyo   1907      1 1907    1 1907   1
```


Now that we have generated the data frames needed to construct this type of visual object, we use them as input parameters to the **generateTotalPlot** function. The outputted image will correctly position the node labels with x-axis representing the node year, and y-axis representing the node path index. Light grey edges between two nodes represent parent-child relationships between those nodes. To enhance the visual understanding of how the path-of-interest fits into the entire graph structure, the nodes within the path are labelled in boldface, and connected with light-green boldfaced edges.


```r
plotTotalImage = generateTotalPlot(plotMinusPathDF, edgeTotalDF, plotTotalDF)
plotTotalImage
```

![plot of chunk unnamed-chunk-26](figure/unnamed-chunk-26.png) 


Even though the edges of the large tree in this image are criss-crossing in all directions, that was not the focus, and hence the edges not belonging to the green path-of-interest are softly colored in a light gray. The highlight of this image was to keep all varieties in line with their appropriate year (corresponding to the x-axis), and to mitigate any overlap of the text of the varieties. Achieving this can be difficult, especially if your dataset has many varieties scrunched into a narrow set of years. That was the case with this dataset. As can be seen in the image above, most of the hundreds of varieties are associated with years between 1960 and 1975.

And this is where the explanation of the variables **numBin** and **binVector** (used as input parameters to the function **spreadTotalDF**) comes into play. As there is no uniform solution for this complicated problem, the **phyViz** package offers you the flexbility to changes these variables until you can optimize this image so that the text of the nodes of your tree overlap as little as possible. This can be done with a trial-and-error process by tweaking the two variables **numBin** and **binVector** at the start.

Specifically, the **numBin** variable indicates how many bins of equal sizes should be allocated (where bins separate the vertices into groups of years). The **binVector** is a vector of length numBin that includes each integer exactly once between unity and **numBin** in any order. For instance, if **numBin** = 3, then there are six possible vectors for **binVector**: c(1,2,3), c(1,3,2), c(2,1,3), c(2,3,1), c(3,1,2), or c(3,2,1).

The **binVector** will determine the order that increasing y index positions are repeatedly assigned to. For instance, if numBin = 12, and binVector = c(1,4,7,10,2,5,8,11,3,6,9,12), then y-axis position one will be assigned to a variety in the first bin of years, y-axis position two will be assigned to a variety in the fourth bin of years, ...., and y-axis position thirteen will be assigned again to a variety in the first bin of years. This will be repreated until all varieties from all bins have been assigned in that order. This vector can help minimize overlap of the labelling of varieties, as varieites from the same bins (near each other on the x-axis for years) will not have consecutive y-axis values.

The two examples below will show the importance of selecting an appropriate number of bins and order of bins to minimize overlap: 


```r
numBin = 12
binVector = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
spreadTotalDF = buildSpreadTotalDF(tree, numBin, binVector)
plotMinusPathDF = buildMinusPathDF(spreadTotalDF, path)
edgeTotalDF = buildEdgeTotalDF(treeGraph, spreadTotalDF)
plotTotalDF = buildPlotTotalDF(path, spreadTotalDF)
plotTotalImage = generateTotalPlot(plotMinusPathDF, edgeTotalDF, plotTotalDF)
plotTotalImage
```

![plot of chunk unnamed-chunk-27](figure/unnamed-chunk-27.png) 


In this case, even though the number of bins is as large as the clearer-labelled image above, the order of the bins is such that varieties of consecutive x-values (years) will also have consecutive y-values (indices), and hence will be likely to overlap in the year ranges where varieties occur the most.


```r
numBin = 2
binVector = c(1, 2)
spreadTotalDF = buildSpreadTotalDF(tree, numBin, binVector)
plotMinusPathDF = buildMinusPathDF(spreadTotalDF, path)
edgeTotalDF = buildEdgeTotalDF(treeGraph, spreadTotalDF)
plotTotalDF = buildPlotTotalDF(path, spreadTotalDF)
plotTotalImage = generateTotalPlot(plotMinusPathDF, edgeTotalDF, plotTotalDF)
plotTotalImage
```

![plot of chunk unnamed-chunk-28](figure/unnamed-chunk-28.png) 


In this example, we see that with such a small number of bins chosen, the y-axis position designation will be similar to its original random state, and there is again much overlap in text variety labels in the year ranges where varieties occur the most.


Generating Pairwise Distance Matrix between Set of Vertices:
--------------------------------------------------------

It may also be of interest to scientists studying phylogenetics to generate heat maps where the color of each index of the map indicates the distance or years between two vertices.

The package **phyViz** also provides functions for that purpose. Specifically, for a given set of vertices, a heat map of the distance (degree of the shortest path) between all pairs of vertices can be constructed with the **buildDegMatrix** function:



```r
varieties = c("Beeson", "Brim", "Dillon", "Narow", "Zane", "Hood", "York", "Calland", 
    "Columbus", "Crawford", "Kershaw", "Kent", "Bragg", "Davis", "Tokyo", "Hagood", 
    "Young", "Essex", "Holladay", "Cook", "Century", "Pella", "Forrest", "Gasoy", 
    "Cutler")
heatMapDegreeImage = buildDegMatrix(varieties)
heatMapDegreeImage
```

![plot of chunk unnamed-chunk-29](figure/unnamed-chunk-29.png) 


In a similar function, **buildYearMatrix**, the difference in years between all pairwise combinations of vertices can be constructed and viewed:


```r
varieties = c("Beeson", "Brim", "Dillon", "Narow", "Zane", "Hood", "York", "Calland", 
    "Columbus", "Crawford", "Kershaw", "Kent", "Bragg", "Davis", "Tokyo", "Hagood", 
    "Young", "Essex", "Holladay", "Cook", "Century", "Pella", "Forrest", "Gasoy", 
    "Cutler")
heatMapYearImage = buildYearMatrix(varieties)
heatMapYearImage
```

![plot of chunk unnamed-chunk-30](figure/unnamed-chunk-30.png) 


Running this function on this particular set of vertices shows that most combinations of varieties are only a few decades apart in years, with only very few sets of vertices showing difference in years on the order of five or six decades.


Conclusion:
------------------------

The various options of the **phyViz** package can offer you different ways of visually interpreting your trees that each come with advantages and disadvantages. While some visualizations connect nodes to their years, other visualizations lax this idea, and instead connect nodes based on their generation surrounding a given node. And still other visualizations from **phyViz** will allow you to either focus on one pathway, or view that pathway superimposed across the entire tree for reference. Hopefully, the package will have something to offer to you in your data analysis.