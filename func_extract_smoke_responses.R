## func_extract_smoke_responses 



func_extract_smoke_responses = function(master.smokelist, my.tree){
  
  my.smokelist = master.smokelist %>% 
    filter(master.smokelist$Species_phylo %in% my.tree$tip.label)
  
  my.smoke_responses =
    setNames(factor(my.smokelist$smoke_resp,
                    levels = c("Response","No_Response" )), 
             rownames(my.smokelist))
  
  my.smoke_responses
}

## sample code

#test.smoke_responses = func_extract_smoke_responses(smokelist_joint_match, tree_test)
