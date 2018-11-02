

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
