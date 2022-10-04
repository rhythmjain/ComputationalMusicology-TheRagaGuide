library(dplyr)
library(corrplot)
library(car)
library(psych)

###load the data
setwd("~/Box/projects/01_in_progress/raga_guide/raga_guide/")
raga_data <- read.csv("raga_dataframe.csv", header=T)
raga_data[,2] <- as.numeric(as.character(raga_data[,2]))
###get rid of columns that have only 0s (transitions from weird notes)
raga_data1 <- raga_data[, sapply(raga_data, class) != "integer"]

##get rid of some blank/unimportant ones
raga_data1$X <- NULL
raga_data1$FILENAME <- NULL
raga_data1$Identical. <- NULL
# data <- raga_data[,colSums(raga_data[,28:ncol(raga_data)]) != 0]
# subsetted_ragas <- raga_data[,!apply(raga_data,2,function(x) all(x==0))] 

##make a matrix for correlation
my_data <- as.matrix(raga_data1[,2:ncol(raga_data1)])
###note it does seem like there's some collinearity happening. :-/
my_cor <- cor(raga_data1[,2:ncol(raga_data1)])

###plot correlation
corrplot(my_cor)
###get values
cor(my_cor)

#### Levene test
levene_data <- lapply(raga_data1[-1], function(x) leveneTest(raga_data1$y_variable, x, center=mean))
leveneTest(y_variable ~ ., data=raga_data1, center=median)
leveneTest(y_variable ~ average_interval *average_ioi *average_pitch,
                                         data = raga_data1)
subsetted_data <- raga_data1[,1:23]
subsetted_data$short_long <- NULL
subsetted_data$intervallic_entropy <- NULL
log_data <- log(subsetted_data[,-1] +1)
boxplot(log_data[,-1])
dwt(y_variable ~ ., data=subsetted_data)
#lapply(raga_data1, function(x) log1p(raga_data1))

log_data_matrix <- as.matrix(log_data[,2:ncol(log_data)])
ToD <- subsetted_data$y_variable 
levene_log_data <- lapply(log_data[-1], function(x) leveneTest(log_data$y_variable, x, center=mean))
my_cor <- cor(log_data_matrix[,2:ncol(log_data_matrix)])

corrplot(my_cor)

library(MASS)


supersubsetted_data <- cbind(subsetted_data$y_variable, subsetted_data$lowered_re, subsetted_data$average_pitch)
# linear_model <- lm(supersubsetted_data[,1] ~ supersubsetted_data[,2] + supersubsetted_data[,3])
classified_y_data <- mutate(subsetted_data, y_variable = ifelse(y_variable > 820, "Day", "Night"))
#linear_model <- lm(y_variable ~ ., data=supersubsetted_data)

linear_model <- lm(y_variable ~ ., data=subsetted_data)
summary(linear_model
        )
step <- stepAIC(linear_model, direction="backward")
summary(step)

####principal components analysis on all data
# library(gmodels)
# library(devtools)
# #install_github("ggbiplot", "vqv")
# library(ggplot2)
# library(ggbiplot)
# # load the "class" library
# library(class)
# ToD <-  raga_data1$y_variable
# pieces.pca <- prcomp(log_data_matrix,
#                      center = TRUE,
#                      scale. = TRUE) 
# print(pieces.pca)
# plot(pieces.pca, type = "l", main="Principal Components Analysis")
# summary(pieces.pca)
# 
# 
# g <- ggbiplot(pieces.pca, obs.scale = 1, var.scale = 1, groups =ToD,
#               ellipse = TRUE, 
#               circle = TRUE)
# g <- g + scale_color_discrete(name = '')
# g <- g + theme(legend.direction = 'horizontal', 
#                legend.position = 'top')
# print(g)
# 
# 
# 
# require(ggplot2)
# 
# theta <- seq(0,2*pi,length.out = 100)
# circle <- data.frame(x = cos(theta), y = sin(theta))
# p <- ggplot(circle,aes(x,y)) + geom_path()
# 
# loadings <- data.frame(pieces.pca$rotation, 
#                        .names = row.names(pieces.pca$rotation))
# p + geom_text(data=loadings, 
#               mapping=aes(x = PC1, y = PC2, label = .names, colour = .names)) +
#   coord_fixed(ratio=1) +
#   labs(x = "PC1", y = "PC2")
# 
# step2 <- stepAIC(pieces.pca$x, direction="backward")
# 
# library(pls)
# set.seed (1000)
# pcr_model <- pcr(y_variable~., data = subsetted_data, scale = TRUE, validation = "CV")
# summary(pcr_model)
# validationplot(pcr_model)
# validationplot(pcr_model, val.type="MSEP")
# validationplot(pcr_model, val.type = "R2")
# predplot(pcr_model)
# 
# 
# train <- subsetted_data[1:40,]
# y_test <- subsetted_data[41:65, 1]
# test <- subsetted_data[41:65, 1:21]
# pcr_model <- pcr(y_variable~., data = train,scale =TRUE, validation = "CV")
# pcr_pred <- predict(pcr_model, test, ncomp = 3)
# mean((pcr_pred - y_test)^2)


