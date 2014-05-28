\name{getPath}
\alias{getPath}
\title{Determine the degree between two varieties}
\usage{
getPath(v1, v2, isDirected, mygraph)
}
\arguments{
  \item{v1}{the first variety}

  \item{v2}{the second variety}

  \item{isDirected}{boolean whether or not the graph is
  directed}

  \item{mygraph}{mygraph}
}
\description{
Determines the shortest path between the two inputted vertices, and takes into
account whether or not the graph is directed. If there is a path, the list of vertices of the
path will be returned. If there is not a path, a list of character(0) will be returned. Note:
For a directed graph, the direction matters. However, this function will check both directions
and return the path if it exists.
}
\examples{
getPath("Brim","Bedford",mygraph)
getPath("Tokyo","Volstate",mygraph)
}

