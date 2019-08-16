set.seed(5000)
prodData<-read.csv("C:\\Users\\Goutham\\Desktop\\CDA Assignments - 2nd sem\\Data Mining\\All assignment codes\\Assignment1\\docprod.csv")
prodData<-prodData[prodData$revenue<80000,]
withinSSrange <- function(data,low,high,maxIter) {
  withinss = array(0, dim=c(high-low+1)); for(i in low:high)
  {
    withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
  }
  withinss }
prodData.scale<-scale(prodData[,2:5])
plot(withinSSrange(prodData.scale,2,50,150))
silh_score<- function(k){
  km<-kmeans(prodData.scale,centers=k) ;ss<-
  silhouette(km$cluster,dist(prodData.scale));mean(ss[,3])} k<-2:10
library(cluster)
avg_sil<-sapply(k,silh_score)
plot(k, type='b', avg_sil, xlab='Number of clusters', ylab='Average Silhouette Scores', frame=FALSE)
pkmcluster<-kmeans(prodData.scale,6,150)
pkmcluster$size
prodDatacluster<-cbind(prodData,pkmcluster$cluster)
write.csv(prodDatacluster,"~ /ProductClusterfinal.csv")
