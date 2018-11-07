#!/usr/bin/Rscript

match_id <- function(id,line){
  m <- regexec(pattern,line,perl = T)
  m[[1]][1] != -1
}

is_final_line <- function(line){
  regexec("^\\>",line,perl = T)[[1]][1]!=-1
}

args <- commandArgs(trailingOnly = T)

filename <- args[1]
id <- args[2]
ids_file <- args[3]

ids <- read.table(ids_file,header = F)

if(id %in% as.vector(ids[,1])){
  
  con = file(filename, "r")
  pattern <- paste0("^\\>\\w+\\|(",id,")\\|\\S+\\s(.*)OS=")
  
  seq = c("")
  start = FALSE
  
  while ( length(line <- readLines(con, n=1)) > 0 ) {
    
    if(start){
      if(is_final_line(line)){
        break
      }
      seq = c(seq,paste0(line,"\n")) 
    }
    
    if(match_id(id,line)){
      start=TRUE
    }
    
  }
  
  close(con)
    
}

if(length(seq)!=0){
  cat(seq)
}else{
  cat(paste("The id =",id,"is not in the file!!!"))
}
