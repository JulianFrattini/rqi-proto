evaluate.model <- function(model, treatment) {
  
  posterior.draws.baseline <- posterior_predict(
    model, 
    newdata = datagrid(
      model = model,
      RQ = 0
    ))
  
  posterior.draws.treatment <- posterior_predict(
    model, 
    newdata=datagrid(
      model = model,
      RQ = treatment
    ))
  
  diff <- posterior.draws.treatment - posterior.draws.baseline
  tab <- table(sign(diff))
  
  return(tab/sum(tab))
}