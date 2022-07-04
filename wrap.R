######## run this wrapper scripts
######## this script will automatically load needed source.

# prep and load everything + general all species figure
source("scripts/4_Part0_lib_dat_prep.R")

######## calculation for all species

## phylogenetic signal
source("scripts/Part1_PhySig.R")
## ancestral state reconstruction
source("scripts/Part2_AncestralState.R")

######## subtree calculation
cols = c("blue", "red")
names(cols) = levels(smoke_responses_joint)

## Asteraceae Clade

 spp1 = "Trichocline_spathulata"
 spp2 = "Liatris_pycnostachya"

master.tree =  tree_joint_match
master.smokelist = smokelist_joint_match

subtree = extract_subtree(spp1, spp2, master.tree)

subtree_analysis("Trichocline_spathulata","Liatris_pycnostachya", tree_joint_match, smokelist_joint_match)



## Ericaceae Clade
# spp1 = "Woollsia_pungens"
# spp2 = "Leucopogon_capitellatus"

# master.tree =  tree_joint_match
# master.smokelist = smokelist_joint_match
subtree_analysis("Woollsia_pungens", "Leucopogon_capitellatus", tree_joint_match, smokelist_joint_match)
