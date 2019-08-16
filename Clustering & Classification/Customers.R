set.seed(5000)
custData<-read.csv("C:/Users/Goutham/Desktop/DataMining/Assignment1/docust.csv")
custData<-custData[custData$TotalPurchase<80000 &custData$NoProductsBought<4000,] 
withinSSrange <- function(data,low,high,maxIter)
{
  withinss = array(0, dim=c(high-low+1)); 
  for(i in low:high)
  {
    withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
  }
  withinss }
custData.scale<-scale(custData[,2:6]) 
plot(withinSSrange(custData.scale,2,50,150))
silh_score<- function(k){
  km<-kmeans(custData.scale,centers=k) ;
  ss<-silhouette(km$cluster,dist(custData.scale));
  mean(ss[,3])}
k<-2:10
library(cluster)
avg_sil<-sapply(k,silh_score)
plot(k, type='b', avg_sil, xlab='Number of clusters', ylab='Average Silhouette Scores', frame=FALSE)
custcluster<-kmeans(custData.scale,8,150)
custcluster$size
custDatacluster<-cbind(custData,custcluster$cluster)
write.csv(custDatacluster,"~ /CustomerClusterfinal.csv")
