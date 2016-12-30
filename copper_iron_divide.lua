-- copper_iron_divide.lua
-- Dec 2016
-- Code specific to this scenario

require("config")
require("locale/oarc_utils")

-- Create silo
local function CreateSilo()
    local silo = game.surfaces["nauvis"].create_entity{name = "rocket-silo", position = {0, 0}, force = MAIN_TEAM}
    silo.destructible = false
    silo.minable = false
end

--------------------------------------------------------------------------------
-- Init this globals and other stuff
--------------------------------------------------------------------------------
function InitSpawnGlobalsAndForces()

    -- These are the team spawn locations
    if (global.teamSpawns == nil) then
        global.teamSpawns = {}
        global.teamSpawns[TEAM_COPPER] = TEAM_COPPER_SPAWN_POS
        global.teamSpawns[TEAM_IRON] = TEAM_IRON_SPAWN_POS
    end

    -- This global is used by RSO to make sure no enemies spawn near these areas.
    -- It should be identical to the team spawns.
    if (global.uniqueSpawns == nil) then
        global.uniqueSpawns = {}
        global.uniqueSpawns[TEAM_COPPER] = TEAM_COPPER_SPAWN_POS
        global.uniqueSpawns[TEAM_IRON] = TEAM_IRON_SPAWN_POS
    end

    -- This tracks which team each player is assigned to
    if (global.playerTeam == nil) then
        global.playerTeam = {}
    end

    -- Global for tracking which team has launched. Used by  win condition code.
    if (global.satellite_sent == nil) then
        global.satellite_sent = {}
        global.satellite_sent[TEAM_COPPER] = 0
        global.satellite_sent[TEAM_IRON] = 0
    end

    -- Create the forces
    local copper_force = game.create_force(TEAM_COPPER)
    local iron_force = game.create_force(TEAM_IRON)
    local main_force = game.create_force(MAIN_TEAM)
    copper_force.set_spawn_position(TEAM_COPPER_SPAWN_POS, "nauvis")
    iron_force.set_spawn_position(TEAM_IRON_SPAWN_POS, "nauvis")
    main_force.set_spawn_position({x=0,y=0}, "nauvis")

    -- Make sure forces are neutral
    SetCeaseFireBetweenAllForces()

    -- Chart the team spawn areas so that new players and teams can at least
    -- see where the team starting locations are
    ChartArea(main_force, TEAM_COPPER_SPAWN_POS, 4)
    ChartArea(main_force, TEAM_IRON_SPAWN_POS, 4)
    ChartArea(copper_force, TEAM_COPPER_SPAWN_POS, 4)
    ChartArea(copper_force, TEAM_IRON_SPAWN_POS, 4)
    ChartArea(iron_force, TEAM_COPPER_SPAWN_POS, 4)
    ChartArea(iron_force, TEAM_IRON_SPAWN_POS, 4)
end

local function CreateWall(pos)
    local wall = game.surfaces["nauvis"].create_entity({name="stone-wall", position=pos, force=MAIN_TEAM})
    if wall then
        wall.destructible = false
        wall.minable = false
    end
end

-- Create the divide area
local function CreateDivideArea(surface, chunkArea)
    if ((chunkArea.left_top.x == -32) or (chunkArea.left_top.x == 0)) then

        -- Remove stuff
        RemoveAliensInArea(surface, chunkArea)
        RemoveInArea(surface, chunkArea, "tree")
        RemoveInArea(surface, chunkArea, "resource")

        -- This loop runs through each tile
        local grassTiles = {}
        for i=chunkArea.left_top.x,chunkArea.right_bottom.x,1 do
            for j=chunkArea.left_top.y,chunkArea.right_bottom.y,1 do

                -- Fill all area with grass only
                table.insert(grassTiles, {name = "grass", position ={i,j}})

                -- Create the spawn box walls
                if (j<15 and j>-16) then

                    -- Create horizontal sides of center spawn box
                    if (((j>-16 and j<-12) or (j<15 and j>11)) and (i<15 and i>-16)) then
                        CreateWall({i,j})
                    end

                    -- Create vertical sides of center spawn box
                    if ((i>-16 and i<-12) or (i<15 and i>11)) then
                        CreateWall({i,j})
                    end

                -- Create the long vertical wall
                elseif (( i > -3) and ( i < 2 )) then
                    CreateWall({i,j})
                end
                
            end
        end
        surface.set_tiles(grassTiles)
    end
