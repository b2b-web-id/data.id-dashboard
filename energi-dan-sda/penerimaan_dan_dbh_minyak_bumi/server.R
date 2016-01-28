library(shiny)
library(leaflet)
library(DT)

data <- read.csv(
  "processeddanabagihasilminyakbumiperkkkskabupaten20102011.csv",
  header=TRUE,
  sep=",")
data$color <- ifelse(data$penerimaan_sda > 1000000000000,"red","green")
data$popup <- paste0(
  "<strong>", data$nama_provinsi,
  ", ", data$nama_kabkota,
  "</strong><br>", data$kkks,
  ", ", data$jenis_minyak,
  "<br> Tahun : ", data$tahun,
  "<br>Penerimaan SDA : ", format(data$penerimaan_sda,
                                       scientific=FALSE, format="d", big.mark=".", decimal.mark=","),
  "<br>DBH Provinsi : ", format(data$dbh_prov,
                                     scientific=FALSE, format="d", big.mark=".", decimal.mark=","),
  "<br>DBH Penghasil : ", format(data$dbh_penghasil,
                                      scientific=FALSE, format="d", big.mark=".", decimal.mark=","),
  "<br>DBH Pemerataan : ", format(data$dbh_pemerataan,
                                       scientific=FALSE, format="d", big.mark=".", decimal.mark=","))

shinyServer(function(input, output, session) {

  output$mymap <- renderLeaflet({
    if(input$tahun == 2010) {
      data <- subset(data, tahun == 2010)
    } else if(input$tahun == 2011) {
      data <- subset(data, tahun == 2011)
    }
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
    if(input$tahun == 2010) {
      data <- subset(data, tahun == 2010)
    } else if(input$tahun == 2011) {
      data <- subset(data, tahun == 2011)
    }
    data <- data[, c('tahun', 'nama_provinsi', 'nama_kabkota', 'kkks',
                     'jenis_minyak', 'penerimaan_sda', 'dbh_prov',
                     'dbh_penghasil', 'dbh_pemerataan')]
    datatable(data)
    })
})
