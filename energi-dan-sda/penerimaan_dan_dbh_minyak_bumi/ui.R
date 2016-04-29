library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

shinyUI(dashboardPage(

  dashboardHeader(title = "DBH Minyak Bumi"),
  dashboardSidebar(
    selectInput("tahun", "Tahun",
      c("Semua Tahun" = "all", "Tahun 2010" = 2010, "Tahun 2011" = 2011)
      )
    ),
  dashboardBody(
    leafletOutput("mymap"),
    p(),
    dataTableOutput("datapoints")
    )
  )
)
