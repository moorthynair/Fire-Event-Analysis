library(readxl)
fire <- read_excel("sample_data_2019.xls")
View(fire)
library(lubridate)
fire$ACQ_DATE=ymd(fire$ACQ_DATE)
library(ggplot2)

#total fire count for individual district
ggplot(fire, aes(x=DISTRICT))+geom_bar( fill="blue")+coord_flip()

#Fire count / district/month
fire$month=as.numeric(format(fire$ACQ_DATE,'%m'))

#stacked
cbp2 <- c("#000000", "#E69F00", "#390099", "#009E73","#F0E442", "#0072B2", "#D55E00", "#CC79A7","#720026","#00a6fb","#0d3b66","6fffe9")
fire$month=factor(month,levels = c("1","2","3","4","5","6","7","8","9","10","11","12"))
ggplot(fire,aes(x=DISTRICT))+geom_bar(stat='count',aes(fill=as.factor(month)), color="black")+
  theme(plot.title = element_text(face="bold", color="black",hjust = 0.5),axis.text.x=element_text(face="bold", color="black"), axis.title.x = element_text(face="bold"), axis.text.y=element_text(face="bold", color="black"), axis.title.y = element_blank(), legend.title =element_text(face="bold",color="black"))+
  scale_fill_manual(name="Months", breaks=c("1","2","3","4","5","6","7","8","9","10","11","12"), labels=c("January","February","March","April","May","June","July","August","septemeber","October","November","Decemeber"), values=cbp2)+
  geom_text( stat='count',aes(label=..count..), hjust=-0.2,  fontface="bold", angle=0, size=3.2)+coord_flip()+ggtitle("Total Fire Count-2019")

#cropland
cbp3 <- c("#e63946", "#2f3e46", "#f3d8c7", "#606c38","#8338ec", "#f2f4f3", "#8d99ae", "#eefc57","#5f0f40","#fb8b24","#41ead4","6fffe9")
library(tidyverse)
library(dplyr)
fire_crop = fire %>% filter(MCD12Q1_A2==12)
ggplot(fire_crop,aes(x=DISTRICT))+geom_bar(stat='count',aes(fill=as.factor(month)), color="black")+
  theme(plot.title = element_text(face="bold", color="black",hjust = 0.5),axis.text.x=element_text(face="bold", color="black"), axis.title.x = element_text(face="bold"), axis.text.y=element_text(face="bold", color="black"), axis.title.y = element_blank(), legend.title =element_text(face="bold",color="black"))+
  scale_fill_manual(name="Months", breaks=c("1","2","3","4","5","6","7","8","9","10","11","12"), labels=c("January","February","March","April","May","June","July","August","septemeber","October","November","Decemeber"), values=cbp3)+
  geom_text( stat='count',aes(label=..count..), hjust=-0.2,  fontface="bold", angle=0, size=3.2)+coord_flip()+ggtitle("Agriculture Fire Count-2019")


## Fire Map for the year 2020
library(readxl)
fire <- read_excel("fire_data_2020.xls")
View(fire)
library(lubridate)
fire$ACQ_DATE=ymd(fire$ACQ_DATE)
library(ggplot2)

#total fire count for individual district
ggplot(fire, aes(x=DISTRICT))+geom_bar( fill="blue")+coord_flip()

#Fire count / district/month
fire$month=as.numeric(format(fire$ACQ_DATE,'%m'))
cbp2 <- c("#000000", "#E69F00", "#390099", "#009E73","#F0E442", "#0072B2", "#D55E00", "#CC79A7","#720026","#00a6fb","#0d3b66","6fffe9")
fire$month=factor(month,levels = c("1","2","3","4","5","6","7","8","9","10","11","12"))
ggplot(fire,aes(x=DISTRICT))+geom_bar(stat='count',aes(fill=as.factor(month)), color="black")+
  theme(plot.title = element_text(face="bold", color="black",hjust = 0.5),axis.text.x=element_text(face="bold", color="black"), axis.title.x = element_text(face="bold"), axis.text.y=element_text(face="bold", color="black"), axis.title.y = element_blank(), legend.title =element_text(face="bold",color="black"))+
  scale_fill_manual(name="Months", breaks=c("1","2","3","4","5","6","7","8","9","10","11","12"), labels=c("January","February","March","April","May","June","July","August","septemeber","October","November","Decemeber"), values=cbp2)+
  geom_text( stat='count',aes(label=..count..), hjust=-0.2,  fontface="bold", angle=0, size=3.2)+coord_flip()+ggtitle("Total Fire Count-2020")

