#Librairies
install.packages('tm')
install.packages('wordcloud')
install.packages('SnowballC')

library(wordcloud)
library(dplyr) 
library(tm)
library(data.table)
library(glue)
library(SnowballC)


#Loading data
emails = read.csv('emails.csv', stringsAsFactors = FALSE)
emails = emails[1:15] #Suppression des colonnes inutiles

#Initialize list of email types
list = c("dfossum", "pallen" , "cdean" , "dfarmer" , 
         "ebass", "jarnold","fermis","sbeck","jderric",
         "rbadeer","scorman","mcarson2","rbenson","sbaile2")

#Filling missing values
for(i in 1:ncol(emails)){
  if(sapply(emails[,i], is.numeric))
    emails[is.na(emails[,i]), i] = mean(emails[,i], na.rm = TRUE)
}

#Create corpus function 
Transform_to_corpus = function(email) {
  corpus = Corpus(VectorSource(email$content))
  # convert the text to lowercase
  corpus = tm_map(corpus, content_transformer(tolower))
  corpus = tm_map(corpus, PlainTextDocument)
  # remove all punctuation from the corpus
  corpus = tm_map(corpus, removePunctuation)
  # remove numbers
  corpus = tm_map(corpus, removeNumbers)
  # remove all English stopwords from the corpus
  corpus = tm_map(corpus, removeWords, stopwords("en"))
  # remove special_Chars
  specialchars = content_transformer(function(x) gsub("[^[:alnum:]///']"," ", x))
  corpus = tm_map(corpus, specialchars)
  # stem the words in the corpus
  corpus = tm_map(corpus, stemDocument)
}

#Create word count function
Generate_words = function(corpus) {
  dtm = TermDocumentMatrix(corpus)
  m = as.matrix(dtm)
  v = sort(rowSums(m),decreasing=TRUE)
  df = data.frame(Frequence=v)
  df = setDT(df, keep.rownames = "Mot")[]
}

#Groupage des emails par fichier de signature (departement) (14)
#pallen emails / La fonction technique
emailspallen = filter(emails, grepl("^pallen",emails$X.FileName, ignore.case = TRUE))
emailspallen['Function']='Technical'
#jarnold emails / La fonction commerciale
emailsjarnold = filter(emails, grepl("^jarnold",emails$X.FileName, ignore.case = TRUE))
emailsjarnold['Function']='Commercial'
#rbadeer emails / La fonction financi�re
emailsrbadeer = filter(emails, grepl("^rbadeer",emails$X.FileName, ignore.case = TRUE))
emailsrbadeer['Function']='Finantial'
#sbaile2 emails / La fonction de s�curit�
emailssbaile2 = filter(emails, grepl("^sbaile2",emails$X.FileName, ignore.case = TRUE))
emailssbaile2['Function']='Security'
#ebass emails / La fonction de comptabilit�
emailsebass = filter(emails, grepl("^ebass",emails$X.FileName, ignore.case = TRUE))
emailsebass['Function']='Comptability'
#sbeck emails / La fonction administrative
emailssbeck = filter(emails, grepl("^sbeck",emails$X.FileName, ignore.case = TRUE))
emailssbeck['Function']='Administration'
#rbenson emails / La fonction direction et administration g�n�rale
emailsrbenson = filter(emails, grepl("^rbenson",emails$X.FileName, ignore.case = TRUE))
emailsrbenson['Function']='General direction'
#mcarson2 emails / La fonction achat
emailsmcarson2 = filter(emails, grepl("^mcarson2",emails$X.FileName, ignore.case = TRUE))
emailsmcarson2['Function']='Achat'
#scorman emails / La fonction finance et comptabilit�
emailsscorman = filter(emails, grepl("^scorman",emails$X.FileName, ignore.case = TRUE))
emailsscorman['Function']='Finance and compatibility'
#cdean emails / La fonction logistique
emailscdean = filter(emails, grepl("^cdean",emails$X.FileName, ignore.case = TRUE))
emailscdean['Function']='Logistics'
#jderric emails / La fonction marketing et commerciale
emailsjderric = filter(emails, grepl("^jderric",emails$X.FileName, ignore.case = TRUE))
emailsjderric['Function']='Marketing'
#fermis emails / La fonction production
emailsfermis = filter(emails, grepl("^fermis",emails$X.FileName, ignore.case = TRUE))
emailsfermis['Function']='Production'
#dfarmer emails / La fonction recherche et d�veloppement
emailsdfarmer = filter(emails, grepl("^dfarmer",emails$X.FileName, ignore.case = TRUE))
emailsdfarmer['Function']='Search and developpement'
#dfossum emails / La fonction ressources humaines
emailsdfossum = filter(emails, grepl("^dfossum",emails$X.FileName, ignore.case = TRUE))
emailsdfossum['Function']='HR'

