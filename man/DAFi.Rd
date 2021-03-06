% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DAFi_Main.R
\name{DAFi}
\alias{DAFi}
\title{Run the DAFi algorithm}
\usage{
DAFi(rawfcs_path, config_path, reverse_path = NULL, clusterSize = 100,
  xdims = 10, ydims = 10, excludeGated = FALSE, method = "Kmeans",
  initializer = "kmeans++", plotCentroids = TRUE, writeOutput = TRUE,
  smoothPlot = FALSE, debugmode = FALSE)
}
\arguments{
\item{rawfcs_path}{path to raw fcs file}

\item{config_path}{path to DAFi cell gating hierarchy configuration file (inclusion gates)}

\item{reverse_path}{path to DAFi cell gating hierarchy configuration file (exclusion gates)}

\item{clusterSize}{specify number of clusters for Kmeans type algorithms (default 100)}

\item{xdims}{number of SOM nodes in x direction for FlowSOM algorithm (default 10)}

\item{ydims}{number of SOM nodes in y direction for FlowSOM algorithm (default 10)}

\item{excludeGated}{*experimental* set TRUE to exclude previously gated channels in reclustering (default FALSE)}

\item{method}{set clustering algorithm from the following choices: 'Kmeans' (default), 'fSOM'}

\item{initializer}{set initializer for Kmeans methods from the following choices: 'optimal_init', 'quantile_init', 'kmeans++' (default), and 'random'; see \href{https://cran.r-project.org/web/packages/ClusterR/ClusterR.pdf}{ClusterR}}

\item{plotCentroids}{whether or not to plot diagnostic plots to see centroid locations}

\item{writeOutput}{whether or not to generate output events and percentage tables}
}
\description{
Method to run general DAFi workflow.
Will transform the data via FCSTrans and scale each channel to the range 0-4096 by default.
}
\examples{

# Read in file and create flowFrame
SampleData <- system.file("extdata", "sample.fcs",package="DAFi")
SampleflowFrame <- suppressWarnings(flowCore::read.FCS(SampleData))
inclusionConfig <- system.file("extdata", "inclusion.config",package="DAFi")
exclusionConfig <- system.file("extdata", "exclusion.config",package="DAFi")

# Minimal parameter run (all defaults)
DAFi(SampleData,inclusionConfig)

# Or specify method and options for FlowSOM clustering
DAFi(SampleData,inclusionConfig,exclusionConfig, xdims=5, ydims=5, method='fSOM')

# Or specify method and options for Kmeans++ clustering
DAFi(SampleData,inclusionConfig",exclusionConfig", clusterSize=25, method='Kmeans', initializer='kmeans++')


}
\seealso{
\code{\link{cluster_run}},\code{\link{scatterTransform}},\code{\link{timeTransform}}
}
