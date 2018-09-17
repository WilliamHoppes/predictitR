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

categories<-data.frame(category=c("US-Elections",
                                  "US-Politics",
                                  "World"),
                       number=c(6, 13, 4))

groups<-data.frame(group=c("US-Elections Congressional Primaries",
                           "US-Elections State Primaries",
                           "US-Elections National",
                           "US-Elections State Elections",
                           "US-Elections Senate",
                           "US-Elections House",
                           "US-Elections Ballot Measures",
                           "US-Politics Congress",
                           "US-Politics Investigations",
                           "US-Politics Other Events",
                           "US-Politics Supreme Court",
                           "US-Politics White House",
                           "World Americas",
                           "World Asia/Pacific",
                           "World Europe",
                           "World Mideast & Africa"),
                   number=c(4, 80, 67, 66, 54, 79, 76,
                            38, 84, 45, 39, 83,
                            50, 51, 52, 49))
