## Logistics Regression on Churn data
## 5 independent variables
## Different Samplings - Bootstrapped, LOOCV, K-Fold validation, 5 Fold

library(tidyverse)
library(caret)

##0 - Prepare Data

churn_df <- read_csv("churn.csv")
churn_df$churn <- factor(churn_df$churn)
#class(churn_df$churn)
#head(churn_df)
#nrow(churn_df)

## 1. Split Data

train_split <- function(data, size=0.8) {
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, size*n)
  ctrain_df <- data[train_id, ]
  ctest_df <- data[-train_id, ]
  return( list(ctrain_df, ctest_df))
}

cprep_df <- train_split(churn_df, size=0.8)

## 2. Train Model

#Sampling - Bootstrapped
ctrl <- trainControl(method="boot", 
                     number = 5)

#Sampling - LOOV
#ctrl <- trainControl(method="LOOCV")

#Sampling - K-Fold validation, K =5
#ctrl <- trainControl(method="cv", 
#                     number = 5)


# Train with 3 independent variables
#chmodel_3vars <- train(churn ~ accountlength + totaldayminutes + numbercustomerservicecalls,
#               data = cprep_df[[1]],
#               method = "glm",
#               trControl = ctrl)

# Train with 5 independent variables
chmodel_5vars <- train(churn ~ accountlength + totaldayminutes + totaleveminutes + totalnightminutes + numbercustomerservicecalls,
                       data = cprep_df[[1]],
                       method = "glm",
                       trControl = ctrl)

## 3. Score Model
#pred_churn3Vars <- predict(chmodel_3vars, newdata = cprep_df[[2]])
pred_churn5Vars <- predict(chmodel_5vars, newdata = cprep_df[[2]])

## 4. Evaluate Model
actual_churn <- cprep_df[[2]]$churn
#eval_acc <- mean(pred_churn5Vars == actual_churn)


# Build Confusion Matrix
conM <- table(pred_churn5Vars,actual_churn,
      dnn=c("Predicted","Actual"))

# Calculate Accuracy from Confusion Matrix (value equal to eval_acc)
Test_Accuracy <- (conM[1,1] + conM[2,2])/ sum(conM)
Test_Precision <- conM[2,2] / (conM[2,1] + conM[2,2])
Test_Recall <- conM[2,2] / (conM[1,2] + conM[2,2])

# Build Confusion Matrix (Option 2)
#conM <- confusionMatrix(pred_churn5Vars,
#                        actual_churn,
#                        positive="Yes",
#                        mode="prec_recall")

## Results
##Sampling - Bootstrapped
> chmodel_5vars
Generalized Linear Model 

4000 samples
   5 predictor
   2 classes: 'No', 'Yes' 

No pre-processing
Resampling: Bootstrapped (5 reps) 
Summary of sample sizes: 4000, 4000, 4000, 4000, 4000 
Resampling results:

  Accuracy   Kappa    
  0.8613696  0.1048187

> conM
         Actual
Predicted  No Yes
      No  845 137
      Yes  10   8
> Test_Accuracy
[1] 0.853
> Test_Precision
[1] 0.4444444
> Test_Recall
[1] 0.05517241

##Sampling - LOOCV (Note : Longer time to complete)
chmodel_5vars
Generalized Linear Model 

4000 samples
   5 predictor
   2 classes: 'No', 'Yes' 

No pre-processing
Resampling: Leave-One-Out Cross-Validation 
Summary of sample sizes: 3999, 3999, 3999, 3999, 3999, 3999, ... 
Resampling results:

  Accuracy  Kappa     
  0.85925   0.08592767

> conM
         Actual
Predicted  No Yes
      No  845 137
      Yes  10   8
> Test_Accuracy
[1] 0.853
> Test_Precision
[1] 0.4444444
> Test_Recall
[1] 0.05517241

##Sampling - K-Fold validation, 5 Fold
chmodel_5vars
Generalized Linear Model 

4000 samples
   5 predictor
   2 classes: 'No', 'Yes' 

No pre-processing
Resampling: Cross-Validated (5 fold) 
Summary of sample sizes: 3200, 3199, 3200, 3200, 3201 
Resampling results:

  Accuracy   Kappa     
  0.8595015  0.08650653

> conM
         Actual
Predicted  No Yes
      No  845 137
      Yes  10   8
> Test_Accuracy
[1] 0.853
> Test_Precision
[1] 0.4444444
> Test_Recall
[1] 0.05517241
