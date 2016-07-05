library(shiny)


shinyUI(pageWithSidebar(
  headerPanel("When can I (legally) drive?"),
  sidebarPanel(
    selectInput("id_sex", label = h4("Sex?"),
                choices = list("Female" = 0.60, "Male" = 0.70),
                selected = 1),
    h4('Your body weight'),
    numericInput('id_BW', 'Kg', 50, step = 1),
    h4('How much you have consumed'),
    numericInput('id_Liter', 'Mililiter', 1000, step = 100),
    h4('Enter the alcohol percentage'),
    numericInput('id_Procent', 'Procent',4.6,step = 1),
    h4('Enter, the by law, allowed blood alcohol level'),
    numericInput('id_Promille', 'Permille',0.5,step = 0.1),
        submitButton('Submit'),
    h4('')
    ),
    mainPanel(
      h4('Your blood alcohol level:'),
      verbatimTextOutput("o_Status"),
      h4('Units consumed:'),
      verbatimTextOutput("o_Grams"),
      h4('Hours before you can legally drive:'),
      verbatimTextOutput("o_Hours"),
      plotOutput("distPlot")
))
)
