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
ids_to_looking_for <- read.table(args[2],header = F) # IDs to looking for in fasta file | "ids_get_by_vogelstein.txt"

ids_to_looking_for <- as.vector(ids_to_looking_for[,1])

for(id in ids_to_looking_for){
  
  con = file(filename, "r")
  seq = list() # performance
  i = 1;
  
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

  seq <- unlist(seq)
  
  if(length(seq) > 1){
    cat(paste(id,"\n"))
    cat(paste(seq,collapse = "\n"))
    cat("\n")
  }
  
}


