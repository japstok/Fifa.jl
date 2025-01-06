data = CSV.read("data/players_22.csv", DataFrame)

list_players = [Player(row.short_name, row.overall, row.player_positions," ") for row in eachrow(data)]

terrain = Terrain(90, 120, 16)

dict_postes = Dict{String, Position}(
    "GK" => Position("GK", [0, -(terrain.longueur/2-3)]),
    "LB" => Position("LB", [-(terrain.largeur/2-10), -(2*(terrain.longueur/2-6)/3+3)]),
    "CB" => Position("CB", [0, -(2*(terrain.longueur/2-6)/3+3)]),
    "LCB" => Position("CB", [-(terrain.largeur/2-10-(terrain.largeur-20)/3), -(2*(terrain.longueur/2-6)/3+3)]),
    "RCB" => Position("CB", [terrain.largeur/2-10-(terrain.largeur-20)/3, -(2*(terrain.longueur/2-6)/3+3)]),
    "RB" => Position("RB", [terrain.largeur/2-10, -(2*(terrain.longueur/2-6)/3+3)]),
    "CM" => Position("CM", [0, -((terrain.longueur/2-6)/3+3)]),
	"CDM" => Position("CDM", [0, -((terrain.longueur/2-6)/3+3)-(-((terrain.longueur/2-6)/3+3)+2*(terrain.longueur/2-6)/3+3)/2]),
    "LCDM" => Position("CDM", [-(terrain.largeur/2-10-(terrain.largeur-20)/3), -((terrain.longueur/2-6)/3+3)-(-((terrain.longueur/2-6)/3+3)+(2*(terrain.longueur/2-6)/3+3))/2]),
    "RCDM" => Position("CDM", [terrain.largeur/2-10-(terrain.largeur-20)/3, -((terrain.longueur/2-6)/3+3)-(-((terrain.longueur/2-6)/3+3)+(2*(terrain.longueur/2-6)/3+3))/2]),
    "CAM" => Position("CAM", [0, -((terrain.longueur/2-6)/3+3)+(-((terrain.longueur/2-6)/3+3)+(2*(terrain.longueur/2-6)/3+3))/2]),
    "LWB" => Position("LWB", [-(terrain.largeur/2-10), -((terrain.longueur/2-6)/3+3)-(-((terrain.longueur/2-6)/3+3)+2*(terrain.longueur/2-6)/3+3)/2]),
    "RWB" => Position("RWB", [terrain.largeur/2-10, -((terrain.longueur/2-6)/3+3)-(-((terrain.longueur/2-6)/3+3)+2*(terrain.longueur/2-6)/3+3)/2]),
    "LCM" => Position("CM", [-(terrain.largeur/2-10-(terrain.largeur-20)/3), -((terrain.longueur/2-6)/3+3)]),
    "RCM" => Position("CM", [terrain.largeur/2-10-(terrain.largeur-20)/3, -((terrain.longueur/2-6)/3+3)]),
    "LM" => Position("LM", [-(terrain.largeur/2-10), -((terrain.longueur/2-6)/3+3)]),
    "RM" => Position("RM", [terrain.largeur/2-10, -((terrain.longueur/2-6)/3+3)]),
    "LW" => Position("LW", [-(terrain.largeur/2-10), -((terrain.longueur/2-6)/3+3)+(-((terrain.longueur/2-6)/3+3)+(2*(terrain.longueur/2-6)/3+3))/2]),
    "RW" => Position("RW", [terrain.largeur/2-10, -((terrain.longueur/2-6)/3+3)+(-((terrain.longueur/2-6)/3+3)+(2*(terrain.longueur/2-6)/3+3))/2]),
    "CF" => Position("CF", [0, -3]),
    "ST" => Position("ST", [0,-3]),
    "LCF" => Position("CF", [-(terrain.largeur/2-10-(terrain.largeur-20)/3), -3]),
    "RCF" => Position("CF", [terrain.largeur/2-10-(terrain.largeur-20)/3, -3])
)

dict_formations = Dict{Int64, Formation}(
    :0 => Formation(0, ["LB", "LCB", "CB", "RCB", "RB", "LWB", "RWB", "CDM", "LCM", "CM", "RCM", "CAM", "LM", "RM", "LW", "RW", "LCF", "RCF", "ST"]),
    :442 => Formation(442, ["LB", "LCB", "RCB", "RB", "LM", "LCM", "RCM", "RM", "LCF", "RCF"]),
    :433 => Formation(433, ["LB", "LCB", "RCB", "RB", "CDM", "LCM", "RCM", "LW", "RW", "ST"]),
    :4231 => Formation(4231, ["LB", "LCB", "RCB", "RB", "LCM", "RCM", "CAM", "LW", "RW", "ST"]),
	:111 => Formation(111,["CM", "RCM", "CAM", "LM", "RM", "LW", "RW", "LCF", "RCF", "ST"]),
	:222 => Formation(000, ["LB", "LCB", "CB", "RCB", "RB", "LWB", "RWB", "CDM", "LCM", "CM"])
)

const POSITION_CATEGORIES = Dict(
	    "GK" => "Goalkeeper",
	    # Defensive positions
	    "LB" => "Left Back",
	    "CB" => "Center Back",
	    "RB" => "Right Back",
	    "LWB" => "Left Wing Back",
	    "RWB" => "Right Wing Back",
	    # Midfield positions
	    "CDM" => "Central Defensive Midfield",
	    "CM" => "Central Midfield",
	    "CAM" => "Central Attacking Midfield",
	    "LM" => "Left Midfield",
	    "RM" => "Right Midfield",
	    # Forward positions
	    "LW" => "Left Wing",
	    "RW" => "Right Wing",
	    "ST" => "Striker",
	    "CF" => "Center Forward"
)

const POSITION_GROUPS = Dict(
	    "Goalkeeper" => ["GK"],
	    "Defense" => ["LB", "CB", "RB", "LWB", "RWB"],
	    "Midfield" => ["CDM", "CM", "CAM", "LM", "RM"],
	    "Forward" => ["LW", "RW", "ST", "CF"]
)
