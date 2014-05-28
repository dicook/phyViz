\name{getDegree}
\alias{getDegree}
\title{Determine the degree between two varieties}
\usage{
getDegree(v1, v2, mygraph)
}
\arguments{
  \item{v1}{the first variety}

  \item{v2}{the second variety}

  \item{mygraph}{mygraph}
}
\description{
Returns the degree (distance between unweighted edges) between two varieties, where an edge
represents a parent-child relationship
}
\examples{
getDegree("Brim","Bedford",mygraph)
}

