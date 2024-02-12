library(jsonlite)
library(ggplot2)


source("Person.R")

data <- read.csv('results-survey_without.csv')
View(data)
print(colnames(data))

# Create a list to store Person objects
person_list <- list()

# Iterate over each dataset and each row
# This basically prepares the data 
for (i in 1:nrow(data)) {

    newPerson <- Person$new()
  
    person <- data[i, ]
    
    # if(person$submitdate..Date.submitted == '')
    # {
    #   next
    # }
    
    #print (response_id)
    for (x in colnames(person)) {
      
      if(grepl("Question.time", x, ignore.case = TRUE))
      {
        next
      }
      
      if (grepl(paste0( c("ORG", "GRN", "BLU", "PNK", "PRP"), collapse = "|"), x, ignore.case = TRUE) ) 
      {
        value <- person[x]
        
        COLOR <- substr(x, start = 1, stop = 3)
        PRODUCT <- substr(x, start = 4, stop = 5)
        CONTINENT <- substr(x, start = 6, stop = 8)
        
        if (CONTINENT %in% c("ASI", "AFR", "EUR") &&
            PRODUCT %in% c("01", "02", "03") &&
            COLOR %in% c("ORG", "GRN", "BLU", "PNK", "PRP")) {
          
          concat_prod <- paste("PRODUCT:", PRODUCT)
          
          if(!is.na(value))
          {
            newPerson$add_to_matrix(CONTINENT, concat_prod, COLOR, value)
          }
        }
      } 
      
      if (grepl("DEM02AGE", x, ignore.case = TRUE) ) 
      {
        Value <- person[x]
        newPerson$add_age(Value[[1]])
      } 

      if (grepl("DEM04SEX..What.gender.do.you.identify.as.", x, ignore.case = TRUE) ) 
      {
        Value <- person[x]
        newPerson$add_sex(Value[[1]])
      } 
    }
    
    person_list <- append(person_list, list(newPerson))
}

colored_combined_data <- list() 

# here we want to create a new data structure which is easier to parse
for (person in person_list) {
  colored_combined_data[[length(colored_combined_data) + 1]] <- person$get_color_mean_data_frame()
}

# Convert R data to JSON
json_content <- toJSON(colored_combined_data, pretty = TRUE, auto_unbox = TRUE)

# Specify the file path where you want to save the JSON file
json_file_path <- "colored_data.json"

# Write JSON content to a file
writeLines(json_content, json_file_path)

product_combined_data <- list() 

# here we want to create a new data structure which is easier to parse
for (person in person_list) {
  product_combined_data[[length(product_combined_data) + 1]] <- person$get_product_mean_data_frame()
}

# Convert R data to JSON
json_content <- toJSON(product_combined_data, pretty = TRUE, auto_unbox = TRUE)

# Specify the file path where you want to save the JSON file
json_file_path <- "product_data.json"

# Write JSON content to a file
writeLines(json_content, json_file_path)

