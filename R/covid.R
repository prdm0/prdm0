library(rjson)
library(magrittr)
library(shiny)
library(lubridate)


dados_tabela <- function(link) {

  dados <- link %>% 
            fromJSON(file = .)
  
  numero_elementos <- dados$data %>% length
    
  filter <- function(i, x) {
    x$data[[i]] %>% unlist
  }
  
  tabela <- 
    sapply(X = 1L:numero_elementos, FUN = filter, x = dados) %>% 
    t %>% 
    as.data.frame
  
  tabela <- tabela[, -1]
  
  dia <- mday(tabela$datetime)
  mes <- month(tabela$datetime)
  data <- paste0(dia, "/", mes)

  
  letalidade <- (as.numeric(tabela$deaths)/as.numeric(tabela$cases) * 100)  %>% 
                  round(x = ., digits = 2L) 
                  
  tabela[[7L]] <- letalidade
  tabela[[8L]] <- data

  colnames(tabela) <- c("UF", "Estado", "Casos", "Mortes", "Suspeitos", "Recuperados", "Letalidade", "Data")
  tabela
  
}

library(DT)

ui <- basicPage(
  h2("Tabela: COVID-19 por Estados Brasileiros"),
  DT::dataTableOutput("mytable")
)

server <- function(input, output) {
  tabela <- dados_tabela(link = "https://covid19-brazil-api.now.sh/api/report/v1")
  output$mytable = DT::renderDataTable({
    tabela
  })
  
}

shinyApp(ui, server)



