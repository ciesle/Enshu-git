cor2par <- function(R){
  X <- solve(R)
  d <- sqrt(diag(X))
  P <- -X / (d %*% t(d))
  diag(P) <- 1
  return(P)
}
select.ij <- function(P,amat){
  p <- nrow(P); minabsP <- Inf
  for(i in (2:p)){
    for(j in (1:(i-1))){
      if(amat[i,j]==1 && abs(P[i,j]) < minabsP){
        minabsP <- abs(P[i,j]);
        i0 <- i;
        j0 <- j;
      }
    }
  }
  return(c(i0,j0))
}
get.aic <- function(dev,df){
  yudo <- dev/-2;
  return(-2*yudo-2*df);
}

# 準備
setwd("C:/Users/thistle/projects/enshu-git/keisu_jikken/stats")
options(digits=3)
library("ggm")
data <- read.table("stats.csv", sep=",", header=T, as.is=T)
X <- data[2:48,2:9]
R <- cor(X);
n <- nrow(X); p <- ncol(X);

amat <- matrix(1,p,p)-diag(p);
dimnames(amat) <- dimnames(R)

# ループ処理
cnt <- 0
res=c()
repeat{
  R <- cor(X);
  f <- fitConGraph(amat,R,n);
  aic <- get.aic(f$dev, f$df);
  M <- f$Shat;
  P <- cor2par(M);
  if(cnt == 0){
    M.first <- apply(M,1,function(x){return(round(x,3))})
    P.first <- apply(P,1,function(x){return(round(x,3))})
  }
  
  # 更新処理
  pivot=select.ij(P, amat);
  new_amat <- amat
  new_amat[pivot[1],pivot[2]] <- new_amat[pivot[2],pivot[1]] <- 0;
  new_f <- fitConGraph(new_amat,R,n);
  new_aic <- get.aic(new_f$dev, new_f$df);
  
  
  cnt <- cnt+1
  # もしも値が増えていたら終了
  if(new_aic>=aic){
    M.round <- apply(M,1,function(x){return(round(x,3))})
    P.round <- apply(P,1,function(x){return(round(x,3))})
    drawGraph(amat,adjust=TRUE)
    break
  }
  else{
    res=c(res,c(round(new_aic-aic,3), paste(colnames(data)[pivot[1]+1], "―", colnames(data)[pivot[2]+1],sep="")));
  }
  amat <- new_amat
}
res=matrix(res,ncol=2,byrow = T);
colnames(res)=c("AICの変化", "削除した辺")
print(res)