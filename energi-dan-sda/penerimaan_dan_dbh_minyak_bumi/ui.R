library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

shinyUI(dashboardPage(

  dashboardHeader(title = "DBH Minyak Bumi"),
  dashboardSidebar(
    uiOutput("tahun")
  ),
  dashboardBody(
    leafletOutput("mymap"),
    p(),
    dataTableOutput("datapoints")
    )
  )
)
