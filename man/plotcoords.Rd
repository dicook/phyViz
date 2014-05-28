\name{plotcoords}
\alias{plotcoords}
\title{Returns the coordinate positions of all ancestors and descendants of a variety}
\usage{
plotcoords(df)
}
\arguments{
  \item{df}{data frame of the ancestors and descendants of
  a variety (from function buildGenDF)}
}
\description{
Calculates coordinates to plot each ancestors and descendant of a variety on a tree.
The x and y values describe the coordinates of the label, while the xstart, ystart, xend,
and yend values describe the edges of the label.
}

