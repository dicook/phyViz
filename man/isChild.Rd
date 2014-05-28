\name{isChild}
\alias{isChild}
\title{Determine if a variety is a child of another}
\usage{
isChild(child, parent, tree)
}
\arguments{
  \item{child}{possible child variety}

  \item{parent}{possible parent variety}

  \item{tree}{tree}
}
\description{
Returns a boolean variable for whether the first variety is a child of the second variety
}
\examples{
isChild("Essex","Young",tree)
isChild("Young","Essex",tree)
}

