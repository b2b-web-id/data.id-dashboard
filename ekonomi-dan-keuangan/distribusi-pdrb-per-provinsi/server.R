library(shiny)
library(leaflet)
library(DT)

data <- read.csv(
  "processeddistribusipdrbperprovinsi20042012.csv",
  header=TRUE,
  sep=",")
tahun <- c("Semua Tahun",as.character(unique(data$tahun)))

shinyServer(function(input, output, session) {

  output$tahun <- renderUI({
    selectInput("tahun", "Tahun", tahun)
  })

  output$mymap <- renderLeaflet({
    if(input$tahun == "Semua Tahun") {
      data <- subset(data, tahun == max(data$tahun))
    } else {
      data <- subset(data, tahun == input$tahun)
    }
    outliers <- boxplot(data, plot=FALSE)$out
    data$outliers <- data$kontribusi %in% outliers
    data$color <- ifelse(data$outliers == TRUE, "red", "green")
    data$popup <- paste0(
      "<strong>", data$nama_provinsi,
      "<br>Kontribusi : ", format(data$kontribusi, scientific=FALSE, format="d",
                                  big.mark=".", decimal.mark=","), " %")
    leaflet(data = data) %>%
      addTiles() %>%
      addCircleMarkers(
        ~longitude, ~latitude,
        color=~color,
        stroke=FALSE,
        fillOpacity=0.5,
        popup=~popup)
  })

  output$datapoints <- renderDataTable({
    if(input$tahun == "Semua Tahun") {
      data <- data
    } else {
      data <- subset(data, tahun == input$tahun)
    }
    data <- data[, c('tahun', 'nama_provinsi', 'kontribusi')]
    datatable(data)
  })

})
