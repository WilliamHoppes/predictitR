# Download Functions
# Functions which pull data from the API to the R session

#pulls data from Predict It api.
#' Pull data from Predict It's API
#'
#' @param category overall categories eg group or ticker
#' @param subcategory specific markets you want to pull, eg 6 for US elections or  USPREZ for 2016 presidential market
#' @param agent a note for Predict It staff, indicating who you are and why you're pulling the data
#' @return a dataframe with market data for each market
#' @examples
#' For US election markets:
#' get_predictit(category="category", subcategory="6")
#'
#' For 2016 election markets:
#' get_predictit("ticker", "USPREZ16")
#'
#' For all markets:
#' get_predictit("all")
#'
#' pull from US Electoral College markets, setting agent properly:
#' get_predictit(category="group", subcategory="75", agent="Jane Doe for research project")
#' @export
#' @import httr jsonlite

get_predictit<-function(category, subcategory="", agent="predictitR user, no message set"){
  category_list<-c("category", "group", "ticker", "all")
  if (!(category %in% category_list)) stop("Please choose a proper category", call.=F)
  url<-paste("https://www.predictit.org/api/marketdata/", category, "/", subcategory, sep="")
  url<-ifelse(category=="all","https://www.predictit.org/api/marketdata/all/", url)
  df<-GET(url,
          add_headers("Accept:application/json"),
          user_agent(agent))
  df<-fromJSON(content(df, as="text"))
  if(category=="ticker"){
    return(as.data.frame(df))
  }else {
    n_markets<-nrow(df[[1]])
    output_df<-df[[1]][[7]][[1]]
    for (i in 2:n_markets){
      output_df<-rbind(output_df, df[[1]][[7]][[i]])
      }
    return(output_df)
  }
}
