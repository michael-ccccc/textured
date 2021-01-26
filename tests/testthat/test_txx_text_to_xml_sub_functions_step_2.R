# txx_sanitize_text()

test_that("txx_sanitize_text() does nothing to alright text", {
  
  expect_identical(txx_sanitize_text("I am going to the supermarket."),
                   "I am going to the supermarket.")
  
})

test_that("txx_sanitize_text() replaces xml-important characters appropriately", {
  
  expect_identical(txx_sanitize_text("I'm >5'10', but <10 stone & \"happy\""),
                   "I&apos;m &gt;5&apos;10&apos;, but &lt;10 stone &amp; &quot;happy&quot;")
  
})

# txx_sanitize_tag_sections()

test_that("txx_sanitize_tag_sections() replaces the text as required", {
  
  expect_identical(txx_sanitize_tag_sections(
    "<Diagnosis>Has diabetes and >5' nail in his foot"),
    "<Diagnosis>Has diabetes and &gt;5&apos; nail in his foot")
  
  expect_identical(txx_sanitize_tag_sections(
    "<Diagnosis>Has diabetes \n and >5' nail in his foot"),
    "<Diagnosis>Has diabetes \n and &gt;5&apos; nail in his foot")
})

# txx_sanitize_sections()

test_that("txx_sanitize_sections() sanitizes all sections", {
  
  expect_identical(
    txx_sanitize_sections("<Diagnosis>Diabetes, >5' nail in foot, \u00AC<Medicaton>Insulin & a hammer"),
    "<Diagnosis>Diabetes, &gt;5&apos; nail in foot, \u00AC<Medicaton>Insulin &amp; a hammer")
  
  
})

test_that("txx_sanitize_sections() can handle custom split characters", {
  
  expect_identical(
    txx_sanitize_sections("<Diagnosis>Diabetes, >5' nail in foot, \u00BB<Medicaton>Insulin & a hammer",
                          split = "\u00BB"),
    "<Diagnosis>Diabetes, &gt;5&apos; nail in foot, \u00BB<Medicaton>Insulin &amp; a hammer")
  
})