end

-- Set the resource division
local function DivideResourcesGeneration(surface, chunkArea)
    if (chunkArea.left_top.x < 0) then
        for key, entity in pairs(surface.find_entities_filtered({area=chunkArea, type= "resource"})) do
            if (entity.name == "iron-ore") then
                entity.destroy()
            end
        end
    elseif (chunkArea.left_top.x > 0) then
        for key, entity in pairs(surface.find_entities_filtered({area=chunkArea, type= "resource"})) do
            if (entity.name == "copper-ore") then
                entity.destroy()
            end
        end
    end
end

       

--------------------------------------------------------------------------------
-- Generate Chunk Event
-- This does the bulk of the work of creating this scenario
-- It modified the resource layout of the map, creates the wall, and creates
-- the team spawn areas
--------------------------------------------------------------------------------
function TeamSpawnsGenerateChunk(event)
    local surface = event.surface
    local chunkArea = event.area

    -- Create the divide area
    CreateDivideArea(surface, chunkArea)

    -- Set the resources
    DivideResourcesGeneration(surface, chunkArea)

    -- Create the team spawn points
    CreateSpawnAreas(surface, chunkArea, global.teamSpawns)
end


--------------------------------------------------------------------------------
-- Player joins a team for the first time
--------------------------------------------------------------------------------
function StartAssignPlayerToTeam(player)

    -- Find which team has a lower number of players
    local team = GetTeamWithFewerPlayers()

    global.playerTeam[player.name] = team
    player.force = game.forces[team]

    GivePlayerStarterItems(player)

    player.teleport(global.teamSpawns[team])

    SendBroadcastMsg(player.name .. " joined " .. team)
end

--------------------------------------------------------------------------------
-- Find the team with fewer players and return the force
--------------------------------------------------------------------------------
function GetTeamWithFewerPlayers()
    local iron_team_count = 0
    local copper_team_count = 0

    for index, player in pairs(game.connected_players) do
        if (global.playerTeam[player.name] == TEAM_IRON) then
            iron_team_count = iron_team_count + 1
        elseif (global.playerTeam[player.name] == TEAM_COPPER) then
            copper_team_count = copper_team_count + 1
        end
    end

    -- Preference goes to iron team
    if (iron_team_count > copper_team_count) then
        return TEAM_COPPER
    else
        return TEAM_IRON
    end
end

--------------------------------------------------------------------------------
-- Handle Player Created
--------------------------------------------------------------------------------
function TeamSpawnsPlayerCreated(event)
    local player = game.players[event.player_index]
    DisplayWelcomeTextGui(player)
    player.teleport({0,0})
    player.force = MAIN_TEAM
end


--------------------------------------------------------------------------------
-- Handle respawn event
--------------------------------------------------------------------------------
function TeamSpawnsPlayerRespawned(event)

    local player = game.players[event.player_index]

    player.teleport(global.teamSpawns[global.playerTeam[player.name]])

end


--------------------------------------------------------------------------------
-- Handle player left event
--------------------------------------------------------------------------------
function TeamSpawnsPlayerLeft(event)

end


--------------------------------------------------------------------------------
-- Rocket Launch Event Code
-- Controls the "win condition"
-- The way to win is both teams must launch at least 1 rocket
--------------------------------------------------------------------------------
function RocketLaunchEvent(event)
    local force = event.rocket.force

    if event.rocket.get_item_count("satellite") == 0 then
        for index, player in pairs(force.players) do
            player.print("You launched the rocket, but you didn't put a satellite inside.")
        end
        return
    end

    if not global.satellite_sent then
        global.satellite_sent = {}
    end

    if global.satellite_sent[force.name] then
        global.satellite_sent[force.name] = global.satellite_sent[force.name] + 1   
    else
        global.satellite_sent[force.name] = 1
    end

    -- Only show win condition once
    if (global.satellite_sent[TEAM_IRON] == 1) and (global.satellite_sent[TEAM_COPPER] >= 1) then
        game.set_game_state{game_finished=true, player_won=true, can_continue=true}
    elseif (global.satellite_sent[TEAM_COPPER] == 1) and (global.satellite_sent[TEAM_IRON] >= 1) then
        game.set_game_state{game_finished=true, player_won=true, can_continue=true}
    end
   
end
