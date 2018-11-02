


average_gene_size <- function(filename){
  
  con = file(filename, "r")
  
  bp = 0
  gene_numb = 0
  
  while ( length(line = readLines(con, n = 1)) == 0 ) {
    
    if(grepl(">",line)){
      print(line)  
    }

  }
  
  close(con)
  
}
