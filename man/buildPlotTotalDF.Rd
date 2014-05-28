\name{buildPlotTotalDF}
\alias{buildPlotTotalDF}
\title{Build all labels in the graph}
\usage{
buildPlotTotalDF(p, sTDF)
}
\arguments{
  \item{p}{path}

  \item{sTDF}{spreadTotalDF object (from the
  buildSpreadTotalDF function)}
}
\description{
This function takes the spreadTotalDF object (from the buildSpreadTotalDF function) and the path object
as inputs. From these objects, it creates a data frame object of the text label positions for the
varieties in the path, as well as the edges only in the varieties in the path.
}

