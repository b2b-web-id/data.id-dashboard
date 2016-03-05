library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

shinyUI(dashboardPage(

  dashboardHeader(title = "DBH Minyak Bumi"),
  dashboardSidebar(
    uiOutput("tahun"),
    div("home","<a href='http://data-id.b2b.web.id'>Beranda</a>")
  ),
  dashboardBody(
    leafletOutput("mymap"),
    p(),
    dataTableOutput("datapoints")
    )
  )
)
