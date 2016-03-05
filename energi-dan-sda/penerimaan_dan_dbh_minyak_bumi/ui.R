library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

shinyUI(dashboardPage(

  dashboardHeader(title = "DBH Minyak Bumi"),
  dashboardSidebar(
    selectInput("tahun", "Tahun",
      c("Semua Tahun" = "all", "Tahun 2010" = 2010, "Tahun 2011" = 2011)
      ),
    div("home","<a href='http://data-id.b2b.web.id'>Beranda</a>")
    ),
  dashboardBody(
    leafletOutput("mymap"),
    p(),
    dataTableOutput("datapoints")
    )
  )
)
