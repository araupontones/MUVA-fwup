Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore

@araupontones 
araupontones
/
  UCPH-moz
Private
Code
Issues
Pull requests
Actions
Projects
Security
Insights
Settings
UCPH-moz/5.R/preparation/0_functions.R
@araupontones
araupontones functions to download and clean data
Latest commit 0922ea4 on Sep 30, 2020
History
1 contributor
105 lines (65 sloc)  2.43 KB

### create functions used for data carpintery




## TO GET LABELS FROM STATA FACTORS -------------------------------------------------------------------------------
fn_to_label = function(x){
  
  att = attributes(x)
  
  x = factor(x,
             levels = att$labels,
             labels = names(att$labels))
  
  
}


# TO EXPORT TAB DELIMITED FILES FOR CASCADING COMBO BOX (following template from survey solutions) ---------

fn_export_tabs = function(db, Value, Title, Parent, file, ...) {
  
  db %>%
    group_by(get(Value)) %>%
    slice(1) %>% 
    ungroup() %>%
    arrange(Value) %>%
    select(Value, Title, Parent) %>%
    #export tab separated file (no header names)
    write.table(file.path(dir_CAPI_tabs, file)
                ,sep = "\t",
                col.names = F, row.names = F)
  
}


# TO CREATE NAMES AS NUMBERS FOR USING IN SURVEY SOLUTIONS -------


fn_split_numbers = function(db, name, prefix, ...){
  
  nameNumeric = sapply(asc(name, simplify = T), function(x)paste(unlist(x), collapse = ''))
  
  # get longest name
  longest_name =  max(nchar(nameNumeric))
  
  ## numero de variables a crear
  num_vars = seq(1, longest_name, 8)
  
  # Crear nombre de variables
  var_names = paste0(prefix, seq(1,length(num_vars)))
  
  # Crear variables
  vars = map(num_vars, function(x){
    
    #Split the number in separate variables
    t = substr(nameNumeric, x, x+7)
    
    return(t)
  })
  
  # bind all new variables together
  numeros = as.data.frame(do.call(cbind,vars))
  names(numeros) <- var_names
  
  # bind with reference data
  new_db = cbind(db, numeros)
  
  
}


# EXPORT TABS WITH NAME NUMERICS

fn_export_nameNumeric = function(db,id , prefix, exfile, ...) {
  db %>% 
    select(id, starts_with(prefix))%>%
    rename(rowcode = id) %>%
    write.table(file.path(dir_CAPI_lookups,exfile), sep = "\t",
                col.names = T, row.names = F)
}

# TO EXPORT LOOKUP TABLES AT THE ROSTER LEVEL


#Vars: vars to keep in export file
#exfile: prefix of text file to be exported
fn_export_lkp_roster= function(vars, exfile){
  
  #1:3 because the sample is divided in 3 to fit survey solutions limits
  sapply(1:3, function(x){
    
    exfile = paste0(exfile, x, ".txt")
    
    data_reference_roster %>%
      filter(lkp==x) %>%
      rename(rowcode = memId) %>%
      select(rowcode, starts_with(vars)) %>%
      write.table(file.path(dir_CAPI_lookups, exfile), sep = "\t",
                  col.names = T, row.names = F)
    
  })
  
}

© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
Loading complete