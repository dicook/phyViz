\name{isParent}
\alias{isParent}
\title{Determine if a variety is a parent of another}
\usage{
isParent(child, parent, tree)
}
\arguments{
  \item{child}{possible child variety}

  \item{parent}{possible parent variety}

  \item{tree}{tree}
}
\description{
Returns a boolean variable for whether the second variety is a parent of the first variety
}
\examples{
isParent("Essex","Young",tree)
isParent("Young","Essex",tree)
}

