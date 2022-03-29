# Design, deployment and analysis of the MUVA follow up study

Below is a description of the directories, their input, outputs and objectives. For each task, there is an R file with the code and a /data one with its data.

All the data paths are defined in .Rprofile

## Reference

It creates external reference data for the survey. Specifically, it gets the clean name of the provinces, cidades, and bairros of Mozambique. 

Output: data/Reference/cidades.xlsx

## Preparation

It imports the data of participants for each project that the team was able to collect from the ligada historical dropbox. 

R/Preparation/raw imports all the data from dropbox and appends into a single file.
R/Preparation/copy_raw_from_dropbox 

R/Preparation/clean it is a series of scripts that cleans the sample frame (homogenizes the variables accross projects)  


Outputs: (dir_prep_clean, "muva_follow_up_clean.xlsx"), this data was the main input for the zoho creator app to confirm the contact details of the participants.


## Confirmation

This process was implemented to contact all the participants from (dir_prep_clean/"muva_follow_up_clean.xlsx") and confirm their contact details. The output of this excersice was used as the sample for the follow up survey.


Outputs: dir_conf_clean/"confirmation_clean.rds" which was used as the sample for the follow up survey. Only participants for which the contact details were confirmed.


## Follow-UP

It imports the output from the confirmation step, crates lookup tables for survey solution, and executes the QA system of the field work. 

Output: Data for dashboard
Output2: Clean data of the survey "data/Follow-up/2.clean". This data that includes all the field management variables is the input to create the delivery data

## Delivery
Takes the clean data from the survey, keeps only approved cases, and removes management variables

Output: dir_delivery and dropbox/data/data_survey


## Dashboard

The dashboard was programmed in a different repo: https://github.com/araupontones/followUp-Dash

Output: dropbox/04 Data/survey final




