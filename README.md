
# Textured
<!-- badges: start -->
[![R-CMD-check](https://github.com/michael-ccccc/textured/workflows/R-CMD-check/badge.svg)](https://github.com/michael-ccccc/textured/actions)
<!-- badges: end -->


This package assists in the structuring of semi-structured data in text
format (where data is arranged in a “subject:data” format) into an XML
document (<subject>data</subject>), where data exploration and
extraction is much easier and standarised (such as the R packages `XML`
and `xml2`).

## Installation

While it is planned to be put onto CRAN, you can currently install the
development version here:

``` r
devtools::install_github("michaelccccc/textured")
```

## General process

This package is aimed at the mass processing of text documents (letters,
forms, etc.) where the data is arranged in some kind of labelled
structure.

Here’s two letters:

    Ref: AA/11/BBBB
    Date Dictd: 09/01/2019
    Date Typed: 15/01/2019
    
    Dear Dr. A Andrews
    
    Mr. Bob BURNQUIST D.O.B. 10/10/1976
    
    Date/Time of Appt: 09/01/2019
    Clinic: Rheumatology
    
    Reason for attendance:
    Follow-up - rheumatoid arthritis
    
    Rheumatological Diagnoses
    Inflammatory spondyloarthritis
    
    Non-rheumatological Diagnoses
    Osteoporosis
    
    Medications
    Sulfasalazine 105gms bd
    
    Observations in Clinic
    Blood pressure 120/71 mmHg today
    
    Assessment
    I reviewed...

``` 

Ref: CC/22/GGGG
Date Dictd: 05/05/2019
Date Typed: 12/05/2019

Dear Dr. C Clarkson

Mr. D Dancer D.O.B. 10/10/1955

Date/Time of Appt: 05/05/2019
Clinic: Rheumatology

Reason for attendance:
L1 end plate fracture

Diagnosis
Fibromyalgia
Mild Asthma

Current medications
Omeprazole 20mg twice daily

Observations in Clinic
Blood pressure 120/71mmHg today

Actions for GP / Recommendations
Nil

Management Plan (including Actions for Patients)
1. Bloods checked...

Assessment
I reviewed...
```

While the two letters above are similar, they’re slightly different in
structure; both have differing sections, and similar sections have
different headers. This can make extraction difficult (especially if
considering much more letters (e.g. 8,000), as well as storage - a
tabular format is not suitable for letters with an inconsistent
structure.

However, XML, a semi-structure data structure, is much more suitable,
and this is what this package revolves around: the splitting and
conversion of documents into an XML format. Once converted, the data can
then be read in XML software to be analysed, where there are tools which
are much more suitable.

``` r
library(tidyverse)
library(textured)
```

``` r
sample_1 <- read_csv("data/sample_letters.csv")

sample_1
```

    ## # A tibble: 2 x 2
    ##   patient_id letter_text                                                        
    ##        <dbl> <chr>                                                              
    ## 1          1 "Ref: AA/11/BBBB\r\nDate Dictd: 09/01/2019\r\nDate Typed: 15/01/20~
    ## 2          2 "Ref: CC/22/GGGG\r\nDate Dictd: 05/05/2019\r\nDate Typed: 12/05/20~

``` r
headings <- c("Ref:", "Date Dictd:", "Date Typed", "\nDear", "D\\.O\\.B\\.",
              "Date/Time of Appt:", "Clinic:", "Reason for attendance:",
              "Diagnoses:", "Non-rheumatological Diagnoses", "Rheumatological Diagnoses",
              "Current medications:", "Medications:", "Observations in Clinic",
              "Assessment", "Actions for GP / Recommendations",
              "Management Plan \\(including Actions for Patients\\)")
# Note: txx_text_to_txml is sensitive to regular expressions (this is why
# there's escape characters)
```

Performing on a single letter:

``` r
a <- sample_1$letter_text[1]
b <- txx_text_to_xml(strings = a, tags = headings)
```

``` r
cat(b)
```

    ## <start></start><Ref> AA/11/BBBB
    ## </Ref><Date_Dictd> 09/01/2019
    ## </Date_Dictd><Date_Typed>: 15/01/2019
    ## </Date_Typed><Dear> Dr. A Andrews
    ## 
    ## Mr. Bob BURNQUIST </Dear><Dob> 10/10/1976
    ## 
    ## </Dob><DateTime_Of_Appt> 09/01/2019
    ## </DateTime_Of_Appt><Clinic> Rheumatology
    ## 
    ## </Clinic><Reason_For_Attendance>
    ## Follow-up - rheumatoid arthritis
    ## 
    ## </Reason_For_Attendance><Rheumatological_Diagnoses>
    ## Inflammatory spondyloarthritis
    ## 
    ## </Rheumatological_Diagnoses><NonRheumatological_Diagnoses>
    ## Osteoporosis
    ## 
    ## Medications
    ## Sulfasalazine 105gms bd
    ## 
    ## </NonRheumatological_Diagnoses><Observations_In_Clinic>
    ## Blood pressure 120/71 mmHg today
    ## 
    ## </Observations_In_Clinic><Assessment>
    ## I reviewed...</Assessment>

Performing from a dataframe (or tibble):

``` r
sample_2 <- sample_1 %>%
  mutate(letter_text_xml = txx_text_to_xml(letter_text, tags = headings))

sample_2
```

    ## # A tibble: 2 x 3
    ##   patient_id letter_text                      letter_text_xml                   
    ##        <dbl> <chr>                            <chr>                             
    ## 1          1 "Ref: AA/11/BBBB\r\nDate Dictd:~ "<start></start><Ref> AA/11/BBBB\~
    ## 2          2 "Ref: CC/22/GGGG\r\nDate Dictd:~ "<start></start><Ref> CC/22/GGGG\~

You can add additional XML elements with `txx_create_element()`.

``` r
sample_3 <- sample_2 %>%
  mutate(letter_text_xml = paste0(
    txx_create_element(patient_id, "patient"),
    letter_text_xml
  )) %>%
  mutate(letter_xml = txx_create_element(letter_text_xml, "letter"))
```

Then collate the XML elements into a single XML document.

``` r
letters_xml <- txx_create_element(paste0(sample_3$letter_xml, collapse = ""), "root")
```

You can then process this as an XML document. For example:

``` r
library(XML)
```

``` r
letters_xml <- xmlParse(letters_xml)

letters_df <- xmlToDataFrame(letters_xml, stringsAsFactors = FALSE)

as_tibble(letters_df)
```

    ## # A tibble: 2 x 16
    ##   patient start Ref   Date_Dictd Date_Typed Dear  Dob   DateTime_Of_Appt Clinic
    ##   <chr>   <chr> <chr> <chr>      <chr>      <chr> <chr> <chr>            <chr> 
    ## 1 1       ""    " AA~ " 09/01/2~ ": 15/01/~ " Dr~ " 10~ " 09/01/2019\n"  " Rhe~
    ## 2 2       ""    " CC~ " 05/05/2~ ": 12/05/~ " Dr~ " 10~ " 05/05/2019\n"  " Rhe~
    ## # ... with 7 more variables: Reason_For_Attendance <chr>,
    ## #   Rheumatological_Diagnoses <chr>, NonRheumatological_Diagnoses <chr>,
    ## #   Observations_In_Clinic <chr>, Assessment <chr>,
    ## #   Actions_For_Gp__Recommendations <chr>,
    ## #   Management_Plan_Including_Actions_For_Patients <chr>

``` r
longer <- letters_df %>%
  pivot_longer(cols = -patient, names_to = "section", values_to = "text")

longer
```

    ## # A tibble: 30 x 3
    ##    patient section                   text                                    
    ##    <chr>   <chr>                     <chr>                                   
    ##  1 1       start                     ""                                      
    ##  2 1       Ref                       " AA/11/BBBB\n"                         
    ##  3 1       Date_Dictd                " 09/01/2019\n"                         
    ##  4 1       Date_Typed                ": 15/01/2019\n\n"                      
    ##  5 1       Dear                      " Dr. A Andrews\n\nMr. Bob BURNQUIST "  
    ##  6 1       Dob                       " 10/10/1976\n\n"                       
    ##  7 1       DateTime_Of_Appt          " 09/01/2019\n"                         
    ##  8 1       Clinic                    " Rheumatology\n\n"                     
    ##  9 1       Reason_For_Attendance     "\nFollow-up - rheumatoid arthritis\n\n"
    ## 10 1       Rheumatological_Diagnoses "\nInflammatory spondyloarthritis\n\n"  
    ## # ... with 20 more rows
