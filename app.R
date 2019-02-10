# This is a Shiny web application. Created as a supplement to our Scientific
# Reports paper. The repository is hosted online on the domain indicated in
# the manuscript. 

# Authors:
# Hamidreza Ahady Dolatsara
# Tessa Chen
# Fadel Megahed


#_________________________________________________________________________
############ Load Packages and User-Defined Functions into R#############
source("Functions.R") # A File Contains Non Standard/packaged Functions
packages <- c("shiny", "shinydashboard","shinyLP","shinyBS") # Packages used in our application
ipak(packages) # Loading + installing the packages using ipak from Functions.R
#________________________________________________________________________


################ Creating the User Interface for the App #################
ui <- dashboardPage( # Function from Shiny Dashboard
  # App header and its Contents Including the Help Menu
  dashboardHeader(title = "Survival Predictor",
                  dropdownMenu(# Produces ? Icon on Right + its contents
                    type = "notifications", 
                    icon = icon("question-circle"),
                    badgeStatus = NULL,
                    headerText = "See also:",
                    notificationItem("Data Dictionary", icon = icon("file"),
                                     href = "https://www.srtr.org/requesting-srtr-data/saf-data-dictionary/"),
                    notificationItem("Request UNOS Data", icon = icon("file"),
                                     href = "https://optn.transplant.hrsa.gov/data/request-data/")
                  )),
  
  # App Pages as shown on the SideBar
  dashboardSidebar(sidebarMenu(
        menuItem(HTML("<font size = \"5px\">  Home Page </font>"), tabName = "home", icon = icon("home")),
        menuItem(HTML("<font size = \"5px\">  Manual Entry </font>"), tabName = "manual", icon = icon("heart")),
        menuItem(HTML("<font size = \"5px\">  CSV Entry </font>"), tabName = "automated", icon = icon("heartbeat")),
        menuItem(HTML("<font size = \"5px\">  Source Code </font>"), tabName = "code", icon = icon("laptop-code")),
        menuItem(HTML("<font size = \"5px\">  About Us </font>"), tabName = "about", icon = icon("users"))
  )
  ),
  
  # Contents of Each Page
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    tabItems(
      
      # Home Page Contents Using the ShinyLP Boostrapping Functionality
      tabItem(tabName = "home",
              jumbotron(
                HTML("<h2> <b>Overview </b></h2>"), 
                        HTML("<p class = \"app\">  This web app presents a data-driven approach to 
                              predict heart transplantation survival probabilities 
                              over time. The prediction is soley based on
                              medical information that is available at transplant time, as explained in detail in our 
                              <i> Scientific Reports </i> manuscript. The app presents two modules for performing the analysis:
                              <br> <b> (1) Manual Entry</b>, where 
                              users can insert the values of predictor variables using several text boxes.
                             <br> <b>  (2) CSV Entry</b>, where users can upload the values of predictor variables using a comma seperated variable (CSV) file.
                             <br> These modules can be accessed using the tabs on the side bar to the left.  
                             In addition, one can find more informations about our source code and research teams using the last two tabs at the left. </p>
                              </p>"),
                        buttonLabel = "For an instructional video, click me"),
              fluidRow(
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "App Status", 
                                    content = HTML("<b> Version: </b> 0.1.0.
                                                   <br> <b> Last Updated at </b> February 10, 2019
                                                   <b> by </b> Fadel Megahed.
                                                   <br> <b> Status: </b> No reported outages."))),
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "Application Maintainers",
                                    content = HTML("The maintainers can be contacted via email at: 
                                         <br> <a href='mailto:fmegahed@miamioh.edu?Subject=Heart%20Transplantation%20App%20Help' target='_top'>Tessa Chen</a>
                                         <br> <a href='mailto:ychen4@udayton.edu?Subject=Heart%20Transplantation%20App%20Help' target='_top'>Fadel Megahed</a>"))),
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "Copyrights", 
                                    content = HTML("<p> <b> Data: </b> Protected according to details available
                                                   <a href=\"https://optn.transplant.hrsa.gov/data/request-data/\">here</a>. </p>
                                                   <p> <img height = \" 28\", src=\" http://i.creativecommons.org/p/zero/1.0/88x31.png\"> </img>
                                                                 <style=\"text-align:justify\"> 
                                                   <b> Code and App: </b> CC0 - 'No Rights Reserved' .
                                                   </p>")
                )
                ),
                # Button Functionality
                bsModal("modalExample", "Instructional Video", "tabBut", size = "large" ,
                        HTML("<p> We should create a youtube video that walks users on how to use our app.
                             <br> The video should play in Chrome Browswer. 
                             <br> We should make Christy record the video. 
                             <br> Below is an example of how to embed a video in the app. </p>"),
                        iframe(width = "560", height = "315", url_link = "https://www.youtube.com/embed/0fKg7e37bQE")
                )
                
              )
      ),
      
      # Manual Entry Page
      tabItem(tabName = "manual",
              fluidRow(
                column(4,
                       sidebarLayout(
                         sidebarPanel(width = 12, id="sidebar",
                                      HTML("<p.h> <b> <font size=\"4px\">  Donor Characteristics </font> </b> </p>"),
                                      numericInput(inputId="p1", label="Var 1", value = 10, min = 0, max = 100),
                                      numericInput(inputId="p2", label="Var 2", value = 10, min = 1, max = 100)
                         ),
                         mainPanel( width = 0)
                       )
                ),
                column(4,sidebarLayout(
                  sidebarPanel(width = 12, id="sidebar2",
                               HTML("<p.h> <b> <font size=\"4px\">  Patient Characteristics </font> </b> </p>"),
                               selectInput("waist",
                                           "Choose your size:",
                                           choices = c("XS","S","M","L","XL")),
                               radioButtons("sex",
                                            "sex:",
                                            choices = c("unisex","women's"))
                  ),
                  mainPanel( width = 0)
                ) ),
                column(4,
                       sidebarLayout(
                         sidebarPanel(width = 12, id="sidebar",
                                      HTML("<p.h> <b> <font size=\"4px\">  Other Characteristics </font> </b> </p>"),
                                      NumericInputRow(inputId="o1", label="Var 1: Long Name", value = 10, min = 0, max = 100),
                                      NumericInputRow(inputId="o2", label="Var 2: Long Name", value = 10, min = 1, max = 100),
                                      NumericInputRow(inputId="o3", label="Var 3: Long Name", value = 10, min = 0, max = 100),
                                      NumericInputRow(inputId="o4", label="Var 4: Long Name", value = 10, min = 1, max = 100),
                                      NumericInputRow(inputId="o5", label="Var 5", value = 10, min = 0, max = 100),
                                      NumericInputRow(inputId="o6", label="Var 6: Long Name", value = 10, min = 1, max = 100)
                         ),
                         mainPanel( width = 0)
                       )
                )
                
      )
      )
      
      
      
    ) # For Tab Items
  ) # For Dashboard Body
) # For Dashboard Page

server <- function(input, output) { }

# Run the application
shinyApp(ui, server)