#Tobias Seubert
#2023-11-07
#Data wrangling script for learning2014 data
library(dplyr)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


dim(lrn14)
str(lrn14)


lrn14$attitude <- lrn14$Attitude / 10

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(surface_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

## Different method than exercise. I consider it better, since it doesn't rely on the index, so it doesn't matter where for example the "Age" column is. Especially because R index starts at 1.
colnames(learning2014)[colnames(learning2014) == "Age"] <- "age"
colnames(learning2014)[colnames(learning2014) == "Points"] <- "points"

learning2014 <- filter(learning2014, points > 0)

write.table(learning2014, "data/learning2014.csv")

checkexport <- read.table("data/learning2014.csv")
str(checkexport)
