struct Terrain
    largeur:: Int64
    longueur:: Int64
    nb_bandes:: Int64
end

function creation_terrain(terrain::Terrain)
    # La pelouse et la ligne/rond/point central 
    global pelouse = nothing
    for i in (0:terrain.nb_bandes-1)
        if isnothing(pelouse)
            global pelouse = S(:fill => :green)*Rectangle(w=terrain.largeur, h=terrain.longueur/terrain.nb_bandes, c=[0,-terrain.longueur/2+terrain.longueur/(2*terrain.nb_bandes)])
        else
            if (i%2==0)
                global pelouse += S(:fill => colorant"green4")*Rectangle(w=terrain.largeur, h=terrain.longueur/terrain.nb_bandes, c=[0,-terrain.longueur/2+terrain.longueur/(2*terrain.nb_bandes)+terrain.longueur*i/terrain.nb_bandes])
            else
                global pelouse += S(:fill => colorant"green3")*Rectangle(w=terrain.largeur, h=terrain.longueur/terrain.nb_bandes, c=[0,-terrain.longueur/2+terrain.longueur/(2*terrain.nb_bandes)+terrain.longueur*i/terrain.nb_bandes])
            end
        end
    end

    central = S(:stroke => :white, :strokeWidth => 2)*Line([[-terrain.largeur/2, 0], [terrain.largeur/2, 0]]) +
                S(:fillOpacity => 0, :stroke => :white, :strokeWidth => 2)*Vizagrams.Circle(r=9.15) +
                S(:fill => :white)*Vizagrams.Circle(r=0.5) 

    # Les surfaces de reparations, les surfaces de buts et les points de penalty
    global surface = nothing
    for i in [-1,1]
        global surface
        surface_reparation = S(:stroke => :white, :strokeWidth => 2)*Line([[-(40.3/2),-(terrain.longueur/2-16.5)*i],[40.3/2,-(terrain.longueur/2-16.5)*i]]) +
                                S(:stroke => :white, :strokeWidth => 2)*Line([[-40.3/2,-terrain.longueur*i/2],[-40.3/2,-(terrain.longueur/2-16.5)*i]]) +
                                S(:stroke => :white, :strokeWidth => 2)*Line([[40.3/2,-terrain.longueur*i/2],[40.3/2,-(terrain.longueur/2-16.5)*i]]) +
                                S(:fillOpacity => 0, :stroke => :white, :strokeWidth => 2)*Vizagrams.Arc(rx=9.15, ry=9.15, c=[0,-(terrain.longueur/2-11)*i],initangle=pi*i/2-0.93,finalangle=pi*i/2+0.93)
        surface_but = S(:stroke => :white, :strokeWidth => 2)*Line([[-9.1,-(terrain.longueur/2-5.5)*i],[9.1,-(terrain.longueur/2-5.5)*i]]) +
                        S(:stroke => :white, :strokeWidth => 2)*Line([[-9.1,-(terrain.longueur/2)*i],[-9.1,-(terrain.longueur/2-5.5)*i]]) +
                        S(:stroke => :white, :strokeWidth => 2)*Line([[9.1,-(terrain.longueur/2)*i],[9.1,-(terrain.longueur/2-5.5)*i]])
        point_penalty = S(:fill => :white)*Vizagrams.Circle(r=0.5, c=[0, -(terrain.longueur/2-11)*i])   
        if isnothing(surface)
            surface = surface_reparation + surface_but + point_penalty
        else
            surface += surface_reparation + surface_but + point_penalty
        end
    end

    # Les poteaux de corner
    coin = S(:fillOpacity => 0, :stroke => :white, :strokeWidth =>2)*Vizagrams.Arc(rx=1.5, ry=1.5, c=[-terrain.largeur/2,-terrain.longueur/2], initangle=0, finalangle=pi/2) +
            S(:fillOpacity => 0, :stroke => :white, :strokeWidth =>2)*Vizagrams.Arc(rx=1.5, ry=1.5, c=[terrain.largeur/2,-terrain.longueur/2], initangle=pi/2, finalangle=pi) +
            S(:fillOpacity => 0, :stroke => :white, :strokeWidth =>2)*Vizagrams.Arc(rx=1.5, ry=1.5, c=[-terrain.largeur/2,terrain.longueur/2], initangle=-pi/2, finalangle=2*pi) +
            S(:fillOpacity => 0, :stroke => :white, :strokeWidth =>2)*Vizagrams.Arc(rx=1.5, ry=1.5, c=[terrain.largeur/2,terrain.longueur/2], initangle=pi, finalangle=-pi/2)

    # Limite du terrain
    limitation = S(:fillOpacity => 0, :stroke => :white)*Rectangle(w=terrain.largeur, h=terrain.longueur)

    # Dessiner le terrain entier
    terrain =  pelouse + central + surface + coin + limitation

    return terrain

