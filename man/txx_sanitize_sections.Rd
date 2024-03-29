% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/txx_sanitize_sections.R
\name{txx_sanitize_sections}
\alias{txx_sanitize_sections}
\title{Sanitizes the text as part of the txx_text_to_xml process}
\usage{
txx_sanitize_sections(string, split = "¬")
}
\arguments{
\item{string}{The full text string}

\item{split}{The character indicating a section}
}
\value{
The text string, with each part being sansitized with the appropriate
function
}
\description{
Splits the text into sections and applies the appropriate sanitize text 
functions to each part, then joins it up again.
}
