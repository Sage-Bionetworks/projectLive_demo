# Module UI

#' @title   mod_about_page_ui and mod_about_page_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_about_page
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' 

mod_about_page_ui <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(disable = T),
      shinydashboard::dashboardSidebar(disable = T),
      shinydashboard::dashboardBody(
        shiny::fluidPage(
          #add analytics
          #         tags$head(includeScript("<!-- Global site tag (gtag.js) - Google Analytics -->
          # <script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-160814003-1\"></script>
          # <script>
          #   window.dataLayer = window.dataLayer || [];
          #   function gtag(){dataLayer.push(arguments);}
          #   gtag('js', new Date());
          # 
          #   gtag('config', 'UA-160814003-1');
          # </script>
          # "),
          #includeScript("www/google_analytics.js")),
          shinydashboard::infoBoxOutput(ns('about'), width = 12),
          shinydashboard::box(
            title = "Funding Partner",
            width = 12,
            solidHeader = T,
            status = "primary",
            shiny::textOutput(ns('group'))
          ),
          shinydashboard::box(
            title = "Overview",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            collapsible = FALSE,
            flexdashboard::gaugeOutput(ns('plt1'), 
                                         width = "100%",
                                         height = "200px"))
            
        ))))
}
    
# Module Server
    
#' @rdname mod_about_page
#' @export
#' @keywords internal
    
mod_about_page_server <- function(input, output, session, syn, data_config){
  
  ns <- session$ns
  
  current_user_synapse_id <- shiny::reactive({
    # code to get the synapse id of the current user here
    user <- syn$getUserProfile()[['ownerId']]
    return(user)
  })
  
  output$about <- shinydashboard::renderInfoBox({
    
    shinydashboard::infoBox(
      " ",
      print("projectLive: Track the progress and impact of your funding initiatives in real time"),
      icon = shiny::icon("university", "fa-1x"),
      color = "light-blue", #Valid colors are: red, yellow, aqua, blue, light-blue, green, navy, teal, olive, lime, orange, fuchsia, purple, maroon, black.
      fill = TRUE
    )
  })
  
  output$group <- shiny::renderText({
    txt <- "Navigate to the tabs at the top of the page to get more information about the participating investigators and the various resources that they have generated."
    waiter::waiter_hide()
    txt
  })
  
  data <- shiny::reactive({
    shiny::req(syn, data_config)
    tables <- data_config %>%
      purrr::pluck("data_files") %>%
      purrr::map_chr("synapse_id") %>%
      purrr::map(read_rds_file_from_synapse, syn) %>%
      purrr::map(format_date_columns)
    list(
      "tables" = tables
    ) 
  })
  
   output$plt1 <- flexdashboard::renderGauge({
     flexdashboard::gauge(70, min = 0, max = 100, 
                          symbol = '%', 
                          label = paste("Data Deposited"),
                          flexdashboard::gaugeSectors(success = c(61, 100), 
                                                      warning = c(21,60), 
                                                      danger = c(0, 20), 
                                                      colors = c("success", 
                                                                 "warning", 
                                                                 "danger")
     ))

  })

}
    
## To be copied in the UI
# mod_about_page_ui("about_page_ui_1")
    
## To be copied in the server
# callModule(mod_about_page_server, "about_page_ui_1")
 
