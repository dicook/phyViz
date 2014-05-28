\name{generatePathPlot}
\alias{generatePathPlot}
\title{Construct the graphic object of the path}
\usage{
generatePathPlot(pPDF)
}
\arguments{
  \item{pPDF}{plotPathDF object created from function
  buildPathDF}
}
\description{
This function takes the path data frame as input, and outputs an ggplot2 object. The
image will correctly position the node labels with x-axis representing the node
year, and y-axis representing the node path index. Edges between two nodes represent
parent-child relationships between those nodes. For visual appeal, there is a grey
box that outlines the node label, as well as an underline and overline for each label.
}

