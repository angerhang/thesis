mydata <- read.csv("~/6thSemester/thesis/data/subject_meta.csv")

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

# generate predictor dataframe
newdata <- rbind(tomerge_old, young)
labels <- newdata[, c("Code", "learn", "Age")]
topredict <- saved_old[, c("Code", "learn", "Age")]
write.csv(labels, file = "~/6thSemester/thesis/data/labels.csv")
write.csv(topredict, file = "~/6thSemester/thesis/data/topredict.csv")



