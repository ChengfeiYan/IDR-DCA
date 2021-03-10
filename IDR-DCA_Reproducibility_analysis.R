%%R
library(stargazer)
library(idr)
library("reader")
length=130                         #The sequence length
file=paste("1g9oA_contact_prediction_ccmpred.csv",sep="")   #"1g9oA_contact_prediction_ccmpred.csv": DCA results from the whole MSA and the two MSA pseudo-replicates (See Examples)
Pred<-read.csv(file,sep="\t")
Pred_selected<-Pred[Pred$coupling_rank<10*length,]
coupling_score_f1=Pred_selected$coupling_score_r1
coupling_score_f2=Pred_selected$coupling_score_r2
mu <- 1.0
sigma <-1.0     
rho <-0.2
p <- 0.1
x <- cbind(coupling_score_f1,coupling_score_f2)
idr.out <- est.IDR(x, mu, sigma, rho, p, eps=1e-4,max.ite=100)
Pred_selected["IDR"]<-idr.out$idr
write.table(Pred_selected,"1g9oA_coupling_IDR_ccmpred.csv",sep="\t", row.names = FALSE,quote = FALSE) #"1g9oA_coupling_IDR_ccmpred.csv" Resiude pairs with IDR values which represent the reproducibility of the coupling 
}
