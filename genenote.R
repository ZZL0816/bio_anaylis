path = 'C:/Users/FREEDOM/Desktop/TCGA_data/mainfest'
floders = list.files(path)#�г���Ŀ¼�º����ļ��е�����
BRCA_counts = data.frame()#����dataframe
fd1 = floders[1]#��һ���ļ���
file_name  =list.files(paste(path,'/',fd1,sep =''))#�г��ļ���fd1�е�ȫ���ļ���
file_list = substr(file_name[1],1,28)#�Ե�һ���ļ����������ֽ�ͼ��
mydata = read.table(gzfile(paste(path,'/',fd1,'/',file_name[1],sep = '')))#��ȡ��ѹ��gz�ڲ������ݣ�
names(mydata) <- c('ECSG_ID',file_list)#��ȡ��һ��gz�ļ�֮�󣬰��ļ�������������
BRCA_counts = mydata#��ֵΪBRCA����counts����
for (fd in floders[2:200]){#ѭ����200���ļ����д�����
  files_name = list.files(paste(path,'/',fd,sep = ''))
  print(files_name[1])
  file_list =substr(files_name[1],1,28)
  mydata = read.table(gzfile(paste(path,'/',fd,'/',files_name[1],sep = '')))
  names(mydata) <- c('ECSG_ID',file_list)
  BRCA_counts <- merge(BRCA_counts,mydata,by ='ECSG_ID')#���������ensg��Ž��кϲ���
  
}
write.csv(BRCA_counts,'C:/Users/FREEDOM/Desktop/TCGA_data/BRCA_counts.csv')#������д��csv�ļ��У�
group_text =read.csv(file = 'C:/Users/FREEDOM/Desktop/TCGA_data/group_text1.csv',header = T)
library(biomaRt)
library(curl)
#���л���ע��
new_data <- read.csv(file = 'C:/Users/FREEDOM/Desktop/TCGA_data/BRCA_counts1.csv')
rownames(new_data) <- new_data[,1]
new_data <- new_data[c(-1)]
print(rownames(new_data))
# 
char =substr(rownames(new_data),1,15)
print(char)
rownames(new_data) <- substr(rownames(new_data),1,15)
# 
# 
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))  #����mart
my_ensembl_gene_id<-char #��Ҫת����exsembl�ı��룻
my_ensembl_gene_id
# 
# mms_symbols<- getBM(attributes=c('ensembl_gene_id','hgnc_symbol',"description"),filters = 'ensembl_gene_id',values = my_ensembl_gene_id,mart = mart)#����ע��֮��ı�
# 
# 
ensembl_gen_id <- char
result_diff<-cbind(ensembl_gen_id,new_data)
colnames(new_data)[1]<-c("ensembl_gene_id")
rownames(result_diff) <- NULL
print(colnames(mms_symbols))
print(colnames(result_diff))
colnames(result_diff)[1] <-c("ensembl_gene_id")
colnames(mms_symbols)[1] <- c("ensembl_gene_id")