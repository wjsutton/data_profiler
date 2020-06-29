# 2020-06-29
# Reviewing packages that do data quality/validation check and reports


# Pointblank
# Set up valiadation tests against data
# e.g. a string should be of a certain format
# you can then create an 'agent' to issue alerts or stop pipelines
# requires knowledge of the data (for validation testing)

#install.packages("pointblank")
library(pointblank)

small_table

agent <- 
  small_table %>%
  create_agent() %>%
  col_is_posix(vars(date_time)) %>%
  col_vals_in_set(vars(f), set = c("low", "mid", "high")) %>%
  col_vals_lt(vars(a), value = 10) %>%
  col_vals_regex(vars(b), regex = "^[0-9]-[a-z]{3}-[0-9]{3}$") %>%
  col_vals_between(vars(d), left = 0, right = 5000) %>%
  interrogate()

# InspectDF
# Provides some functionality to describe data frames
# No out of the box full reports as yet

#install.packages("inspectdf")
library(inspectdf)

inspect_types(iris) # summary of column types
inspect_mem(iris) # summary of memory usage of columns
inspect_na(iris) # columnwise prevalence of missing values
inspect_cor(iris) # correlation coefficients of numeric columns
inspect_imb(iris) # feature imbalance of categorical columns
inspect_num(iris) # summaries of numeric columns
inspect_cat(iris) # summaries of categorical columns

# SmartEDA
# https://cran.r-project.org/web/packages/SmartEDA/vignettes/SmartEDA.html#introduction

# From documentation provides extensive data checks
# There may be some functional here that can be leveraged 
# into a workflow for a procedure



# Idea for this repo
# Creating distribution plots for a HTML report on data quality

library(ggplot2)

p <- ggplot(iris, aes(x=Sepal.Length, fill="red")) + 
  geom_density(alpha=.3) +
  geom_vline(aes(xintercept=mean(Sepal.Length, na.rm=T)),   # Ignore NA values for mean
             color="red", linetype="dashed", size=1)
p