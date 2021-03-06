reach_style_barchart<-function(group,percent,error_min=NULL,error_max=NULL,horizontal=T){
  require('extrafont')
  require('ggplot2')
  require("ggthemes")
  require("dplyr")
  require('grid')
  
  percent_formats<-function(x,digits=0){return(paste0(round(x*100,digits),"%"))}
  
  df<-data.frame(group=group,percent=percent,ymin=error_min,ymax=error_max)
  
  colnames(df)<-c('group','percent','ymin','ymax')
  
  theplot<-
    
    ggplot(df)+
    geom_bar(aes(y=1,x=group),
             stat='identity',
             fill=reach_style_color_lightgrey()) +
    geom_bar(aes(y=percent,x=group),
             stat='identity',
             fill=reach_style_color_red()) +
    
    geom_errorbar( aes(x=group,
                       y=percent,
                       ymin=ymin,
                       ymax=ymax),
                   stat='identity',
                   width=0) +
    
    geom_text(aes(x=group, y=(1), label=paste0("  ", round(percent*100),"%"," ",group)),size=4,
              family="Arial Narrow",
              col='#000000',
              hjust=0,
              vjust=0.5) +
    
    theme_tufte()+reachR:::reach_theme() +
    theme(text=element_text(family="Arial Narrow"),
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          plot.margin = unit(x = c(0,0,0,0),'null')) +
    
    scale_y_continuous(labels = percent_formats,limits=c(0,3))
  
  if(horizontal){
    theplot<-theplot+coord_flip()}
  return(theplot)
}




barchart_with_error_bars <- function(hypothesis.test.results,summary.statistics){
  test_name <- hypothesis.test.results$test.parameters[[3]]
  p_value <- hypothesis.test.results$test.results[[2]]
  
  chart <- reach_style_barchart(group = summary.result$names, 
                                percent = summary.result$numbers, 
                                error_min = summary.result$min, 
                                error_max =  summary.result$max)
  
  chart + geom_text(aes(x =4, 
                        y = 2,
                        label= paste0("To determine ", hypothesis.type, "\n", test_name, "\n"
                                      ," returned a p value of ", round(p_value,6))),
                    size=3,
                    family="Arial Narrow",
                    col='#000000',
                    hjust=0,
                    vjust=0.5)
  }