############ all subsets regression.
library(leaps)
plot.regsubsets2 <- function(x, labels = obj$xnames, main = NULL, scale = c("bic", "Cp", "adjr2", "r2"), col = gray(seq(0, 0.9, length = 10)))
  {
    obj <- x
    lsum <- summary(obj)
    par(mar = c(7, 5, 6, 3) + 0.1)
    nmodels <- length(lsum$rsq)
    np <- obj$np
    propscale <- FALSE
    sscale <- pmatch(scale[1], c("bic", "Cp", "adjr2", "r2"), 
                     nomatch = 0)
    if (sscale == 0) 
      stop(paste("Unrecognised scale=", scale))
    if (propscale) 
      stop(paste("Proportional scaling only for probabilities"))
    yscale <- switch(sscale, lsum$bic, lsum$cp, lsum$adjr2, lsum$rsq)
    up <- switch(sscale, -1, -1, 1, 1)
    index <- order(yscale * up)
    colorscale <- switch(sscale, yscale, yscale, -log(pmax(yscale, 
                                                           1e-04)), -log(pmax(yscale, 1e-04)))
    image(z = t(ifelse(lsum$which[index, ], colorscale[index], 
                       NA + max(colorscale) * 1.5)), xaxt = "n", yaxt = "n", 
          x = (1:np), y = 1:nmodels, xlab = "", ylab = scale[1], 
          col = col)
    laspar <- par("las")
    on.exit(par(las = laspar))
    par(las = 2)
    ticks<-c(.1,.2,.3,.4,.5)
    axis(1, at = 1:np, labels = labels) # I modified this line
    axis(2, at = ticks, labels = ticks)
    if (!is.null(main)) 
      title(main = main)
    box()
    invisible(NULL)
  }
#leaps <- regsubsets(y_variable ~ ., data=subsetted_data,nbest=10)
leaps <- regsubsets(y_variable ~ ., data=subsetted_data,nbest=5)

summary.out <- summary(leaps)
pdf("figure2.pdf")
plot(leaps, scale = "adjr2")
dev.off()

#### 
layout(matrix(1:1, ncol = 1))
## Adjusted R2
res.legend <-
  subsets(leaps, statistic="adjr2", legend = FALSE, min.size = 5, max.size = 10, main = "Adjusted R^2")
## Mallow Cp
res.legend <-
  subsets(leaps, statistic="cp", legend = FALSE, min.size = 5, main = "Mallow Cp")
abline(a = 1, b = 1, lty = 2)
library(car)
# subsets(leaps, statistic="rsq")


which.max(summary.out$adjr2)
summary.out$which[71,]
###best model without removing influential cases
best.model <- lm(y_variable ~ lowered_re + ma + pa + lowered_da + average_pitch + average_interval, data = subsetted_data)
###removing influential cases
best.model <- lm(y_variable ~ re + lowered_re + ma + pa + da + lowered_da + average_interval + long_long, data = validated_subsetted_data)
best.model.stdres <- rstandard(best.model)
summary(best.model)

###data frame of just these variables:
my_new_data <- cbind(subsetted_data$y_variable, subsetted_data$lowered_re, subsetted_data$ma, 
        subsetted_data$pa, subsetted_data$lowered_da, subsetted_data$average_pitch, subsetted_data$average_interval)


summary.out$which[51,]
####run a vif diagnostic
vif(best.model)
dwt(y_variable ~ ., data=)


library(ggplot2)

# A is (a,b; c,d) matrix
A <- matrix(c(1, 2, -1, 0), 
            nrow=2, ncol=2, byrow=TRUE)
gamma <- 1
c1 <- 0.2
c2 <- 0.1

############################### absolute value plotting
z <- seq(-gamma*2, gamma*2, length=100)
w <- abs(gamma + abs(z))

qplot(z+3, w, ylab = "Arousal Level", ) + coord_fixed() + 
  theme_bw() +
  theme(axis.text.y=element_blank(),
       axis.ticks.y=element_blank()) +
  scale_x_discrete(name ="Time of Day",
                   limits=c("3:30pm", "9:30pm", "3:30am", "9:30am", "3:29pm"))
ggsave("hypothesis_visualized.pdf", dpi=1200)

################################

##tables of frequency distributions
library(ggplot2)

amalgamated <- read.csv("amalgamated_pitches.csv", header=F)
amalgamated <- as.data.frame(filter(amalgamated, V1 != "—"))
amalgamated$V1 <- as.numeric(as.character(amalgamated$V1))
ggplot(amalgamated, aes(V1)) +
  geom_histogram(stat = "count") +
  theme_bw() +
  xlab("Pitches Used \n (Combining Altered and Unaltered Tones)") +
  ggtitle("Distribution of Pitches")
ggsave("amalgamated_pitches.pdf")


total <- read.csv("total_pitch_data.csv", header=F)
total <- as.data.frame(filter(total, V1 != "—"))
ggplot(total, aes(V1)) +
  geom_histogram(stat = "count") +
  theme_bw() +
  xlab("Pitches Used") +
  ggtitle("Distribution of Pitches")
ggsave("total_pitches.pdf")



total %>%
  mutate(name = factor(V1, levels=c("1", "2-", "2", "3-", "3", "4", "4+", "5", "6", "6-", "7--", "7-", "7"))) %>%
  ggplot(total, aes(V1)) +
  geom_histogram(stat = "count") +
  theme_bw() +
  xlab("Pitches Used") +
  ggtitle("Distribution of Pitches")

##### different order polynomials

library(ggplot2)
fit_2 <- lm(y_variable ~ lowered_re + I(y_variable^2), data = subsetted_data)
fit_3 <- lm(y_variable ~ lowered_re + I(y_variable^3), data = subsetted_data)
fit_4 <- lm(y_variable ~ lowered_re + I(y_variable^4), data = subsetted_data)

anova(fit_2, fit_3, fit_4)

