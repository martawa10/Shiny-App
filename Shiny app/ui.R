
# definicja interfejsu 



shinyUI(fluidPage(
  
  tags$img(src="logo.png",  width = 200, heigh = 100),
  
    # 1. Nazwa aplikacji  
    titlePanel("Wizualizacja danych"),

    sidebarLayout(

        sidebarPanel(
            # 2. Przegladarka do pobrania danych 
            fileInput("fileInPath", 
                label= h4("Import danych")
            ),
        
            # rodzaj wykresu 
            
            selectInput("Typ Wykresu",
                        label=("TYP WYKRESU"),c("ggplot","lattice")),
            
            #submit
            actionButton("goButton", "Pokaz wykres"),
            actionButton("goButton2", "Pokaz macierz"),
            
            #brak servera
            sliderInput("wykresslider",
                        "Wartosci Zmiennych os Y:",
                        min = 0,
                        max = 1000,
                        value=c(0,1000),
                        dragRange = TRUE),
            
            sliderInput("Macierzslider",
                        "Macierz korelacji:",
                        min = -1,
                        max = 1,
                        value = c(-1,1),
                        step=0.01,
                        dragRange = TRUE)
          
        ),
        
        mainPanel(

            # 5. zakladki wynikiwe 
            tabsetPanel(type = "tabs",
                
                # 6. wyswietlanie pobranych danych  
                tabPanel("Dane", tableOutput("daneIn")),
                
      
                # 9. wyswietlanie wykresu 
                tabPanel("Wykres", plotOutput("gg_plot"),
                         downloadButton("downloadPlot", label="Eksportuj wynik")),
                
                # Macierz korelacji
                tabPanel("Macierz korelacji", plotOutput("macierz"), 
                         downloadButton("Macierz", label="Eksportuj wynik"))
            
            )
        
             

        )

    )

))
