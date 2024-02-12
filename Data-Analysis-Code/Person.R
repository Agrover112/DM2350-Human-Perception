# PersonClass.R

library(R6)
library(tidyr)

Person <- R6Class(
  "Person",
  
  public = list(
    initialize = function() {
      # Initialize matrices for each continent
      private$asi_matrix <- matrix(NA, nrow = 5, ncol = 3, dimnames = list(c("ORG", "GRN", "BLU", "PNK", "PRP"), c("PRODUCT: 01", "PRODUCT: 02", "PRODUCT: 03")))
      private$afr_matrix <- matrix(NA, nrow = 5, ncol = 3, dimnames = list(c("ORG", "GRN", "BLU", "PNK", "PRP"), c("PRODUCT: 01", "PRODUCT: 02", "PRODUCT: 03")))
      private$eur_matrix <- matrix(NA, nrow = 5, ncol = 3, dimnames = list(c("ORG", "GRN", "BLU", "PNK", "PRP"), c("PRODUCT: 01", "PRODUCT: 02", "PRODUCT: 03")))
      #"ORG", "GRN", "BLU", "PNK", "PRP"
      private$g_color_list <-list()
      #"PRODUCT: 01", "PRODUCT: 02", "PRODUCT: 03"
      private$g_product_list <-list()
      private$age <- -1L
      private$sex <- list( male = "Male", female = "Female")
    },
    
    add_to_matrix = function(continent, product, color, value) {
      
      color <- as.character(color)
      product <- as.character(product)
      continent <- as.character(continent)
      value <- as.numeric(value)
      
      switch(continent,
             "ASI" = private$asi_matrix[color, product] <- value,
             "AFR" = private$afr_matrix[color, product] <- value,
             "EUR" = private$eur_matrix[color, product] <- value)
    },
    
    add_age = function(value) {
      private$age<- value
    },
    
    add_sex = function(value) {
      private$sex<- value
    },
    
    get_matrix = function(continent) {
      
      continent <- as.character(continent)
      # Get the matrix for the specified continent
      switch(continent,
             "ASI" = private$asi_matrix,
             "AFR" = private$afr_matrix,
             "EUR" = private$eur_matrix)
    },
    
    print_info = function() {
      cat("ASI Matrix:\n")
      print(private$asi_matrix)
      cat("AFR Matrix:\n")
      print(private$afr_matrix)
      cat("EUR Matrix:\n")
      print(private$eur_matrix)
    },

    get_color_mean_data_frame = function() {
      # Reshape the matrices and return as a data frame
      data_list <- list(
        colors = data.frame(
          c_matrix = (colSums(t(private$asi_matrix)) + colSums(t(private$afr_matrix)) + colSums(t(private$eur_matrix))) / 3 / 3
        ),
        demographics = data.frame(
          age = private$age,
          sex = private$sex
        )
      )
    }, 
    
    get_product_mean_data_frame = function() {
      # Reshape the matrices and return as a data frame
      data_list <- list(
        colors = data.frame(
          c_matrix = (colSums(private$asi_matrix) + colSums(private$afr_matrix) + colSums(private$eur_matrix)) / 3 / 3
        ),
        demographics = list(
          age = private$age,
          sex = private$sex
        )
      )
    }, 
        
    get_color_data_frame = function() {
      # Reshape the matrices and return as a data frame
      data_list <- list(
        colors = data.frame(
          CASI_Matrix = private$asi_matrix,
          CAFR_Matrix = private$afr_matrix,
          CEUR_Matrix = private$eur_matrix
        ),
        demographics = list(
          age = private$age,
          sex = private$sex
        )
      )
    }, 
    
    get_product_data_frame = function() {
      data_list <- list(
        colors = data.frame(
          CASI_Matrix = t(private$asi_matrix),
          CAFR_Matrix = t(private$afr_matrix),
          CEUR_Matrix = t(private$eur_matrix)
        ),
        demographics = data.frame(
          age = private$age,
          sex = private$sex
        )
      )
    }
  ),
  
  private = list(
    asi_matrix = NULL,
    afr_matrix = NULL,
    eur_matrix = NULL,
    g_product_list = NULL,
    g_color_list = NULL,
    age = NULL,
    sex = NULL
  )
)
