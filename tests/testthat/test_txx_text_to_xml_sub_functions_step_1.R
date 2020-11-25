# txx_sanitize_tag_name

test_that("txx_sanitize_tag_name() trims spaces, then replaces them with '_'",{
  
  expect_identical(txx_sanitize_tag_name(" A B C D E     "), 
              "A_B_C_D_E")
  
})

test_that("txx_sanitize_tag_name() title-cases any text",{
  
  expect_identical(txx_sanitize_tag_name("ABCDE fghij"), 
              "Abcde_Fghij")
  
})

test_that("txx_sanitize_tag_name() keeps only alphanumeric and '_' characters",{

  expect_identical(txx_sanitize_tag_name("A_B%C*D"),
              "A_bCD")
  
})

test_that("txx_sanitize_tag_name() - if name starts with number, prefix with '_'", {
  
  expect_identical(txx_sanitize_tag_name("1 abcde"),
              "_1_Abcde")
  
})


# txx_wrap_tag

test_that("txx_wrap_tag() by default wraps tags in '¬<' and '>'", {
  
  expect_identical(txx_wrap_tag("A"),
                   "\u00AC<A>")
  
})

test_that("txx_wrap_tag() invokes txx_sanitize_tag_name()", {
  
  expect_identical(txx_wrap_tag("A B & C   "),
                   "\u00AC<A_B__C>")
  
})

test_that("txx_wrap_tag() can handle custom split, start and end", {
  
  expect_identical(txx_wrap_tag("A", split_character = "*", start = "[", end = "]"),
                   "*[A]")
  
  
})

# txx_identify_sections

test_that("txx_identify_sections() can identify one tag",{
  
  expect_identical(
    txx_identify_sections(string = "TITLE: Henry goes shopping \nAUTHOR: Jane Doe", 
                          tags = "TITLE:"),
    "\u00AC<Title> Henry goes shopping \nAUTHOR: Jane Doe")
  
})

test_that("txx_identify_sections() can identify several tags", {
  
  expect_identical(
    txx_identify_sections(string = "TITLE: Henry goes shopping \nAUTHOR: Jane Doe", 
                          tags = c("TITLE:", "AUTHOR:")),
    "\u00AC<Title> Henry goes shopping \n\u00AC<Author> Jane Doe")
  
  
})

test_that("txx_identify_sections() ignores case by default", {
  
  expect_identical(
    txx_identify_sections(string = "TITLE: Henry goes shopping \nAUTHOR: Jane Doe", 
                          tags = c("Title:", "Author:")),
    "\u00AC<Title> Henry goes shopping \n\u00AC<Author> Jane Doe")
  
})

test_that("txx_identify_sections() ignore.case = FALSE works", {
  
  expect_identical(
    txx_identify_sections(string = "TITLE: Henry goes shopping \nAUTHOR: Jane Doe", 
                          tags = c("TITLE:", "Author:"),
                          ignore_case = FALSE),
    "\u00AC<Title> Henry goes shopping \nAUTHOR: Jane Doe")
  
  
})
