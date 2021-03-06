
### The Data Profiler Function 
#   The aim of the function is to profile a simple data quality check 
#   on an object it is given. 

#   First a message is printed describing the structure of the object 
#   inputted and its dimensions.

#   Next a table is built describing the data quality, each row relates 
#   to a column in object inputted.

#   Table Definitions:

#   column        | definition
#   --------------------------------
#   column_name   | Column position and name, if no name is present "NULL" is 
#                 | returned.
#   obj_structure | Assesses how the object is structured, returns: vector, factor,
#                 | list, character, matrix, array or unknown.
#   obj_data_type | Assesses the type of data, returns: numeric, string, logical or 
#                 | date.
#   uniqueness    | Returns a percentage score calculated from the number of distinct
#                 | elements divided by the total number of elements.
#   completeness  | Returns a percentage score calculated from the number of non-blank,
#                 | non-empty and non-null elements divided by the total number of 
#                 | elements.
#   min           | The minimum value, if string data type this is the minimum 
#                 | character length.
#   max           | The maxiumum value, if string data type this is the maxiumum 
#                 | character length.
#   avg           | The average value, if string data type this is the average 
#                 | character length.
#   standDev      | The standard deviation value, if string data type this is the  
#                 | standard deviation of character length.



profile <- function(test_obj){
  # What object have I got?
  if (is.vector(test_obj)){
    obj_structure <- "vector"
    message <- paste0("Object is a vector of length ",length(test_obj))
  }
  else if (is.data.frame(test_obj)){
    obj_structure <- "data.frame"
    message <- paste0("Object is a data frame, ",ncol(test_obj)," columns by ",nrow(test_obj)," rows")
  }
  else if (is.factor(test_obj)){
    obj_structure <- "factor"
    message <- paste0("Object is a factor of length ",length(test_obj))
  }
  else if (is.character(test_obj)){
    obj_structure <- "character"
    message <- paste0("Object is a character of length ",length(test_obj))
  }
  else if (is.list(test_obj)){
    obj_structure <- "list"
    message <- paste0("Object is a list of length ",length(test_obj))
  }
  else if (is.matrix(test_obj)){
    obj_structure <- "matrix"
    message <- paste0("Object is a matrix, ",ncol(test_obj)," columns by ",nrow(test_obj)," rows")
  }
  else if (is.array(test_obj)){
    obj_structure <- "array"
    message <- paste0("Object is an array, with dimensions ",(paste(shQuote(dim(test_array), type="sh"), collapse = ",")))
  }
  else {
    obj_structure <- "unknown"
    message <- "Unknown object"
  }
  print(message)
  # pass for one dimensional objects
  if (is.element(obj_structure,c("vector","factor","list")) == TRUE){
    # Data type
    if (is.numeric(test_obj)){
      obj_data_type <- "numeric"
    }
    else if (is.logical(test_obj)){
      obj_data_type <- "logical"
    }
    else if (class(test_obj) == "Date"){
      obj_data_type <- "date"
    }
    else {
      obj_data_type <- "string"
    }
    uniqueness <- paste0(round((length(unique(test_obj))/length(test_obj))*100,2),"%")
    blanks <- sum(
      length(which("" == test_obj)),
      length(which("[[:space]]" == test_obj)),
      length(which(is.na(test_obj)))
    )
    completeness <- paste0(round(((length(test_obj)-blanks)/length(test_obj))*100,2),"%")
    if (obj_data_type != "string") {
      max <- max(test_obj)
      min <- min(test_obj)
      avg <- round(mean(test_obj),2)
      standDev <- round(sd(test_obj),2)
    }
    
    else if (obj_data_type == "string") {
      max <- max(nchar(as.vector(test_obj)))
      min <- min(nchar(as.vector(test_obj)))
      avg <- round(mean(nchar(as.vector(test_obj))),2)
      standDev <- round(sd(nchar(as.vector(test_obj))),2)
    }
    col_name <- names(test_obj)
    if (length(col_name) == 0) {
      col_name <-"NULL"
    }
    column_name <- paste0("Column ",1,": (",col_name,")")
    output <- cbind(column_name,obj_structure,obj_data_type,uniqueness,completeness,min,max,avg,standDev)
    print(output)
    
  }
  #pass for multi-dimensional objects
  else {
    for (i in 1:ncol(test_obj)){
      if (is.vector(test_obj[[i]])){
        obj_structure <- "vector"
      }
      else if (is.data.frame(test_obj[[i]])){
        obj_structure <- "data.frame"
      }
      else if (is.factor(test_obj[[i]])){
        obj_structure <- "factor"
      }
      else if (is.character(test_obj[[i]])){
        obj_structure <- "character"
      }
      else if (is.list(test_obj[[i]])){
        obj_structure <- "list"
      }
      else if (is.data.frame(test_obj[[i]])){
        obj_structure <- "data.frame"
      }
      else if (is.matrix(test_obj[[i]])){
        obj_structure <- "matrix"
      }
      else if (is.array(test_obj[[i]])){
        obj_structure <- "array"
      }
      else {
        obj_structure <- "unknown"
      }
      if (is.numeric(test_obj[[i]])){
        obj_data_type <- "numeric"
      }
      else if (is.logical(test_obj[[i]])){
        obj_data_type <- "logical"
      }
      else if (class(test_obj[[i]]) == "Date"){
        obj_data_type <- "date"
      }
      else {
        obj_data_type <- "string"
      }
      uniqueness <- paste0(round((length(unique(test_obj[[i]]))/length(test_obj[[i]]))*100,2),"%")
      blanks <- sum(
        length(which("" == test_obj[[i]])),
        length(which("[[:space]]" == test_obj[[i]])),
        length(which(is.na(test_obj[[i]])))
      )
      completeness <- paste0(round(((length(test_obj[[i]])-blanks)/length(test_obj[[i]]))*100,2),"%")
      if (obj_data_type != "string") {
        max <- max(test_obj[[i]])
        min <- min(test_obj[[i]])
        avg <- round(mean(test_obj[[i]]),2)
        standDev <- round(sd(test_obj[[i]]),2)
      }
      
      else if (obj_data_type == "string") {
        max <- max(nchar(as.vector(test_obj[[i]])))
        min <- min(nchar(as.vector(test_obj[[i]])))
        avg <- round(mean(nchar(as.vector(test_obj[[i]]))),2)
        standDev <- round(sd(nchar(as.vector(test_obj[[i]]))),2)
      }
      col_name <- names(test_obj[i])
      if (length(col_name) == 0) {
        col_name <-"NULL"
      }
      column_name <- paste0("Column ",i,": (",col_name,")")
      output_i <- cbind(column_name,obj_structure,obj_data_type,uniqueness,completeness,min,max,avg,standDev)
      if (i == 1){
        output <- output_i
      }
      else {
        output <- rbind(output,output_i)
      }
      
    }
    print(output)
  }
}


