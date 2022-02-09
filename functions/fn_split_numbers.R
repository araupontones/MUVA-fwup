#'@param db data set of sample
#'@param name name of the variable to split
#'@param prefix prefix of the output variables


fn_split_numbers = function(db, name, prefix, ...){
  
 nameNumeric = sapply(gtools::asc(name, simplify = T), function(x)paste(unlist(x), collapse = ''))
 
  #
  #
  # get longest name
  longest_name =  max(nchar(nameNumeric))

  ## numero de variables a crear
  num_vars = seq(1, longest_name, 8)

  # Crear nombre de variables
  var_names = paste0(prefix, seq(1,length(num_vars)))

  # Crear variables
  vars = purrr::map(num_vars, function(x){

    #Split the number in separate variables
    t = substr(nameNumeric, x, x+7)

    #s = ifelse(str_length(t) == 2 , paste0("0",t) ~ t)

    return(t)
  })

  # bind all new variables together
  numeros = as.data.frame(do.call(cbind,vars))
  names(numeros) <- var_names

  # bind with reference data
  new_db = cbind(db, numeros)
  
  
}
