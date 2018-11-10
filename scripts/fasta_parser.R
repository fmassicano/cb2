#!/usr/bin/Rscript

# Identifying the ID
match_id <- function(id,line){
  m <- regexec("^\\>\\w+\\|(\\S+)\\|",line,perl = T)
  
  if(m[[1]][1]==-1)
    return(FALSE)
  
  s <- regmatches(line, m)
  
  return(s[[1]][2] %in% id)
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

con = file(filename, "r")
seq = list() # performance
i = 1

start = FALSE

if(file.exists("./parse.log")) unlink(x = "parse.log")

while (length(line <- readLines(con, n = 1)) > 0) {
  
  if (start) {
    if (is_final_line(line)) {
      # check if the final contain the next id
      if (match_id(ids_to_looking_for, line)){
        cat(file = "parse.log", paste(line,"\n"),append = T)
        start <- TRUE
      }else{
        start <- FALSE
        next        
      }
    }
    seq[[i]] <- line
    i = i + 1
    next
  }
  
  # check the next id
  if (match_id(ids_to_looking_for, line)){
    cat(file = "parse.log", paste(line,"\n"),append = T)
    start <- TRUE
    seq[[i]] <- line
    i = i + 1
  }
    
}

close(con)

seq <- unlist(seq)

if (length(seq) > 1) {
  cat(paste(seq, collapse = "\n"))
}
