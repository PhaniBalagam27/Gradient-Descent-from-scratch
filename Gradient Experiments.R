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
x <- as.matrix(cbind(x0,x1))

# create the y-matrix of dependent variables

y <- as.matrix(testDS$cnt)
m <- nrow(y)

# Solve for beta
betas <- solve(t(x)%*%x)%*%t(x)%*%y 
betas
# Round the beta values

# Gradient descent 1
gradientDesc <- function(x, y, learn_rate, conv_threshold, max_iter) {
  n <- nrow(x) 
  m <- runif(ncol(x), 0, 1) # m is a vector of dimension ncol(x), 1
  yhat <- x %*% m # since x already contains a constant, no need to add another one
  
  MSE <- sum((y - yhat) ^ 2) / n
  
  converged = F
  iterations = 0
  a <- rep(0,nrow(trainingDS))
  b <- rep(0,nrow(trainingDS))
  while(converged == F) {
    m <- m - learn_rate * ( 1/n * t(x) %*% (yhat - y))
    yhat <- x %*% m
    MSE_new <- sum((y - yhat) ^ 2) / n
    
    
    if( abs(MSE - MSE_new) <= conv_threshold) {
      converged = T
    }
    iterations = iterations + 1
    a[iterations] = MSE_new
    b[iterations] = iterations
    MSE <- MSE_new
    
    if(iterations >= max_iter) break
    
  }
 
  
  return(list(converged = converged, 
              num_iterations = iterations, 
                MSE = MSE_new, 
              coefs = m, a = a, b = b) )
  
}


c <- gradientDesc(x,y, 0.7, 10**-6, 10000)

c
plot(c$b, c$a,main='Iterations VS MSE',xlab = "Iterations", ylab = "MSE",col=rgb(0.8,0,0,0.3))

Experimental_Dataset_train <- read.csv("C:/Users/phani/Desktop/Desktop/Ms Courses/Applied Machine Learning/Project1/Experimental Dataset train.csv",header = TRUE)
Experimental_Dataset_test <- read.csv("C:/Users/phani/Desktop/Desktop/Ms Courses/Applied Machine Learning/Project1/Experimental Dataset test.csv",header = TRUE)
Experimental_Dataset_train
Experimental_Dataset_test

plot(Experimental_Dataset_train$alpha, Experimental_Dataset_train$MSE_new,type = "o", col = "red", xlab = "Alpha", ylab = "MSE",
     main = "Alpha Vs MSE for Train Dataset",xlim = c(0.1,0.8))

plot(Experimental_Dataset_test$alpha, Experimental_Dataset_test$MSE_new,type = "o", col = "blue", xlab = "Alpha", ylab = "MSE",
     main = "Alpha Vs MSE for Test dataset",ylim=c(0.62,0.64))
  

plot(Experimental_Dataset_train$conv_threshold, Experimental_Dataset_train$iterations, col = "red", xlab = "Threshold", ylab = "iterations",
     main = "Threshold Vs iterations for Train Dataset")

plot(Experimental_Dataset_test$conv_threshold, Experimental_Dataset_test$iterations,col = "blue", xlab = "Threshold", ylab = "iterations",
     main = "Threshold Vs iterations for Test dataset")

ggplot(Experimental_Dataset, aes(x=conv_threshold, y=iterations, group=Dataset)) +
  geom_point(aes(shape=Dataset, color=Dataset), size=2)+
  scale_shape_manual(values=c(15, 16))+
  scale_color_manual(values=c('#56B4E9','#E69F00'))+
  theme(legend.position="top") + xlab( 'Threshold') + ylab('iterations') 