end


struct Player
	name::String
    initial_rating::Float64
    preferred_position::String
    current_position::String
end

function adjust_rating(player::Player)
    preferred_category = find_position_category(player.preferred_position)
    current_category = find_position_category(player.current_position)

    if contains(player.preferred_position, player.current_position)
        # No adjustment if in the exact same position
        return player.initial_rating
    elseif preferred_category == current_category
        # Slight penalty if in a related position (same category)
        return player.initial_rating * 0.9
    else
        # Significant penalty if playing in a completely different category
        return player.initial_rating * 0.6
    end
end

function find_player_by_name(name::String, list_players::Vector{Player})
    for player in list_players
        if cmp(player.name,name ) == 0
            return player 
        end
    end
    print("Player not found")
end


struct Team 
    name::String
    player::Vector{Player}   #Create a vecter of type Player
end

function calcul_team_score(team::Team)
    rate = [adjust_rating(i) for i in team.player]
    return sum(rate)/length(rate)
end

function calcul_team_score(team::Team)
    rate = [adjust_rating(i) for i in team.player]
    return sum(rate)/length(rate)
end


struct Formation
    nom:: Int64
    postes:: Vector{String}
end

function creation_formation(form::Formation, side::Int64, team::Team)
	i=0
	if side==1
		i=1; col=:blue
	elseif side==2
		i=-1; col=:red
	else
		end
	
    players = S(:fill => col)*Rectangle(w=4, h=4, c=dict_postes["GK"].coordonnees*i) + S(:fill => :black)*TextMark(text=team.player[1].name,fontsize=3, pos=dict_postes["GK"].coordonnees*i + i*[0,5]) + S(:fill => :white)*TextMark(text=1,fontsize=3, pos=dict_postes["GK"].coordonnees*i)
    num = 2
    for j in form.postes
        rect = S(:fill => col)*Rectangle(w=4, h=4, c=dict_postes[j].coordonnees*i)
        text = S(:fill => :black)*TextMark(text=team.player[num].name,fontsize=3, pos=dict_postes[j].coordonnees*i + i*[0, -5]) + S(:fill => :white)*TextMark(text=num,fontsize=3, pos=dict_postes[j].coordonnees*i)
        players += rect + text
        num+=1
    end
    return players
end


function Vizagrams.draw(terr::Terrain, h::Int64, form1::Formation, team1::Team, form2::Formation, team2::Team)
    draw(creation_terrain(terr) + creation_formation(form1, 1, team1) + creation_formation(form2, 2, team2), height=h)
end


function player_input()
	
	return PlutoUI.combine() do Child
		
		inputs = [
			md""" $(name): $(
				Child(name, Select(data.short_name[1:100]))
			)"""
			
			for name in ["P1","P2","P3","P4","P5","P6","P7","P8","P9","P10","P11"]
		]
		
		md"""
		$(inputs)
		"""
	end
end

function find_position_category(position::String)
    for (category, positions) in POSITION_GROUPS
        for i in 1:length(positions)
            if contains(position, positions[i])
                return category
            end
        end
    end
    return "Unknown"
end