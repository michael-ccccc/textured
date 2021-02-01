# txx_text_to_xml

test_that("txx_text_to_xml() can handle single string",{
  
  expect_identical(
    txx_text_to_xml("Diagnosis: he has a broken leg \nMedication: A leg cast and bed rest",
                    tags = c("Diagnosis:", "Medication:")
                    ),
    "<start></start><Diagnosis> he has a broken leg \n</Diagnosis><Medication> A leg cast and bed rest</Medication>"
                    
    )
  
  
})

test_that("txx_text_to_xml() can handle multiple strings",{
  
  expect_identical(
    txx_text_to_xml(
      c("Diagnosis: he has a broken leg \nMedication: A leg cast and bed rest",
        "Diagnosis: he has diabetes \nMedication: Insulin and bed rest"),
      tags = c("Diagnosis:", "Medication:")),
      c("<start></start><Diagnosis> he has a broken leg \n</Diagnosis><Medication> A leg cast and bed rest</Medication>",
        "<start></start><Diagnosis> he has diabetes \n</Diagnosis><Medication> Insulin and bed rest</Medication>"
        )
    )
  
  
})
