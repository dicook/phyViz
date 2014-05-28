\name{buildEdgeTotalDF}
\alias{buildEdgeTotalDF}
\title{Build the edges in the  total tree graph}
\usage{
buildEdgeTotalDF(tG, sTDF)
}
\arguments{
  \item{tG}{treeGraph}

  \item{sTDF}{spreadTotalDF object (from the
  buildSpreadTotalDF function)}
}
\description{
This function takes the spreadTotalDF object (from the buildSpreadTotalDF function) and the treeGraph object
as inputs. From these objects, it creates a data frame object of the edges between all parent-child
relationships in the graph
}

