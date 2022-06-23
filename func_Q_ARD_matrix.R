## func_Q_ARD_matrix

Q_ARD_matrix = function(my.tree, my.trait){
  
  fitARD = fitMk(my.tree, my.trait, model = "ARD")
  
  Q_ARD = matrix(NA, length(fitARD$states),
                 length(fitARD$states))
  
  Q_ARD[] <- c(0, fitARD$rates)[fitARD$index.matrix + 1]
  
  diag(Q_ARD) <- 0
  diag(Q_ARD) <- -rowSums(Q_ARD)
  
  colnames(Q_ARD) <- rownames(Q_ARD) <- fitARD$states
  
  Q_ARD
} 

## sample
#test.Q_ARD = Q_ARD_matrix(tree_test, test.smoke_responses)
