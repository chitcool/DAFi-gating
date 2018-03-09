# User-directed unsupervised identification of cell populations
	
## DAFi: User-directed unsupervised filtering and identification of cell populations from flow cytometry data

### Author: 
Yu "Max" Qian, Ph.D., mqian@jcvi.org or qianyu_cs@yahoo.com, Ivan Chang, Ph.D., ichang@jcvi.org, and Bob Sinkovits, Ph.D., sinkovit@sdsc.edu
	
### Copyright: Author and J. Craig Venter Institute
	
Paper link: https://www.biorxiv.org/content/early/2017/09/26/193912

## Description: 
The DAFi package provides a new framework for cell population identification for flow cytometry (FCM) data. The framework is compatible with many existing clustering algorithms such as Kmeans, Kmeans++, mini-batch Kmeans, gaussian mixture models, k-medoids, self-organizing map, etc, and allows user to input user defined gating hierarchy to convert the aforementioned unsupervised algorithms into powerful semi-supervised and automatic cell population identification approach. First, the data is read and preprocessed, then configuration files are parsed and implemented as user defined gating directions. Clustering algorithm choosen in the initiation is then applied to the data events of the whole FCM data at the start of the iterative gating/filtering loop, and optionally again at each specified population subset (reclustering). At each gating step, the user can specify to apply bisecting (events filtering based on user defined boundaries just like in manual gating), slope-based (events filtering based on user defined slopes), or cluster centroids based filtering (filtering all events members of a cluster based on their centroid's inclusion or exclusion by the user defined gates). Outputs include population events and percentages table, as well as an events printout table consisting of all event's transformed channel values and population membership info for external analysis and plotting. Several built-in plotting options are also available, e.g. 2D dot plots of the user specified gating channels, and centroids overlay to the 2D dot plots.

## Supported Environments: 

There are two concurrent implementations of the DAFi framework, one for the HPC environment and uses optimized C binary codes to provide extensive parallelization for large datasets, while the other is for the desktop environment and uses existing R-based packages such as flowCore, FlowSOM, and ClusterR to provide flexibility of choosing different clustering algorithms and recursive filtering strategies. Both versions’ source codes and binary releases are available through the github repository, as well as their docker images for trouble free installation.    

## Input Requirements (see inst/extdata for sample inputs): 

1) A raw FCS file for the R implementation of DAFi or a transformed text-based FCS file for the C implementation of DAFi.
	
2) inclusion.config: a 11-column tab delimited file, for recursive data filtering

|Pop_ID|DimensionX|DimensionY|Min_X|Max_X|Min_Y|Max_Y|Parent_ID|Cluster_Type(0: Clustering; 1: Bisecting; 2: Slope-based)|Visualize_or_Not|Recluster_or_Not|Cell_Phenotype(optional)|
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|1|1|4|20|70|5|55|0|0|0|0|Lymphocyte|
|2|1|2|30|90|0|110|1|1|0|1|Singlets|
|3|4|5|100|150|80|140|2|2|1|1|LiveSinglets|
|4|19|17|76|140|106|200|3|1|0|1|CD4T|
|5|19|17|76|140|55|105|3|1|0|0|CD8T|
|6|8|7|81|140|50|120|3|1|0|0|CD4Treg|
|7|8|7|20|80|25|90|3|1|0|0|CD4Tnonreg|
	
3) exclusion.config: a 11-column tab delimited file with the same format, but for reversed filtering:

|Pop_ID|DimensionX|DimensionY|Min_X|Max_X|Min_Y|Max_Y|Parent_ID|Cluster_Type(0: Clustering; 1: Bisecting; 2: Slope-based)|Visualize_or_Not|Recluster_or_Not|
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|1|1|4|0|85|100|200|0|0|1|0|

## Get the software and documentations

Check the [releases](https://github.com/JCVenterInstitute/DAFi-gating/releases) to obtain the [latest release](https://github.com/JCVenterInstitute/DAFi-gating/releases/latest)

### R

#### install into R
For the DAFi R implementation framework, R version > 3.4 is required (https://cran.r-project.org/bin/). In addition, please have installed:
1) flowCore (https://www.bioconductor.org/packages/release/bioc/html/flowCore.html)
2) flowViz (http://bioconductor.org/packages/release/bioc/html/flowViz.html)
3) ClusterR (https://cran.r-project.org/web/packages/ClusterR/index.html)
4) FlowSOM (https://bioconductor.org/packages/release/bioc/html/FlowSOM.html)


For automated build and install, including dependent packages listed above, please install the devtools library
```
install.packages("devtools")
```

so you can initiate the automated install of DAFi package

```
devtools::install_github("JCVenterInstitute/DAFi-gating", build_vignettes = TRUE)
```

then checkout the built-in vignette for the DAFi library for more documentation

```
library(DAFi)
browseVignettes(DAFi)
```

### C (see details under src)
icc or gcc compilers required for compiling binary from source.

For optimal performance please compile with intel optimization flags: 
```
icc -O3 -xHost -o dafi_gating DAFi-gating_omp.c -lm
```

In addition, precompiled binaries without enhanced optimizations is available under [releases](https://github.com/JCVenterInstitute/DAFi-gating/releases)

### DAFi R docker image
If you have docker containerization system enabled, you can download the pre-configured Dockerbuild and build the R-DAFi dockerized container that will allow you to run a local R-studio server with all necessary packages.

Move the Dockerbuild file to a directory, then run with:

```
docker build -t "r_dafi:r_dafi"
```

after the image is built, instantiate it with (change password to your own):

```
docker run -d -p 8787:8787 -e PASSWORD=dafi -e ROOT=TRUE r_dafi:r_dafi
``` 

then open the Rstudio on localhost via a webbrowser:

http://localhost:8787

and log in using user name rstudio and password dafi
