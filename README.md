# Demographic estimates from the Facebook Marketing API

Connor Gilroy, University of Washington

This module introduces you to obtaining estimates of populations of Facebook
users stratified by demographic characteristics and geographies. It does this
by accessing the Facebook Marketing API using `httr`.

We use `httr` because there exist no dedicated R packages for the Facebook Ads
API. Existing R packages (`SocialMediaLab`, `RFacebook`) are designed for
retrieving public information from the Facebook Graph API, such as comments on
Facebook Pages.

The activities in this module will allow you to retrieve a novel kind of social
media data that has previously only been accessed using other tools and
languages, such as Python. The module thus illustrates the versatility and
utility of R and `httr` for digital demography.

## Using this module

The easiest way to work with this module is as an "R Project." To do this,
open the folder that you downloaded from Dropbox or Github and click on the
`facebook_ads.Rproj` file (not the .R file!). This will open the R Project
in RStudio, and make it convenient to access all of the files you need.

See this page for more information on R Projects in RStudio:

https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects

For this module, you will need to edit two types of files that your computer
may not have a program set up to open by default: .json (JSON) and .yml (YAML)
files. Unless you are familiar with using text editors to write code, we recommend editing these files directly in RStudio.

If you have already opened the R Project, you can easily access existing
files in the project folder through the "Files" pane of RStudio (which shares
a panel with Plots, Packages, and Help); otherwise, you can open them through
RStudio > File > "Open file...".

## Obtaining Facebook Ads Manager Credentials

The two pieces of information to send with every Facebook Ads API request are
an Ads Account ID and a valid access token.

The authentication process is similar to that for the Twitter API, in that you
create an application and use it to generate an OAuth access token. It is
moderately complex, so follow the instructions carefully.

The overarching steps to accomplish are the following:

- Create a verified Facebook account
- Create a developer app
- Get a Marketing API access token for this app
- Create an Ads Account by starting to create an ad

Detailed instructions, with screenshots, may be found in the included set of slides,
[Obtaining Facebook Ad Manager Credentials](https://github.com/ccgilroy/r-estimates-fb-ads/blob/master/Instructions_to_obtain_FB_Ad_Manager_Credentials.pdf)

Social media platforms frequently make small changes to their developer
platforms, so do not be surprised if you notice some minor differences between
the screenshots in the instructions and your own experience.

Once you have successfully obtained a valid access token and your Ads Account ID,
be sure to store these credentials in the following way:

- Copy your access token and your account id into EXAMPLE_facebook_config.yml; use the format "act_#########" for your account id
- **RENAME** the file to "facebook_config.yml"
