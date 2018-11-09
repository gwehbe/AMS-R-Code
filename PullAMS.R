#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Pull data from AMS ---------------------------------------------------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# create pull_ams function
pull_ams <- function(server, site, form, start_date, finish_date, username) {
  
  server_name <- server
  
  site_name   <- site
  
  form_name   <- gsub(" ", "+", form, fixed = TRUE)
  
  start_date  <- start_date
  
  finish_date <- finish_date
  
  username    <- username
  
  password    <- getPass()
  
  domain <- paste0(server_name, ".ausport.gov.au/", site_name, "/externalcsvreports?app=", 
                   site_name, "&formName=", form_name, "&startTime=", start_date, "&finishTime=", finish_date)
  
  url_name <- paste0("https://", username, ":", password, "@", domain)
  
  data <- tryCatch({
    message(paste(form, "data is downloading... "))
    read_csv(url(url_name))
  },
  error = function(err) {
    message(paste(form, "import failed. Please check your details are correct."))
  })
  
  rm(password)
  
  return(data)
}


# create athletes data frame
athlete_data = pull_ams(server = "ams",
                        site = "nswis",
                        form = "NSWIS Scholarship",
                        start_date = "01012015",
                        finish_date = "01092018",
                        username = "george.wehbe")

# create injuries data frame
injury_data = pull_ams(server = "ams",
                       site = "nswis",
                       form = "Injury Record",
                       start_date = "01012016",
                       finish_date = "01092018",
                       username = "george.wehbe")