#cropland
library(tidyverse)
library(dplyr)
fire_crop = fire %>% filter(MCD12Q1_A2==12)
ggplot(fire_crop,aes(x=DISTRICT))+geom_bar(stat='count',aes(fill=as.factor(month)), color="black")+
  theme(plot.title = element_text(face="bold", color="black",hjust = 0.5),axis.text.x=element_text(face="bold", color="black"), axis.title.x = element_text(face="bold"), axis.text.y=element_text(face="bold", color="black"), axis.title.y = element_blank(), legend.title =element_text(face="bold",color="black"))+
  scale_fill_manual(name="Months", breaks=c("1","2","3","4","5","6","7","8","9","10","11","12"), labels=c("January","February","March","April","May","June","July","August","septemeber","October","November","Decemeber"), values=cbp2)+
  geom_text( stat='count',aes(label=..count..), hjust=-0.2,  fontface="bold", angle=0, size=3.2)+coord_flip()+ggtitle("Agriculture Fire Count-2020")

agri_2020=fire_crop %>% filter(month=="1" | month=="2"| month=="3"| month=="4"| month=="5")
total_2020=fire %>% filter(month=="1" | month=="2"| month=="3"| month=="4"| month=="5")

# Trend analysis
Trend= data.frame("Year"=c(2019,2020), "Total Fire"=c(8936,2854), "Agriculture Fire"=c(6543,2115),"Forest Fire"=c(2393,739))
colnames(Trend)= c("Year","Total fire","Agricultural Fire","Forest Fire")
library(reshape2)
Trend_1=melt(Trend,id="Year",id.name = "Year", variable.name = "Fire Type", value.name = "Fire Count")
Trend_1$Year=as.factor(Trend_1$Year)
ggplot(Trend_1,aes(`Fire Type`,`Fire Count`, fill=Year))+geom_col(position="dodge", color="blaCK")+theme(axis.title.x = element_blank(),axis.title.y = element_text(face="bold",color="black"),
  axis.text.y = element_text(face="bold",color="black"),axis.text.x = element_text(face="bold",color="black"), 
  legend.title = element_text(face="bold",color="black"), legend.text = element_text(face="bold",color="black"), 
  plot.title=element_text(face="bold",color="black",hjust=0.5))+ggtitle("Trend Analysis (Jan-May)")+
  geom_text(aes(label= `Fire Count`),vjust=-0.5, color="black", fontface=2,
            position = position_dodge(0.9),  size=4)

agri_fire= table(agri_2020$DISTRICT,agri_2020$month)
write.table(agri_fire, file = 'Agri_count_2020.csv', row.names = T, sep=",")

k=table(may_2019$ACQ_DATE,may_2019$DISTRICT)

##December-fire count-2019
dec_2019=fire_crop %>% filter(month==12)
k=dec_2019 %>% count(ACQ_DATE,DISTRICT)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
                                                                   plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("Dec-2019")

##March-fire count-2019
march_2019=fire_crop %>% filter(month==3)
k=march_2019 %>% count(ACQ_DATE,DISTRICT)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
                                                                   plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("March-2019")

##April-fire count-2019
april_2019=fire_crop %>% filter(month==4)
k=april_2019 %>% count(ACQ_DATE,DISTRICT)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("April-2019")


##May-fire count-2019
k=may_2019 %>% count(ACQ_DATE,DISTRICT)
k$ACQ_DATE=factor(k$ACQ_DATE)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("May-2019")+
  scale_y_discrete(breaks=c('2019-05-01','2019-05-06','2019-05-13','2019-05-20','2019-05-27'), labels =c('May 01','May 06','May 13','May 20','May 27'))


##March-fire count-2020
march_2020=fire_crop %>% filter(month==3)
k=march_2020 %>% count(ACQ_DATE,DISTRICT)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
                                                                   plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("March-2020")

##April-fire count-2020
april_2020=fire_crop %>% filter(month==4)
k=april_2020 %>% count(ACQ_DATE,DISTRICT)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
                                                                   plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("April-2020")


##May-fire count-2020
may_2020=fire_crop %>% filter(month==5)
k=may_2020 %>% count(ACQ_DATE,DISTRICT)
k$ACQ_DATE=factor(k$ACQ_DATE)
ggplot(k,aes(DISTRICT, ACQ_DATE, fill=DISTRICT))+
  geom_point(aes(size=n),alpha=0.5, shape=21, color="black")+theme(legend.position = "none", axis.text.x = element_text(angle=90, face="bold", color="black"),
                                                                   plot.title=element_text(face="bold",color="black",hjust=0.5),axis.text.y = element_text( face="bold", color="black"), axis.title.x = element_blank(), axis.title.y = element_blank())+
  scale_size(range = c(3, 10))+geom_text(aes(label=n, size=2, fontface=2))+ ggtitle("May-2020")+
  scale_y_discrete(breaks=c('2020-05-01','2020-05-06','2020-05-13','2020-05-20','2020-05-27'), labels =c('May 01','May 06','May 13','May 20','May 27'))

