library(shiny)
library(DT)
library(shinydashboard)
library(shinyjs)

shinyUI(fluidPage(
  title="MeMoRe",
  verticalLayout(
    useShinyjs(),

    tags$head(
      tags$style(
        type="text/css",
        "h2 {display: inline;}",
        "h4 {display: inline;}",
        "[id^='combined_'] img {max-width: 100%; height: auto;}",
        "[id='download_button'] {display: inline;}",
        "[id='app_version'] {display: inline; font-size:90%; position:absolute; bottom:0px;}",
        "ul[class^='nav'] [data-value$='_SMRT'] { background-color: #FFF; color: #D21F3B; border-color: #F8F8F8; border-bottom-color: #DDDDDD; padding:4px; font-size:90%;}",
        "ul[class^='nav'] [data-value$='_ONT'] { background-color: #FFF; color: #005D75; border-color: #F8F8F8; border-bottom-color: #DDDDDD; padding:4px; font-size:90%;}"
      ),
      tags$link(rel="shortcut icon", href="https://raw.githubusercontent.com/fanglab/MeMoRe/master/docs/_static/MeMoRe.favicon_96.png?raw=true")
    ),

    div(
      # titlePanel("MeMoRe"),
      HTML('<img src="https://raw.githubusercontent.com/fanglab/MeMoRe/master/docs/_static/MeMoRe.logo.png?raw=true" alt="MeMoRe.logo" height="50" width="149"/>'),
      HTML('&nbsp;'),
      uiOutput("app_version"),
      shiny::actionButton('helpb', label="", icon=icon("info"), onclick="window.open('https://memore.readthedocs.io/en/latest/overview.html', '_blank')", style='font-size:80%; position:absolute; top:15px; right:15px;'),
      style='padding-bottom:2px'
    ),

    wellPanel(
      id="input_panel",

      div(
        h4("Inputs"),
        actionButton("input_toggle", label="Hide", style='padding:4px; font-size:80%; margin-bottom:0.4em'),
        style='margin-top:-0em; margin-bottom:-0.6em'
      ),

      fluidRow(
        id="input_subpanel",
        column(
          10,
          column(
            4,
            fileInput('modfile', 'Modifications (.csv.gz, .h5, .RDS)', accept=c('.gz', '.h5', '.RDS')),
            style='padding-bottom:0px; margin-top:0.4em; margin-bottom:-3em'
          ),
          column(
            4,
            fileInput('genfile', 'Genome (.fa, .fasta)', accept=c('.fa', '.fasta')),
            style='padding-bottom:0px; margin-top:0.4em; margin-bottom:-3em'
          ),
          column(
            4,
            fileInput('motfile', 'Motif summary (.csv, .tsv)', accept=c('.csv', '.tsv')),
            style='padding-bottom:0px; margin-top:0.4em; margin-bottom:-3em'
          ),
        style="margin-bottom:0.6em"
        ),
        column(
          2,
          actionButton("ont_test", label="Test ONT", style="font-size:80%; padding:4px"),
          actionButton("smrt_test", label="Test SMRT", style="font-size:80%; padding:4px"),
          style='padding-bottom:0px; margin-top:2.4em; margin-bottom:0em'
        ),
        style="margin-bottom:0.6em"
      ),
      style="padding-top:4px; padding-bottom:8px; padding-left:8px; padding-right:8px; margin-bottom:0.4em"
    ),

    wellPanel(
      id="motif_panel",
      
      div(
        h4("Motif summary"),
        actionButton("motif_toggle", label="Hide", style='padding:4px; font-size:80%; margin-bottom:0.4em'), style='margin-top:-0em; margin-bottom:-0.6em'
      ),

      fluidRow(
        id="motif_subpanel",
        column(
          8, 
          uiOutput('motifs')
        ),
        column(
          4, align="center",
          # h5("Adding motif"),
          div(
            style="display: inline-block; vertical-align:top; width: 180px; text-align: left; margin-top: 0.6em",
            textInput(inputId="motif", label="Motif", placeholder="GATC")
          ),
          div(
            style="display: inline-block; vertical-align:top; width: 100px; text-align: left; margin-top: 0.6em",
            textInput(inputId="center", label="Modified pos.", placeholder="2")
          ),
          br(),
          actionButton("addmotif", "Add motif"), 
          actionButton("cleartable", "Clear table"),
          br(),br(),
          verbatimTextOutput("list_selected_motifs"),
          br(),
          actionButton("submit", "Process selected motifs", style = "color: white; background-color: #337AB7"),
          br(),br(),
          actionButton("submit_all", "Process all motifs", style = "color: white; background-color: #337AB7")      
        )
      ),
      style="padding-top:4px; padding-bottom:8px; padding-left:8px; padding-right:8px;"
    )
  ),

  div(h4("Generated plots"), HTML('&nbsp;'), uiOutput("download_button"), style="margin-left:0.7em"),
  tabsetPanel(id="render_results", type="tabs")
))
