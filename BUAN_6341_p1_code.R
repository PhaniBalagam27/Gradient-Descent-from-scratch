library(ggplot2)

data <- read.csv("E:/AML - BUAN 6341/hour.csv",header = TRUE)
data1 <- data[, c("season", "mnth", "hr", "holiday", "weekday", "workingday", "weathersit", "temp", "atemp", "hum", "windspeed", "cnt")]
data1 <- scale(data1)
# Examine the data structure
str(data1)
summary(data1)
# Linear regression
# Set seed
set.seed(100)
# Split the data
trainingObs<-sample(nrow(data1),0.70*nrow(data1),replace=FALSE)
# Create the training dataset
trainingDS<-data1[trainingObs,]
# Create the test dataset
testDS<-data1[-trainingObs,]
testDS <- as.data.frame(testDS)

x0 <- rep(1, nrow(testDS)) # column of 1's
x1 <- testDS[, c("season", "mnth", "hr", "holiday", "weekday", "workingday", "weathersit", "temp", "atemp", "hum", "windspeed")]

# create the x- matrix of explanatory variables
X <- as.matrix(cbind(x0,x1))

# create the y-matrix of dependent variables

y <- as.matrix(testDS$cnt)

theta<-rep(0,12)

Caluculate_cost<-function(X, y, theta){
  m <- length(y)
  W <- sum((X%*%theta- y)^2)/(2*m)
  return(W)
}

gradDescent<-function(X, y, theta, alpha, Iterations){
  m <- length(y)
  W_hist <- rep(0, Iterations)
  for(i in 1:Iterations){
    
    # this is a vectorized form for the gradient of the cost function
    # X is a 100x5 matrix, theta is a 5x1 column vector, y is a 100x1 column vector
    # X transpose is a 5x100 matrix. So t(X)%*%(X%*%theta - y) is a 5x1 column vector
    theta <- theta - alpha*(1/m)*(t(X)%*%(X%*%theta - y))
    
    # this for-loop records the cost history for every iterative move of the gradient descent,
    # and it is obtained for plotting number of iterations against cost history.
    W_hist[i]  <- Caluculate_cost(X, y, theta)
  }
  # for a R function to return two values, we need to use a list to store them:
  results<-list(theta, W_hist)
  return(results)
}

alpha <- .7
Iterations <- 500
results <- gradDescent(X, y, theta, alpha, Iterations)
theta <- results[[1]]
cost1 <- results[[2]]
print(theta)
print(cost1)