count=table(fire_crop$DISTRICT)
write.table(count, file = 'Agri_count_2020_GIS.csv', row.names = T, sep=",")


## fire_count _block wise -2019
library(readr)
fire <- read_csv("fire_2019_block.xls.csv")
View(fire)
fire=fire %>% select("FID","LATITUDE","LONGITUDE","ACQ_DATE","FRP","MCD12Q1_A2","BLK_NAME","TRU","DIST_CODE","BLK_CODE","BLK_C_2011","DIST_NAME","BLK_C_2001") 
fire=fire %>% filter(MCD12Q1_A2 %in% 12)
fire$ACQ_DATE= dmy_hm(fire$ACQ_DATE)
fire$month = as.numeric(format(fire$ACQ_DATE,'%m'))
block_count = fire %>% group_by(BLK_NAME,BLK_CODE,DIST_NAME,DIST_CODE, BLK_C_2011,BLK_C_2001) %>% summarise(count=n())
block_count = arrange(block_count,DIST_NAME)
block_count= block_count[ ,c(1,2,5,6,3,4,7)]      
write.table(block_count, file="Fire_count_blockwise_2019.csv", row.names = F, sep=",")

##Rohtas
rohtas = fire %>% filter(DIST_NAME=="ROHTAS")
rohtas=rohtas %>% count(ACQ_DATE,BLK_NAME)
rohtas$ACQ_DATE=as.Date(rohtas$ACQ_DATE)
rohtas$BLK_NAME=factor(rohtas$BLK_NAME)
ggplot(rohtas,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Rohtas -2019")

##Kaimur (Bhabua)
kaimur = fire %>% filter(DIST_NAME=="KAIMUR (BHABUA)")
kaimur=kaimur %>% count(ACQ_DATE,BLK_NAME)
kaimur$ACQ_DATE=as.Date(kaimur$ACQ_DATE)
kaimur$BLK_NAME=factor(kaimur$BLK_NAME)
ggplot(kaimur,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Kaimur -2019")

##Buxar
buxar = fire %>% filter(DIST_NAME=="BUXAR")
buxar=buxar %>% count(ACQ_DATE,BLK_NAME)
buxar$ACQ_DATE=as.Date(buxar$ACQ_DATE)
buxar$BLK_NAME=factor(buxar$BLK_NAME)
ggplot(buxar,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Buxar -2019")

##PASHCHIM CHAMPARAN
pashchamparan = fire %>% filter(DIST_NAME=="PASHCHIM CHAMPARAN")
pashchamparan=pashchamparan %>% count(ACQ_DATE,BLK_NAME)
pashchamparan$ACQ_DATE=as.Date(pashchamparan$ACQ_DATE)
pashchamparan$BLK_NAME=factor(pashchamparan$BLK_NAME)
ggplot(pashchamparan,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Pashchim Champaran -2019")

##PURBI CHAMPARAN
purbichamparan = fire %>% filter(DIST_NAME=="PURBI CHAMPARAN")
purbichamparan=purbichamparan %>% count(ACQ_DATE,BLK_NAME)
purbichamparan$ACQ_DATE=as.Date(purbichamparan$ACQ_DATE)
purbichamparan$BLK_NAME=factor(purbichamparan$BLK_NAME)
ggplot(purbichamparan,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Purbi Champaran -2019")

##GOPALGANJ
gopalganj = fire %>% filter(DIST_NAME=="GOPALGANJ")
gopalganj=gopalganj %>% count(ACQ_DATE,BLK_NAME)
gopalganj$ACQ_DATE=as.Date(gopalganj$ACQ_DATE)
gopalganj$BLK_NAME=factor(gopalganj$BLK_NAME)
ggplot(gopalganj,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Gopalganj-2019")

##SIWAN
siwan = fire %>% filter(DIST_NAME=="SIWAN")
siwan=siwan %>% count(ACQ_DATE,BLK_NAME)
siwan$ACQ_DATE=as.Date(siwan$ACQ_DATE)
siwan$BLK_NAME=factor(siwan$BLK_NAME)
ggplot(siwan,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Siwan-2019")

##SARAN
saran = fire %>% filter(DIST_NAME=="SARAN")
saran=saran %>% count(ACQ_DATE,BLK_NAME)
saran$ACQ_DATE=as.Date(saran$ACQ_DATE)
saran$BLK_NAME=factor(saran$BLK_NAME)
ggplot(saran,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Saran-2019")


##BHOJPUR
bhojpur = fire %>% filter(DIST_NAME=="BHOJPUR")
bhojpur=bhojpur %>% count(ACQ_DATE,BLK_NAME)
bhojpur$ACQ_DATE=as.Date(bhojpur$ACQ_DATE)
bhojpur$BLK_NAME=factor(bhojpur$BLK_NAME)
ggplot(bhojpur,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Bhojpur-2019")

##BEGUSARAI
begusrai = fire %>% filter(DIST_NAME=="BEGUSARAI")
begusrai=begusrai %>% count(ACQ_DATE,BLK_NAME)
begusrai$ACQ_DATE=as.Date(begusrai$ACQ_DATE)
begusrai$BLK_NAME=factor(begusrai$BLK_NAME)
ggplot(begusrai,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.9, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Begusrai-2019")

##JAMUI
jamui = fire %>% filter(DIST_NAME=="JAMUI")
jamui=jamui %>% count(ACQ_DATE,BLK_NAME)
jamui$ACQ_DATE=as.Date(jamui$ACQ_DATE)
jamui$BLK_NAME=factor(jamui$BLK_NAME)
ggplot(jamui,aes(BLK_NAME, ACQ_DATE))+
  geom_point(aes(size=n), fill="red",alpha=0.5, shape=21, color="black")+scale_size(range = c(3, 10))+
  theme(axis.text.x = element_text(angle=90, face="bold", color = "black"), legend.position = "none",axis.text.y = element_text(face="bold", color = "black"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(face="bold",color = "black", hjust=0.5),
        panel.grid.major.y = element_line(colour = "black"),panel.grid.minor.y = element_line(colour = "black"),panel.grid.major.x = element_line(colour = "black"),panel.grid.minor.x = element_line(colour = "black"),panel.background = element_rect(fill="#ffffff"),panel.border = element_rect(colour = "black", fill=NA))+
  scale_y_date(date_breaks = "1 month",  date_labels = "%B %Y")+ggtitle("Jamui-2019")

## Agriculture count blocklevel -2017
library(readr)
fire <- read_csv("blockwise_agri_count-2017.csv")
View(fire)
fire=fire[ ,c(165,172,174)]
library(tidyverse)
library(dplyr)
fire = fire %>% mutate(count = replace(Count_, Count_==0, NA))
fire=fire %>% select(1,2,4)
fire = na.omit(fire)
fire=fire %>% arrange(DIST_NAME,BLK_NAME)
write.table(fire, file="Fire_count_blockwise_2017.csv", row.names = F, sep=",")

## Agriculture count blocklevel -2018
library(readr)
fire <- read_csv("Export_Output_agri.csv")
View(fire)
fire=fire[ ,c(165,172,174)]
library(tidyverse)
library(dplyr)
fire = fire %>% mutate(count = replace(Count_, Count_==0, NA))
fire=fire %>% select(1,2,4)
fire = na.omit(fire)
fire=fire %>% arrange(DIST_NAME,BLK_NAME)
write.table(fire, file="Fire_count_blockwise_2018.csv", row.names = F, sep=",")


##combine
##2017
library(readxl)
fire_17 <- read_excel("Fire_count_blockwise_2017.xlsx")
View(fire_17)
##2018
library(readxl)
fire_18 <- read_excel("Fire_count_blockwise_2017.xlsx", 
                      sheet = "Fire_count_blockwise_2018")
View(fire_18)
##2019
library(readxl)
fire_19 <- read_excel("Fire_count_blockwise_2017.xlsx", 
                      sheet = "Fire_count_blockwise_2019")
View(fire_19)

combine = full_join(fire_17,fire_18,by=c("BLK_NAME","DIST_NAME"))
combine = full_join(combine,fire_19,by=c("BLK_NAME","DIST_NAME"))
combine = combine %>% replace_na(list(`count-2017`=0, `count-2018`=0, `count-2019`=0))
combine$Diff_2019_2018 = combine$`count-2019`-combine$`count-2018`
combine$Diff_2019_2017 = combine$`count-2019`-combine$`count-2017`
combine$sum_all_years = apply(combine[ ,c(3:5)],1,sum)
blocks = combine %>% filter(sum_all_years>=50)

write.table(combine, file="C:/Users/HP/Desktop/data/Final_combined_blockwise.csv", row.names = F, sep=",")
write.table(blocks, file="C:/Users/HP/Desktop/data/Block_prioritiy.csv", row.names = F, sep=",")
