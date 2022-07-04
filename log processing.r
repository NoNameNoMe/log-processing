###Please note that you need to change the address of the file in order for the program to work properly.###
###Or put the access.log in the D drive###
logs=read.table("D:\\access.log")
data=as.data.frame(logs)
for(i in 1:dim(data)[1]){data[i,4]=paste(data[i,4],data[i,5])}
data=data[,c(-2,-3,-5)]
names(data)[1]="ip"
names(data)[2]="time"
names(data)[3]="request"
names(data)[4]="status"
names(data)[5]="bytes"
names(data)[6]="referer"
names(data)[7]="user_agent"

t=table(data[1])
t=rev(sort(t))
for(i in 1:10){print(names(t[i]))}

for(i in 1:dim(data)[1]){
  sus=0
  if(grepl("^[^GP]",data[i,3],perl=TRUE)){
    sus=sus+1
  }
  if(grepl("^4..|5..",data[i,4],perl=TRUE)){
    sus=sus+1
  }
  if(grepl("^0",data[i,5],perl=TRUE)){
    sus=sus+1
  }
  if(grepl("^((?!http...trgo).)*$",data[i,6],perl=TRUE)){
    sus=sus+1
  }
  if(grepl("^((?!Mozilla).)*$",data[i,7],perl=TRUE)){
    sus=sus+1
  }
  if(sus>=2){
    print(data[i,1])
  }
}

