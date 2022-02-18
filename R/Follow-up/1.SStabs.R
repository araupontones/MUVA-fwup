

dir_fp_sample <- "C:/repositaries/3.MUVA/MUVA-fwup/data/Follow-up/sample"
infile <- file.path(dir_fp_sample, "sample.rds")
sample <- import(infile)





View(sample)

#load function
source("functions/fn_split_numbers.R")

  # sample %>%
  # select(ID, project) %>%
  # create_ids(geo = "project") %>%
  # group_by(project) %>%
  # slice(1) %>%
  # export(., file.path(db_look_ups,"ID_projects.xlsx"))

# tab file of project numeric numbers ---------------------------------------
numericProject = sample %>%
  select(ID, project) %>%
  create_ids(geo = "project") %>%
  mutate(project = str_to_upper(project)) %>%
  #create name to numbers and split into column 
  mutate(fn_split_numbers(db = . ,project, prefix ="number_" )) %>%
  select(-project,
         rowcode = ID) 
  
write.table(numericProject,file.path(db_look_ups,"namesNumericProject.txt"), sep = "\t",
            col.names = T, row.names = F)

# tab file of participant numeric number --------------------------------------
numericParticipant = sample %>%
  select(ID, participante) %>%
  mutate(participante = iconv(participante, from = 'UTF-8', to = 'ASCII//TRANSLIT')
         ) %>%
  #create name to numbers and split into column 
  mutate(fn_split_numbers(db = . ,participante, prefix ="number_" )) %>%
  select(-participante,
         rowcode = ID) 

View(numericParticipant)
write.table(numericParticipant,file.path(db_look_ups,"namesNumericParticipants.txt"), sep = "\t",
            col.names = T, row.names = F)



