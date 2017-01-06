-- control.lua
-- Nov 2016

-- Oarc's The Great Divide
-- 
-- I wanted to create a scenario that allows you to spawn in separate locations
-- From there, I ended up adding a bunch of other minor/major features
-- 
-- Credit:
--  RSO mod to RSO author - Orzelek - I contacted him via the forum
--  Tags - Taken from WOGs scenario
--
-- Feel free to re-use anything you want. It would be nice to give me credit
-- if you can.
--
-- Contact: oarcinae@gmail.com, Oarc (steam), @_Oarc (twitter)


-- Generic Utility Includes
require("locale/oarc_utils")
require("locale/rso/rso_control")
require("locale/tag")
require("locale/blueprintstring/bps")

-- Main Configuration File
require("config")

-- Scenario Specific Includes
require("copper_iron_divide_guis")
require("copper_iron_divide")


--------------------------------------------------------------------------------
-- ALL EVENT HANLDERS ARE HERE IN ONE PLACE!
--------------------------------------------------------------------------------


----------------------------------------
-- On Init - only runs once the first 
--   time the game starts
----------------------------------------
script.on_init(function(event)

    -- Configures the map settings for enemies
    -- This controls evolution growth factors and enemy expansion settings.
    ConfigureAlienStartingParams()

    InitSpawnGlobalsAndForces()

    if ENABLE_BLUEPRINT_STRING then
        bps_init()
    end

    global.welcome_msg = WELCOME_MSG
    global.welcome_msg_title = WELCOME_MSG_TITLE
end)


----------------------------------------
-- Special Rocket Launch Condition for this scenario
----------------------------------------
script.on_event(defines.events.on_rocket_launched, function(event)
    RocketLaunchEvent(event)
    UpdateWinConditionGui()
end)


----------------------------------------
-- Chunk Generation
----------------------------------------
script.on_event(defines.events.on_chunk_generated, function(event)
    if ENABLE_UNDECORATOR then
        UndecorateOnChunkGenerate(event)
    end

    if ENABLE_RSO then
        RSO_ChunkGenerated(event)
    end

    -- This MUST come after RSO generation!
    TeamSpawnsGenerateChunk(event)
end)


----------------------------------------
-- Gui Click
----------------------------------------
script.on_event(defines.events.on_gui_click, function(event)
    if ENABLE_TAGS then
        TagGuiClick(event)
    end

    -- These are the different GUI event handlers
    WelcomeTextGuiClick(event)
    SpawnOptsGuiClick(event)
    SpawnCtrlGuiClick(event)
    WinConditionGuiClick(event) 

    if ENABLE_BLUEPRINT_STRING then
        bps_on_gui_click(event)
    end
end)


----------------------------------------
-- Player Events
----------------------------------------
script.on_event(defines.events.on_player_joined_game, function(event)
    
    PlayerJoinedMessages(event)

    if ENABLE_TAGS then
        CreateTagGui(event)
    end

    CreateWinConditionGui(event)
end)

script.on_event(defines.events.on_player_created, function(event)
    SetOarcServerMessages(event)
    
    if ENABLE_LONGREACH then
        GivePlayerLongReach(game.players[event.player_index])
    end

   TeamSpawnsPlayerCreated(event)

    -- Not sure if this should be here or in player joined....
    if ENABLE_BLUEPRINT_STRING then
        bps_player_joined(event)
    end
end)

script.on_event(defines.events.on_player_died, function(event)
    if ENABLE_GRAVESTONE_CHESTS then
        CreateGravestoneChestsOnDeath(event)
    end
end)

script.on_event(defines.events.on_player_respawned, function(event)
    TeamSpawnsPlayerRespawned(event)

    if ENABLE_LONGREACH then
        GivePlayerLongReach(game.players[event.player_index])
    end
end)

script.on_event(defines.events.on_player_left_game, function(event)
    TeamSpawnsPlayerLeft(event)
end)

script.on_event(defines.events.on_built_entity, function(event)
    if ENABLE_AUTOFILL then
        Autofill(event)
    end
end)



----------------------------------------
-- On Research Finished
----------------------------------------
script.on_event(defines.events.on_research_finished, function(event)
    if ENABLE_BLUEPRINT_STRING then
        bps_on_research_finished(event)
    end

    -- Example of how to remove a particular recipe:
    -- RemoveRecipe(event, "beacon")
    -- RemoveRecipe(event, "rocket-silo")
end)


----------------------------------------
-- BPS Specific Event
----------------------------------------
script.on_event(defines.events.on_robot_built_entity, function(event)
    if ENABLE_BLUEPRINT_STRING then
        bps_on_robot_built_entity(event)
    end
end)