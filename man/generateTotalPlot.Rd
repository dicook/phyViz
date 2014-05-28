\name{generateTotalPlot}
\alias{generateTotalPlot}
\title{Build the image object of the whole tree with the path superimposed onto it}
\usage{
generateTotalPlot(pMPDF, eTDF, pTDF)
}
\arguments{
  \item{pMPDF}{plotMinusPathDF (built from the
  buildMinusPathDF function)}

  \item{eTDF}{edgeTotalDF (built from the buildEdgeTotalDF
  function)}

  \item{pTDF}{plotTotalDF (built from the buildPlotTotalDF
  function)}

  \item{pPDF}{plotPathDF (built from the buildPathDF
  function)}
}
\description{
This function takes four data frames as inputs, and outputs an ggplot2 object. The
image will correctly position the node labels with x-axis representing the node
year, and y-axis representing the node path index. Light grey edges between two nodes
represent parent-child relationships between those nodes. To enhance the visual
understanding of how the path-of-interest fits into the entire graph structure, the
nodes within the path are labelled in boldface, and connected with light-green
boldfaced edges.
}

