% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/txx_rename_dup_tags.R
\name{txx_rename_dup_tags}
\alias{txx_rename_dup_tags}
\title{Identify and rename duplicate tags by suffixing a number at the end}
\usage{
txx_rename_dup_tags(string)
}
\arguments{
\item{string}{A character string containing text from the txx_sanitize_sections,
containing text that has start tags and text (no end tags).}
}
\value{
The character string entered, but now any tags with duplicate names
have a number suffixed.
}
\description{
The text needs to be in a state where the tags have been identified, but
the tags have not been finished. Identifies the start tags, and then looks
though for duplicates. Any duplicate tag is adjusted, putting a number at the
end. (See \code{\link{txx_number_seen}}). 
Used as part of the \code{\link{txx_text_to_xml}} process.
}
