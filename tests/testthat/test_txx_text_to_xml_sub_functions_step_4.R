# txx_finish_tag

test_that("txx_finish_tag() creates a end tag from the start tag, and attaches it to the end",{
  
  expect_identical(txx_finish_tag("<tag>text"),
                   "<tag>text</tag>")
  
  
})

#txx_finish_sections
test_that("txx_finish_sections() can properly attach end tags",{
  
  expect_identical(
    txx_finish_sections("<header_a>Some text\u00AC<header_b>More text\u00AC<header_c>Last text"),
    "<header_a>Some text</header_a><header_b>More text</header_b><header_c>Last text</header_c>")
  
  expect_identical(
    txx_finish_sections(
      c("<header_a>Some text\u00AC<header_b>More text\u00AC<header_c>Last text",
        "<header_a>Second time \u00AC<header_b>More text\u00AC<header_c>this time is last")),
    c("<header_a>Some text</header_a><header_b>More text</header_b><header_c>Last text</header_c>",
      "<header_a>Second time </header_a><header_b>More text</header_b><header_c>this time is last</header_c>")
    )
  
  
})
