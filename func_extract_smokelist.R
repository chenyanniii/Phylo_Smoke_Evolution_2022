
## func_extract_smokelist


func_extract_smokelist = function(matster.smokelist, my.tree){
  
  my.smokelist = master.smokelist %>% 
    filter(master.smokelist$Species_phylo %in% my.tree$tip.label)
  
  my.smokelist
}