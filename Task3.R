library(sna)
library(network)


#Task 3 - Problem 1
attr_data <- read.csv('/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv/cleaned_attr_lit_end.csv', sep=";", header=TRUE)
network_w2 <- read.csv('/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv/cleaned_10_W2.csv', sep=";", header=TRUE, row.names=1)

classroom_10_attr <- attr_data[attr_data$classroomID == 10, ]
network_matrix <- as.matrix(network_w2)

student_ids_in_network <- as.numeric(rownames(network_matrix))
literacy_scores <- as.numeric(classroom_10_attr$literacy_end[match(student_ids_in_network, classroom_10_attr$studentID)])

valid_indices <- !is.na(literacy_scores)
network_matrix_clean <- network_matrix[valid_indices, valid_indices]
literacy_scores_clean <- literacy_scores[valid_indices]

nam_model <- lnam(y = literacy_scores_clean, W1 = network_matrix_clean)

summary(nam_model)


#Task 3 - Problem 2
attr_full <- read.csv('/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv/cleaned_attr.csv', sep=",", header=TRUE)
network_w2 <- read.csv('/Users/duartealbuquerque/Desktop/ETH-Switzerland/ETH_Classes/S26/Network Modeling/Projects/Assignment1/cleaned_csv/cleaned_10_W2.csv', sep=";", header=TRUE, row.names=1)
#specific for classroom '10'
classroom_10_attr <- attr_full[attr_full$classroomID == 10, ]
network_matrix <- as.matrix(network_w2)
student_ids_in_network <- rownames(network_matrix)
attr_matched <- classroom_10_attr[match(student_ids_in_network, as.character(classroom_10_attr$studentID)), ]
valid_indices <- complete.cases(attr_matched)
network_matrix_clean <- network_matrix[valid_indices, valid_indices]
attr_final <- attr_matched[valid_indices, ]
y <- as.numeric(attr_final$literacy_end)
x_vars <- cbind(
  gender = as.numeric(as.factor(attr_final$gender)),
  hisei = as.numeric(attr_final$HISEI)
)
nam_model_covariates <- lnam(y = y, x = x_vars, W1 = network_matrix_clean)
summary(nam_model_covariates)


#Task 3 - Problem 3
#The model estimates a rho of -0.04422 with a p-value of 0.0556, which is not statistically significant at the .05 alpha level. 
#Since the p-value is greater than .05, we fail to reject the null hypothesis (which states there is no autocorrelation), meaning the data does not provide strong evidence for the autocorrelation hypothesis in this classroom. 
#Likewise, the gender variable's estimated coefficient is -4.41729. This suggests that moving from female to male is associated with a 4.4-point decrease in literacy score; 
#however, this coefficient is not statistically significant (p-value = 0.4536). 
#In contrast, the HISEI coefficient is highly statistically significant (p-value = 1.38e-12). This indicates that as socio-economic status increases by 1 unit, the literacy score increases by 1.4 units, holding all other variables constant.
