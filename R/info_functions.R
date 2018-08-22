# Info Functions
# Functions which provide information about what
# information can be aquired eg. what markets currently exist and
# what are their ticker symbols.


# Pulls all current markets,
# outputs a list of markets and their ticker symbol
#' Get list of all current markets and their ticker symbol
#'
#' @param agent a note for Predict It staff, indicating who you are and why you're pulling the data
#' @return a data frame containing every current market and their ticker symbol
#' @examples
#' list_of_markets()
#' list_of_market(agent="Jane Doe, pulling data for my senior thesis @ great university")
#' @export
#' @import httr jsonlite
list_of_markets <- function(agent = "predictitr user, no message set") {
    df <- GET("https://www.predictit.org/api/marketdata/all",
              add_headers("Accept:application/json"),
              user_agent(agent))
    df <- fromJSON(content(df, as = "text"))
    return(df[[1]][, 3:4])
}
