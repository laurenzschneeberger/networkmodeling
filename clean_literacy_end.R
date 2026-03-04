input_file_attr <- "/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/Lintner/attr.csv"
output_folder <- "/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv"

attr_data <- read.csv2(input_file_attr, 
                       header = TRUE, 
                       check.names = FALSE, 
                       na.strings = c("", " ", "NA"))

attr_clean_lit_end <- attr_data[!is.na(attr_data$literacy_end), ]

output_path_attr <- file.path(output_folder, "cleaned_attr_lit_end.csv")
write.csv2(attr_clean_lit_end, file = output_path_attr, row.names = FALSE)