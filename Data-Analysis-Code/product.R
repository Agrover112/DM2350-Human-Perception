library(jsonlite)
library(ggplot2)

json_file_path <- "product_data.json"

# Read JSON data from the file
json_data <- fromJSON(json_file_path)

json_data_frame <- as.data.frame(json_data$colors)

df_transposed <- data.frame(t(json_data_frame))

boxplot(df_transposed, data = mtcars, main = "Global Products", xlab = "Products", ylab = "sus Val")

krusk <- kruskal.test(df_transposed)
print(krusk)