mydata <- read.csv("~/thesis/data/subject_meta.csv")

# reformat row name
chars <- as.character(mydata$Code)
mydata$Code <- paste(chars, "_3", sep = "")

# list to delete for poor eeg
to_del <- c('1c9q2a_3', '6n4r5k_3', 'Y1D_3');
for (code in to_del) {
  mydata = mydata[!mydata$Code == code, ]
}

# spilt data
ageThres = 30
young <- mydata[mydata$Age < ageThres, ]
old <- mydata[mydata$Age >= ageThres, ]

# finding outliers
library(outliers)
par(mfrow = c(1, 2))
boxplot(young$RMSE_rel)
boxplot(old$RMSE_rel)

young_out = outlier(young$RMSE_rel,logical=TRUE)
old_out = outlier(old$RMSE_rel,logical=TRUE)
young[young_out, ]
old[old_out, ]

# insert class labels
# 1 for good learners and 2 for bad learners
young = young[!young_out, ]
old = old[!old_out, ]

young$learn = 1
old$learn = 1
old[old$RMSE_rel > median(old$RMSE_rel), ]$learn = 2
tomerge_old = old[old$learn == 2, ]
saved_old = old[old$learn == 1, ]
saved_old$learn = 2;

# generate predictor dataframe
newdata <- rbind(tomerge_old, young)
labels <- newdata[, c("Code", "learn", "Age")]
write.csv(labels, file = "~/thesis/data/labels.csv")

# second model
write.csv(old, file = "~/thesis/data/secondPredict.csv")

# third model
third_data = rbind(saved_old, young);
write.csv(third_data, file = '~/thesis/data/thirdPredict.csv')



