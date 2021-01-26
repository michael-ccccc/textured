# txx_number_seen
test_that("txx_number_seen() works as typical", {
  
  expect_identical(txx_number_seen(c("a", "b", "c", "d", "a", "a", "a", "e", "b")),
                   c(1, 1, 1, 1, 2, 3, 4, 1, 2))
  
})

# txx_rename_dup_tags

test_that("txx_rename_dup_tags() operates as typical", {
  
  expect_identical(
    txx_rename_dup_tags("<header_a>This is some text<header_b>More text<header_c>text<header_b><header_a>"),
    "<header_a>This is some text<header_b>More text<header_c>text<header_b2><header_a2>")
  
})
