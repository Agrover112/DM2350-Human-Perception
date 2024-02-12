library(MASS)
library(jsonlite)
library(tidyr)
#install.packages("reshape2")
#install.packages("effects")
library(reshape2)
library(ggplot2)


df_transposed$Product_type <- gsub(".*\\.PRODUCT\\..(\\d+)(\\.\\d+)?", "\\1", rownames(df_transposed))

# Melt the data frame
melted_df <- melt(df_transposed, variable.name = "Color", value.name = "Outcome")
print(melted_df)

color_numeric <- as.integer(factor(melted_df$Color, levels = unique(melted_df$Color)))

melted_df$Color_numeric <- color_numeric
melted_df$Outcome <- as.factor(melted_df$Outcome)
melted_df$Product_type <- as.integer(melted_df$Product_type)

model <- polr(Outcome ~ Color_numeric + Product_type, data = melted_df,method="logistic")

# Print the summary to see the results
print(summary(model))



#Single Outcome Probabilities (Column-0,Column-1...COlumn-n) remember:Sigma(p_0+p_n)=1
library(ggplot2)

melted_df$Fitted <- predict(model, melted_df, type = "probs")[,1]  # Extract the first column (1|2)


ggplot(melted_df, aes(x = Color_numeric, y = Fitted, color = factor(Product_type))) +
  geom_point() +
  geom_line() +
  labs(title = "Ordinal Logistic Regression: Fitted Probabilities",
       x = "Color_numeric",
       y = "Fitted Probabilities",
       color = "Product_type") +
  theme_minimal()



# Effects not yet sure
#library(effects)
#plot(Effect(focal.predictors = c("Color_numeric","Product_type"),model))


######################################################################

















## Trying something
# Predict the probabilities for each level of Outcome
melted_df$Fitted <- predict(model, melted_df, type = "probs")[,1]  # Extract the first column (1|2)

# Create a ggplot facet grid
ggplot(melted_df, aes(x = Color_numeric, y = Fitted, color = factor(Product_type))) +
  geom_point() +
  geom_line() +
  labs(title = "Ordinal Logistic Regression: Fitted Probabilities",
       x = "Color_numeric",
       y = "Fitted Probabilities",
       color = "Product_type") +
  theme_minimal() +
  facet_grid(. ~ Outcome)










