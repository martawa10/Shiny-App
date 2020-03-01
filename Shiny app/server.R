library(shiny)
library(ggplot2)
library(lattice)
library(GGally)
library(reshape2)


# czesc obliczeniowa
shinyServer(function(input, output) {
  
  
  # wczytywanie danych 
  dataIn <- reactive({
    inFile <- input$fileInPath
    
    if (is.null(inFile)) {
      return(NULL)
    }
    read.table(file=inFile$datapath,sep=";",dec=",",header=T,stringsAsFactors=FALSE)
  })
  
  # wypisyanie danych 
  output$daneIn <- renderTable({
    ret <- rbind(
      head(dataIn(),5),
      tail(dataIn(),5)
    )
    
    return(ret)
    
  },include.rownames=FALSE)


  # Wykres ggplot    
  output$gg_plot <- renderPlot({
    
    input$goButton
    
    if (input$goButton == 0) {
      return()
      
    } else {
      
    d <- dataIn()
    meltd = melt(d, id = 'ID')
    
    wyk <- (
      ggplot(meltd,aes(x=ID, y=value, colour = variable)) 
      + geom_point() 
      + xlab("") + ylab("Value")
    ) 
  
      return(wyk)
    }
  })
  
  
  # Macierz
  output$macierz <-renderPlot({
    
    input$goButton
    
    if (input$goButton2 == 0) {
      return()
      
    } else {
      
    d <- dataIn()
    wyk2 <- ggcorr(d[, -1], palette = "RdGy", label = TRUE, label_size = 3, label_color = "white")
  return(wyk2)
    
  }
    })
  
   Macierz2 <- function(){
    d <- dataIn()
    wyk2 <- ggcorr(d[, -1], palette = "RdGy", label = TRUE, label_size = 3, label_color = "white")
    print(wyk2)
  }
  
  
  # Download
  
  output$downloadPlot <- downloadHandler(
    filename = function() { 
      paste0("plot",".png") 
    },
    content = function(file) {
      png(file)
      d <- dataIn()
      meltd = melt(d, id = 'ID')
      wyk <- (
        ggplot(meltd,aes(x=ID, y=value, colour = variable)) 
        + geom_point() 
        + xlab("") + ylab("Value"))
      print(wyk)
      dev.off()
    }
  )
  
   
  output$Macierz <- downloadHandler(
    filename = function() { 
      paste0("macierz.png",sep='') 
    },
    content = function(file) {
      png(file)
      Macierz2()
      dev.off()
    }
  )
  
  
  
})
