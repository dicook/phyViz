\name{buildSpreadTotalDF}
\alias{buildSpreadTotalDF}
\title{Build a data frame where the varieties are spread so they do not overlap}
\usage{
buildSpreadTotalDF(t, numBin, binVector)
}
\arguments{
  \item{t}{tree}

  \item{numBin}{number of bins to equally separate the
  vertices into groups of years}

  \item{binVector}{vector of length numBin that includes
  any combination of each integer exactly once between
  unity and numBin. This vector will determine the order
  that increasing y index positions are repeatedly assigned
  to. For instance, if the numBin = 12, and binVector =
  c(1,4,7,10,2,5,8,11,3,6,9,12), then y-axis position one
  will be assigned to a variety in the first bin of years,
  y-axis position two will be assigned to a variety in the
  fourth bin of years, ...., and y-axis position thirteen
  will be assigned again to a variety in the first bin of
  years. This vector can help minimize overlap of the
  labelling of varieties, without regard to how the layout
  affects the edges between varieties, as those edges will
  be colored faintly.}
}
\description{
Constructs a data frame object so that varieties are spread such that they do not overlap, even
though the x-axis position will represent years.
}

