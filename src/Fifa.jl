module Fifa

using Vizagrams, Colors, PlutoUI, CSV, DataFrames, Markdown, InteractiveUtils

export Terrain
export creation_terrain
export Player
export adjust_rating
export find_player_by_name
export Team
export calcul_team_score
export Formation
export creation_formation
export player_input
export find_position_category

# Write your package code here.
include("fonctions.jl")
include("outils.jl")

end
