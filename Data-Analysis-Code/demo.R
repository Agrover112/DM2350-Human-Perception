library(jsonlite)
library(ggplot2)
library(tidyr)

json_file_path <- "colored_data.json"

# Read JSON data from the file
json_data <- fromJSON(json_file_path)

json_data_frame <- as.data.frame(json_data$demographics)

df <- data.frame(json_data_frame$age)

df_transposed <- data.frame(t(json_data_frame$age))

labels <- c("Mumbai", "Pune", "Chennai", "Bangalore")

pie(df_transposed, labels, main = "City pie chart")