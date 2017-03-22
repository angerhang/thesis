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