#Cleaning data
#Generaion des corpus des emails
for (i in list) {
  a = paste("corpus",i,sep = "")
  b = paste("emails",i,sep = "")
  assign(a,Transform_to_corpus(get(b)))
}  

#Generation des mots/frequences
for (i in list) {
  a = paste("Words",i,sep = "")
  b = paste("corpus",i,sep = "")
  assign(a,Generate_words(get(b)))
}  

#Top 20 words per email
for (i in list) {
    a = paste("Top",i,sep = "")
    b = paste("Words",i,sep = "")
    assign(a,head(get(b),20))}


#Generation des wordcloud
for (i in list) {
  a = paste("Words",i,sep = "")
  wordcloud(words = get(a)$Mot, freq = get(a)$Frequence, min.freq = 5,
            max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
}

#Generation des barplot
for (i in list) {
  a = paste("Top",i,sep = "")
  barplot(get(a)$Frequence,las = 2, names.arg = get(a)$Mot,
        col ="lightblue", main ="Les mots les plus frequents",
        ylab = "Frequence")
}

#Importation des donnees d'apprentissage:
library(readxl)
data = read_excel('Training.xlsx')
data$P <- factor(data$P)

#Generation du train/test:
# Set Seed so that same sample can be reproduced in future also
set.seed(101)
# Now Selecting 80% of data as sample from total 'n' rows of the data  
sample <- sample.int(n = nrow(data), size = floor(.80*nrow(data)), replace = F)
Train <- data[sample, ]
Test  <- data[-sample, ]

#Preparation des donnees:
X_Train = Train[,-ncol(Train)]
Y_Train = Train[,ncol(Train)]
X_Test = Test[,-ncol(Test)]
Y_Test = Test[,ncol(Test)]

write.csv(X_Train,"X_Train.csv", row.names = FALSE)
write.csv(Y_Train,"Y_Train.csv", row.names = FALSE)
write.csv(X_Test,"X_Test.csv", row.names = FALSE)
write.csv(Y_Test,"Y_Test.csv", row.names = FALSE)

#Importation des donnees pour la prediction:
professional <- read_excel("professional.xlsx",col_names = 'content')
nonprofessional <- read_excel("non-professional.xlsx",col_names = 'content')

#Generation des corpus:
corpusp=Transform_to_corpus(professional)
corpusnonp=Transform_to_corpus(nonprofessional)

#Generation des mots/frequences:
wordsp=Generate_words(corpusp)
wordsnonp=Generate_words(corpusnonp)
plot(wordsp$Mot,wordsp$Frequence)
wordcloud(words = wordsnonp$Mot, freq = wordsnonp$Frequence, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

barplot(wordsnonp$Frequence,las = 2, names.arg = wordsnonp$Mot,
        col ="lightblue", main ="Les mots les plus frequents dans l'email non professionnel",
        ylab = "Frequence")

#Definition de la boucle generatrice:
Generate_vectors = function(words){
  
  #Definition de la liste generatrice:
  Liste=c('play','game','volum','farmerhouectect','fossumetsenronenron','mari','bass','fantasi','bid','jim','jame','allenhouect','outag','counterparti','houston','salli','shelley')
  
  i=1
  vec_gen=c()
  while (i <= length(Liste)) {
    for (j in words$Mot) {
      vec_gen[i]=0
      if(tolower(j)==tolower(Liste[i])){
        vec_gen[i]=1
        break
      }
    }
    i = i+1
  }
  return(vec_gen)
}

#Generation des vecteurs de prediction:
vect_p = Generate_vectors(wordsp)
vect_np = Generate_vectors(wordsnonp)

#Sauvegarde des vecteurs pour l'importation sur python:
write.csv(vect_p,"Pro.csv", row.names = FALSE)
write.csv(vect_np,"nonPro.csv", row.names = FALSE)

