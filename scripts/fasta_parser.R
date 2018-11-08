#!/usr/bin/Rscript

# Identifying the ID
match_id <- function(id,line){
  length(grep(id,line,perl = T)) > 0 # P61769 0m13.083s
  # !is.na(stringi::stri_match_first(line,regex = id)[,1]) # 	P61769 0m18.483s
  # regexec(paste0("^\\>\\w+\\|",id,"\\|"),line,perl = T)[[1]][1] != -1 # P61769	0m24.317s
}

# Identifying the last line of the sequence
is_final_line <- function(line){
  regexec("^\\>",line,perl = T)[[1]][1]!=-1
}

args <- commandArgs(trailingOnly = T)

if(length(args) <= 1){
  stop("It is necessary the fasta file and a ID to search the sequence.")
}

filename <- args[1] # fasta file with the sequences
id <- args[2] # ID to looking for in fasta file 

if(is.na(args[3])){
  ids_filter <- "ids_get_by_vogelstein.txt" # Filter: only ids in this file is allow to search
}else{
  ids_filter <- args[3]
}

if(file.exists(ids_filter)){
  ids <- read.table(ids_filter,header = F)
}else{
  stop("The file ",ids_filter," was not found")  
}

seq = list() # performance
i = 1;
if(id %in% as.vector(ids[,1])){
  
  con = file(filename, "r")
  
  start = FALSE
  
  while ( length(line <- readLines(con, n=1)) > 0 ) {
    
    if(start){
      if(is_final_line(line)){
        break
      }
      seq[[i]] <- line
      i = i + 1
      next # dont need more validate the ID
    }
    
    if(match_id(id,line)) start <- TRUE
    
  }
  
  close(con)
    
}

seq <- unlist(seq)

if(length(seq) > 1){
  cat(paste(seq,collapse = "\n"))
  cat("\n")
}else{
  cat(paste("The id =",id,"is not into the ids allowed.\n"))
}
