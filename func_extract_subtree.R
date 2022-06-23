## func_extract_subtree


extract_subtree = function(spp1, spp2, tree){
  ancestral_node = MRCA(tree, c(spp1, spp2))
  subtree = tree_subset(tree, node = ancestral_node, levels_back = 0)
  subtree
}

# sample code
# tree_test = extract_subtree("Conostylis_aculeata", "Serenoa_repens", tree_joint_match)
