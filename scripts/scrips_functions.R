
# computing the average gene size
average_gene_size <- function(filename){
  
  con = file(filename, "r")
  
  bp = 0
  gene_numb = 0
  
  while ( length(line <- readLines(con, n = 1)) > 0 ) {
    
    if(grepl(">",line)){
      gene_numb <- gene_numb + 1
      next
    }
        
    bp <- bp + nchar(line)

  }
  
  close(con)
  
  bp/gene_numb
}

read_tsv_genome <- function(filename){
  
  dt <- data.table::data.table()
  dl <- list()
  
  i <- 1
  
  con = file(filename, "r")
  while ( length(line <- readLines(con, n = 1)) > 0) {
    
    # get header
    if(grepl("<.*>",line)){
      h <- stringr::str_match_all(line,"<(.*?)>")[[1]][,2]
      next
    }
      
    # scape comments
    if(grepl("^#",line))
      next
    
    dl[[i]] <- data.table::as.data.table(t(strsplit(line,"\t")[[1]]))
    i <- i + 1
    
  }

  close(con)

  dt <- data.table::rbindlist(dl)

  colnames(dt) <- h

  dt
} 
