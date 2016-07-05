
library(dplyr)

Promille <- function(milliliter, procent, bodyWeight, id_sex){
  pro <- ((milliliter * (procent/100))*0.7873) / (bodyWeight*id_sex)
  return(pro)
}

Hours <- function(milliliter, procent, bodyWeight, legalPro, id_sex){
  massAlco <- (milliliter * (procent/100))*0.7873
  atLegal <- legalPro*bodyWeight*id_sex*0.7873
  hours <- (((massAlco-atLegal)/(bodyWeight*id_sex))/0.15)-0.707
  if (hours <= 0){
    hours <- "Now...gogog!"
  }
return(hours)
}

Kazaak <- function(milliliter, procent, bodyWeight, id_sex){     #milliliter, procent, bodyWeight, id_sex
  #output <- data.frame(matrix(nrow = 20))
  tmp <- data.frame(0:20)
  colnames(tmp) <- "Hours"
  tmp$BW <- bodyWeight
  tmp$PRO <- ((milliliter * (procent/100))*0.7873) / (bodyWeight*id_sex)
  tmp$DEG <- tmp$Hours*0.15
  tmp$Permille <- tmp$PRO - tmp$DEG
  output <-filter(tmp, Permille > 0)
  return(output)

}

library(ggplot2)


library(shiny)
shinyServer(
  function(input, output){
    output$o_Status <- renderPrint({Promille(input$id_Liter, input$id_Procent,input$id_BW, as.numeric(input$id_sex))})
    output$o_Hours <- renderPrint({Hours(input$id_Liter, input$id_Procent,input$id_BW, input$id_Promille, as.numeric(input$id_sex))})
    output$o_Grams <- renderPrint({((input$id_Liter *(input$id_Procent/100))*0.7873)/12})
    output$distPlot <- renderPlot({ dist <- Kazaak(input$id_Liter, input$id_Procent, input$id_BW, as.numeric(input$id_sex))
                                    ggplot(dist, aes(x= Hours, y = Permille))+
                                      geom_line() +
                                      geom_hline(aes(yintercept = input$id_Promille), colour= "#990000", linetype = "dashed")+
                                      ggtitle("Permille hours after the last beverage/drink")})
    }
)
