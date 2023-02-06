## Load randomisation data to get ITT database for the remdesivir final analysis

rand.TH58 <- read.csv("~/Dropbox/PLATCOV/rand-TH58.csv")[0:9, ]
rand.TH57 <- read.csv("~/Dropbox/PLATCOV/rand-TH57.csv")[0:10, ]

data.TH1 <- read.csv("~/Dropbox/PLATCOV/data-TH1.csv")
data.TH1$Date = as.POSIXct(data.TH1$Date,format='%a %b %d %H:%M:%S %Y')
data.TH1 = data.TH1[data.TH1$Date < '2022-06-11',  ]

data.BR3 <- read.csv("~/Dropbox/PLATCOV/data-BR3.csv")
data.BR3$Date = as.POSIXct(data.BR3$Date,format='%a %b %d %H:%M:%S %Y')
data.BR3 = data.BR3[data.BR3$Date < as.POSIXct('2022-06-11'),]


data.TH1$ID = paste('PLT-TH1-',data.TH1$randomizationID,sep='')
rand.TH58$ID = paste('PLT-TH58-',rand.TH58$RandomisationID,sep='')
rand.TH57$ID = paste('PLT-TH57-',rand.TH57$RandomisationID,sep='')
data.BR3$ID = paste('PLT-BR3-',data.BR3$randomizationID,sep='')

xx = rbind(data.TH1[, c('ID', 'Treatment')],
           rand.TH58[, c('ID', 'Treatment')],
           rand.TH57[, c('ID', 'Treatment')],
           data.BR3[, c('ID', 'Treatment')])

library(stringr)
for(i in 1:nrow(xx)){
  id = unlist(strsplit(xx$ID[i],split = '-'))
  id[3] = str_pad(id[3], 3, pad = "0")
  id = paste(id, collapse = '-')
  xx$ID[i]=id
}

table(xx$Treatment)

# enrollment = haven::read_dta('../Data/InterimEnrolment.dta')
# enrollment = enrollment %>% filter(scrpassed==1, randat<='2022-06-10') %>% mutate(Trt=as_character(rangrp))
# table(enrollment$Trt)
write.csv(x = xx, file = 'ITT_population.csv')

