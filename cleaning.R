#Data cleaning

library(sna)
library(network)

input_folder = "/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/classrooms"
setwd(folder_path)
output_folder <- "/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv"

file_list = list.files(path = folder_path, pattern = "*.csv")

for (file_name in file_list) {
  
  file_path <- file.path(input_folder, file_name)
  obsMat <- as.matrix(read.csv2(file_path, header = TRUE, row.names = 1, check.names = FALSE))
  na_indices <- which(rowSums(is.na(obsMat)) == ncol(obsMat))
  
  if (length(na_indices) > 0) {
    obsMat_clean <- obsMat[-na_indices, -na_indices, drop = FALSE]
  } else {
    obsMat_clean <- obsMat
  }
  
  output_path <- file.path(output_folder, paste0("cleaned_", file_name))
  write.csv2(obsMat_clean, file = output_path, row.names = TRUE)
  
}

input_file_attr = "/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/Lintner/attr.csv"
attr_data <- read.csv2(input_file_attr, 
                       header = TRUE, 
                       row.names = 1, 
                       check.names = FALSE, 
                       na.strings = c("", " ", "NA"))


attr_clean <- na.omit(attr_data)


output_path_attr <- file.path(output_folder, "cleaned_attr.csv")
write.csv2(attr_clean, file = output_path_attr, row.names = TRUE)




