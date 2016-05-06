#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(seqinr)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
    # Application title
    titlePanel("Welcome to FASTAcrobat!"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("file", "Choose FASTA file", accept=c('.fasta')),
            selectInput("seqtype", 
                        label=h5("Biological Data"), 
                        choices = list("DNA" = 1, 
                                       "RNA" = 2, 
                                       "Protein" = 3),
                        selected = 3)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h4("To get started, choose a fasta file on the left."),
            plotOutput("distPlot")
        )
    )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
    fasta <- reactive({
        inFile <- input$file
        if(is.null(inFile)){
            return (NULL)
        }
        read.fasta(file = inFile$datapath, seqtype = input$seqtype)
    })
    output$fileTab <- renderTable({
        if(is.null(fasta())){
            return (NULL)
        }
        input$file
    })
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        
    })
})

# Run the application 
shinyApp(ui = ui, server = server)

