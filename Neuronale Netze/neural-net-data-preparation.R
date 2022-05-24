
###################################################
### Preparation of the Environment ####

# Clear environment
remove(list = ls())

# Create list with needed libraries
pkgs <- c("readr", "fastDummies", "reticulate", "ggplot2", "Metrics")

# Load each listed library and check if it is installed and install if necessary
for (pkg in pkgs) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}


###################################################
### Data Import ####

# Reading the data file
house_pricing <- read_csv("https://raw.githubusercontent.com/opencampus-sh/einfuehrung-in-data-science-und-ml/main/house_pricing_data/house_pricing_train.csv")
names(house_pricing)

###################################################
### Data Preparation ####

# Recoding of the variables into one-hot encoded (dummy) variables
dummy_list <- c("view", "condition")
house_pricing_dummy = dummy_cols(house_pricing, dummy_list)
names(house_pricing_dummy)

# Definition of lists for each one-hot encoded variable (just to make the handling easier)
condition_dummies = c('condition_1', 'condition_2', 'condition_3', 'condition_4', 'condition_5')
view_dummies = c('view_0', 'view_1', 'view_2', 'view_3','view_4')


###################################################
### Selection of the Feature Variables and the Label Variable ####

# Selection of the features (the independent variables used to predict the dependent)
#features <- c('sqft_lot', 'waterfront', 'grade', 'bathrooms', view_dummies, condition_dummies)
features <- c('sqft_lot', 'waterfront', 'grade', 'bathrooms', condition_dummies, view_dummies)
# Selection of the label (the dependent variable)
labels <- 'price'


###################################################
### Selection of Training, Validation and Test Data ####

# Look at the data
str(house_pricing_dummy)

# Setting the random counter to a fixed value, so the random initialization stays the same (the random split is always the same)
set.seed(1)

# Shuffling the dataset (to get a random order)
new_row_order <- sample(nrow(house_pricing_dummy))
house_pricing_dummy <- house_pricing_dummy[new_row_order, ]

# Assign each row number in the full dataset randomly to one of the three groups of datasets
# The probability of being in one of the groups results then in corresponding group sizes
assignment <- sample(1:3, size = nrow(house_pricing_dummy), prob = c(.7, .2, .1), replace = TRUE)

# Create training, validation and test data for the features and the labels
training_features <- house_pricing_dummy[assignment == 1, features]    # subset house_pricing to training indices only
training_labels <- house_pricing_dummy[assignment == 1, labels]    # subset house_pricing to training indices only

validation_features <- house_pricing_dummy[assignment == 2, features]  # subset house_pricing to validation indices only
validation_labels <- house_pricing_dummy[assignment == 2, labels]  # subset house_pricing to validation indices only

test_features <- house_pricing_dummy[assignment == 3, features]   # subset house_pricing to test indices only
test_labels <- house_pricing_dummy[assignment == 3, labels]   # subset house_pricing to test indices only

