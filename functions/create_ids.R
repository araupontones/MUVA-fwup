#'functions to create IDs
#'
#'@param geo geographical variabel to generate id (provincia, bairro, cidade)
#'@param higher_level higher level of the variable (eg. higher_level of cidade is provincia,
#'higher level of bairro is cidade)




create_lkp <- function(geo,
                       grupo,
                       id_name){
  
  id_tibble <- tibble('{geo}' := grupo,
                      '{id_name}' := seq(1, length(grupo), 1)
  )
  
}


create_ids <- function(.data,
                       geo = "provincia",
                       higher_level = NULL
) {
  
  id_name = glue("ID_{geo}")
  
  if(is.null(higher_level)){
    
    grupo <- sort(unique(.data[[geo]]))
    
    id_tibble <- create_lkp(geo = geo,
                            grupo = grupo,
                            id_name = id_name) 
    
    fetched_id <- .data %>% left_join(id_tibble, by = geo)
    
  } else{
    
    loop_this <- unique(.data[[higher_level]])
    
    
    
    list_ <- lapply(loop_this, function(x){
      
      this_level <- .data[.data[[higher_level]] == x,]
      
      grupo <- sort(unique(this_level[[geo]]))
      
      id_tibble <- create_lkp(geo = geo,
                              grupo = grupo,
                              id_name = id_name) 
      
      fetched_ids <- this_level %>% left_join(id_tibble, by = c(geo)) 
      
      
      
      
    })
    
    fetched_id <- do.call(rbind, list_)
    
    
    
  }
  
  
  
  
  
  
  return(fetched_id)
  
}
