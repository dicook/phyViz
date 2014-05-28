\name{buildMinusPathDF}
\alias{buildMinusPathDF}
\title{Process the tree graph}
\usage{
buildMinusPathDF(sTDF, p)
}
\arguments{
  \item{sTDF}{spreadTotalDF object (from the
  buildSpreadTotalDF function)}

  \item{p}{path}
}
\description{
This function takes the spreadTotalDF object (from the buildSpreadTotalDF function) and the path object
as inputs. From these objects, it creates a data frame object of the label, x, and y values of all nodes
in the tree. However, the data frame object does not include the labels of the path varieties, as they
will be treated differently.
}

