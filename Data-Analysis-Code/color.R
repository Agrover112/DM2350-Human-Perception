library(jsonlite)
library(ggplot2)
library(tidyr)

json_file_path <- "colored_data.json"

# Read JSON data from the file
json_data <- fromJSON(json_file_path)

# Print the parsed JSON data
print(json_data)

json_data_frame <- as.data.frame(json_data$colors)

df <- data.frame(json_data_frame)

df_transposed <- data.frame(t(json_data_frame))

column_names <- colnames(df_transposed)

for (col_name in column_names) {
  print(paste("Column Name:", col_name))
  
  column_values <- df_transposed[, col_name]
  
  median <- median(column_values, na.rm = TRUE)
  quantiles <-summary(column_values) # na.rm = TRUE)
  
  cat("Color: ", col_name, "median: ", median, "\n")
  cat("Color: ", col_name, "quantiles: Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n")
  cat("Color: ", col_name, "quantiles:", quantiles, "\n")
}

boxplot(df_transposed, data = mtcars, main = "Global Average Color Values", xlab = "COLORS", ylab = "Eco-Friendliness Value")

# whilcoxon rank sum test 
# female / male comparison

# kruskal whallis test kruskal.test()kruskal.test()
# colors, products, continents
krusk <- kruskal.test(df_transposed)

print(krusk)