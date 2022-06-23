######## run this wrapper scripts
######## this script will automatically load needed source.

# prep and load everything + general all species figure
source("scripts/4_Part0_lib_dat_prep.R")

######## calculation for all species

## phylogenetic signal
source("scripts/Part1_PhyloSig.R")
## ancestral state reconstruction
source("scripts/Part2_AncestralState")

######## subtree calculation
subtree_analysis("Trichocline_spathulata","Liatris_pycnostachya", tree_joint_match, smokelist_joint_match )

subtree_analysis("Woollsia_pungens", "Leucopogon_capitellatus", tree_joint_match, smokelist_joint_match )
