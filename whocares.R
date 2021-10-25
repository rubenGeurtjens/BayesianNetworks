install.packages(c("remotes","pROC","naivebayes","ranger"))
install.packages('dagitty')
library(dagitty)
library(bayesianNetworks)

setwd('/home/ruben/Documents/school/Master 2/Bayesian networks/BayesianNetworks/')

data <- read.csv('discretized_cleveland.csv')

testImplications <- function( covariance.matrix, sample.size ){
  library(ggm)
  tst <- function(i){ pcor.test( pcor(i,covariance.matrix), length(i)-2, sample.size )$pvalue }
  tos <- function(i){ paste(i,collapse=" ") }
  implications <- list(c("heart disease","age","sex","chol","ca"),
                       c("heart disease","fbs","sex","ca","chol"),
                       c("age","cp","heart disease"),
                       c("age","cp","ca","chol","sex"),
                       c("age","exang","heart disease"),
                       c("age","exang","ca","chol","sex"),
                       c("age","fbs"),
                       c("age","sex"),
                       c("age","thal"),
                       c("ca","cp","heart disease"),
                       c("ca","exang","heart disease"),
                       c("ca","sex"),
                       c("ca","thal"),
                       c("ca","thalach","heart disease","age"),
                       c("chol","cp","heart disease"),
                       c("chol","exang","heart disease"),
                       c("chol","thal","sex"),
                       c("chol","thalach","heart disease","age"),
                       c("cp","exang","heart disease"),
                       c("cp","fbs","sex","ca","chol"),
                       c("cp","fbs","heart disease"),
                       c("cp","oldpeak","heart disease"),
                       c("cp","restecg","heart disease"),
                       c("cp","sex","heart disease"),
                       c("cp","slope","heart disease"),
                       c("cp","thal","heart disease"),
                       c("cp","thalach","heart disease"),
                       c("cp","trestbps","heart disease"),
                       c("exang","fbs","sex","ca","chol"),
                       c("exang","fbs","heart disease"),
                       c("exang","oldpeak","heart disease"),
                       c("exang","restecg","heart disease"),
                       c("exang","sex","heart disease"),
                       c("exang","slope","heart disease"),
                       c("exang","thal","heart disease"),
                       c("exang","thalach","heart disease"),
                       c("exang","trestbps","heart disease"),
                       c("fbs","sex"),
                       c("fbs","thal"),
                       c("fbs","thalach","heart disease","age"),
                       c("fbs","thalach","ca","chol","sex","age"),
                       c("oldpeak","thal","heart disease","sex","ca","chol"),
                       c("oldpeak","thalach","heart disease","age"),
                       c("restecg","thal","heart disease","sex","ca","chol"),
                       c("restecg","thalach","heart disease","age"),
                       c("sex","thalach","heart disease","age"),
                       c("slope","thal","heart disease","sex","ca","chol"),
                       c("slope","thalach","heart disease","age"),
                       c("thal","thalach","heart disease","age"),
                       c("thal","thalach","sex","chol","ca","heart disease"),
                       c("thal","trestbps","sex","ca","chol","heart disease"),
                       c("thalach","trestbps","heart disease","age"))
  data.frame( implication=unlist(lapply(implications,tos)),
              pvalue=unlist( lapply( implications, tst ) ) )
  
}

impliedConditionalIndependencies(testImplications)




