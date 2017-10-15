#' ---
#' title: "Retrieving data through APIs"
#' author: "Connor Gilroy"
#' date: "`r Sys.Date()`"
#' output: 
#'   beamer_presentation: 
#'     theme: "metropolis"
#'     latex_engine: xelatex
#'     # fig_caption: false
#'     highlight: pygments
#'     df_print: kable
#' ---
#' 

# Packages
library(httr)
library(jsonlite)
library(stringr)
library(tidyverse)
library(yaml)

# Setup: config and url

# We need two pieces of information from the config file:
# an access token, and an ads account.
# Make sure the ads account number is prefixed with "act_".
fb_cfg <- yaml.load_file("facebook_config.yml")

# The url for accessing 'reach' estimates is based off of the ads account, 
# so we construct it by pasting strings onto the base url
fb_url <- "https://graph.facebook.com/v2.10"
fb_ads_url <- str_c(fb_url, fb_cfg$ad_account_id, "reachestimate", sep = "/")

# Example 1: US population on Facebook
targeting_spec <- '{"geo_locations": {"countries": ["US"]}}'

fb_query <- list(
  access_token = fb_cfg$access_token, 
  currency = "USD", 
  optimize_for = "NONE", 
  targeting_spec = targeting_spec
)

r <- GET(fb_ads_url, query = fb_query)

# Example 2: Young men and women in Washington State
# How many men and women are there on Facebook in the state of Washington, 
# between the ages of 20 and 30?

ts1 <- read_file("targeting_specs/targeting_spec_01.json")
ts2 <- read_file("targeting_specs/targeting_spec_02.json")

make_fb_ads_request <- function(ts) {
  # Avoid rate limiting! 
  # Don't make too many requests in a short period of time.
  Sys.sleep(5)
  
  fb_query <- list(
    access_token = fb_cfg$access_token, 
    currency = "USD", 
    optimize_for = "NONE", 
    targeting_spec = minify(ts)
  )
  
  GET(fb_ads_url, query = fb_query)
} 

r1 <- make_fb_ads_request(ts1)
r2 <- make_fb_ads_request(ts2)

# Data processing
# We need to combine the request inforomation from the targeting spec
# with the estimated number of users from the response

process_fb_response <- function(ts, r) {
  # targeting spec
  ts_df <- 
    fromJSON(ts) %>%
    as_data_frame() %>%
    unnest(geo_locations)
  
  # response
  r_df <- 
    content(r, as = "parsed")$data %>%
    as_data_frame() %>%
    select(users)
  
  bind_cols(ts_df, r_df)
}

bind_rows(
  process_fb_response(ts1, r1),
  process_fb_response(ts2, r2)
)

# Exercise:
# Pick 3 other countries and report the number of Facebook users in each
# (Compare to world bank populations?)
# Use two-digit country codes: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

# Exercise: 
# Pick another US state and age range, and compare the numbers of men and women.
# You can look up the key that Facebook uses for each state in the file provided.

# Challenge exercise: 
# Get the Facebook user population for each US state
# Compare these estimates to population estimates from the American Community Survey
# Note that you'll need to make a separate call to the API for each state, 
# which will take several minutes.
