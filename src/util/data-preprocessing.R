#' Load the data from the prepared csv sheet and ensure that all categorical
#' variables are properly cast as factors.
load.data <- function() {
  # load the data from the disc
  d <- read.csv(file="../../data/rqi-data.csv")
  
  # determine the values of the categorical variables
  categories.degree <- c("High-School", "Bachelor's degree", "Master's degree")#, "Ph.D.")
  categories.domain.knowledge.os <- 1:5
  categories.domain.knowledge.db <- 2:5
  categories.occurrence <- c("None", "Rarely", "From time to time", "Often")
  #categories.roles <- c("role.RE", "role.PO", "role.Arch", "role.Dev", "role.Test", 
  #                      "role.QA", "role.Edu", "role.MGT", "role.none")
  categories.roles <- c("role.RE", "role.Arch", "role.Dev", "role.MGT", "role.none")
  
  # cast the categorical variables to factors such that they are recognized properly
  d <- d %>% 
    mutate(
      RQ = factor(RQ, levels=0:3, ordered=FALSE),
      edu = factor(edu, levels=categories.degree, ordered=TRUE),
      dom.os = factor(dom.os, levels=categories.domain.knowledge.os, ordered=TRUE),
      dom.db = factor(dom.db, levels=categories.domain.knowledge.db, ordered=TRUE),
      model.occ = factor(model.occ, levels=categories.occurrence, ordered=TRUE),
      tool = factor(tool, levels=categories.occurrence, ordered=TRUE),
      
      primary.role = factor(primary.role, levels=categories.roles, ordered=FALSE)
    )
  
  return(d)
}

#' Assemble a data frame, which contains one observation for each participant and 
#' each requirement, such that the response variable outcome is now represented in
#' a paired manner, i.e., the two values associated to the two treatments are located
#' in adjacent columns.
#' 
#' @param data A data frame
#' @param treatment A value between 1 and 3 depending on the treatment to compare to the baseline
#' @param outcome The response variable of interest (must be contained in data)
assemble.paired <- function(data, treatment, outcome) {
  return(d %>% 
           select(PID, RQ, all_of(outcome)) %>%
           filter(RQ %in% c(0, treatment)) %>% 
           reshape(idvar=c("PID"), timevar="RQ", direction="wide") %>%
           rename(all_of(c(baseline = paste(outcome, 0, sep="."),
                           treatment = paste(outcome, treatment, sep="."))))
  )
}