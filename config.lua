-- config.lua
-- Dec 2016
-- Configuration Options

--------------------------------------------------------------------------------
-- Useful constants
--------------------------------------------------------------------------------
CHUNK_SIZE = 32

--------------------------------------------------------------------------------
-- Messages
--------------------------------------------------------------------------------

WELCOME_MSG = "[INSERT SERVER OWNER MSG HERE!]"
GAME_MODE_MSG = "In the current game mode, you must work together to launch satellites to win!"
MODULES_ENABLED = "Mods Enabled: Gravestone Chests, Long-Reach, Autofill, Blueprint Strings"

WELCOME_MSG_TITLE = "[INSERT SERVER OWNER MSG HERE!]"
WELCOME_MSG1 = "Rules: Be polite. Ask before changing other players's stuff. Have fun!"
WELCOME_MSG2 = "This server is running a custom scenario."

OTHER_MSG1 = "Latest updates in this scenario version (0.0.1):"
OTHER_MSG2 = "First Release!"


WELCOME_MSG3 = "Due to the way this scenario works, it may take some time for the land"
WELCOME_MSG4 = "around your new spawn area to generate..."
WELCOME_MSG5 = "Please wait for 10-20 seconds when you select your first spawn."
WELCOME_MSG6 = "Contact: SteamID:Oarc | Twitter:@_Oarc_ | oarcinae@gmail.com"


SPAWN_MSG1 = "This is a cooperative game mode scenario, not PvP!"
SPAWN_MSG2 = "In this mode, there are two teams of players. One on each side of the map."
SPAWN_MSG3 = "The left side of the map has copper ore. The right has iron."
SPAWN_MSG4 = "Players cannot cross the wall but can trade resources across it."
SPAWN_MSG5 = "To win, both groups must work together to each launch a satellite."

SPAWN_NOTE1 = "Both groups get some starting resources. Use /s to chat between teams."
SPAWN_NOTE2 = "Join the discord for some extra communication channels :)"
SPAWN_NOTE3 = "discord.gg/Wj56gkU"

-- These are my specific welcome messages that get used only if I am the user
-- that creates the game.
WELCOME_MSG_OARC = "Welcome to Oarc's official server! Join the discord here: discord.gg/Wj56gkU"
WELCOME_MSG_TITLE_OARC = "Welcome to Oarc's Server"


--------------------------------------------------------------------------------
-- Module Enables
-- These enables are not fully tested! For example, disable separate spawns
-- will probably break the frontier rocket silo mode
--------------------------------------------------------------------------------


-- Enable Scenario version of RSO
ENABLE_RSO = false

-- Enable Gravestone Chests
ENABLE_GRAVESTONE_CHESTS = true

-- Enable Undecorator
ENABLE_UNDECORATOR = true

-- Enable Tags
ENABLE_TAGS = true

-- Enable Long Reach
ENABLE_LONGREACH = true

-- Enable Autofill
ENABLE_AUTOFILL = true

-- Enable BPS
ENABLE_BLUEPRINT_STRING = true


--------------------------------------------------------------------------------
-- Main Scenario Options
--------------------------------------------------------------------------------

---------------------------------------
-- Team Options
---------------------------------------
MAIN_TEAM = "Main Force"
TEAM_COPPER = "copper engineers"
TEAM_IRON = "iron engineers"


---------------------------------------
-- Spawn Options
---------------------------------------
SPAWN_DIST_TILES = 8*CHUNK_SIZE + CHUNK_SIZE/2
TEAM_COPPER_SPAWN_POS = {x=-SPAWN_DIST_TILES, y=0}
TEAM_IRON_SPAWN_POS = {x=SPAWN_DIST_TILES, y=0}

                  --
---------------------------------------
-- Starter Resource Options
---------------------------------------
WATER_SPAWN_OFFSET_X = -4
WATER_SPAWN_OFFSET_Y = -38
WATER_SPAWN_LENGTH = 8

-- Start resource amounts
START_IRON_AMOUNT = 1000
START_COPPER_AMOUNT = 1000
START_STONE_AMOUNT = 1000
START_COAL_AMOUNT = 1000
START_OIL_AMOUNT = 30000

-- Start resource shape
-- If this is true, it will be a circle
-- If false, it will be a square
ENABLE_RESOURCE_SHAPE_CIRCLE = true

-- Start resource position and size
-- Position is relative to player starting location
START_RESOURCE_STONE_POS_X = -27
START_RESOURCE_STONE_POS_Y = -34
START_RESOURCE_STONE_SIZE = 12

START_RESOURCE_COAL_POS_X = -27
START_RESOURCE_COAL_POS_Y = -20
START_RESOURCE_COAL_SIZE = 12

START_RESOURCE_COPPER_POS_X = -28
START_RESOURCE_COPPER_POS_Y = -3
START_RESOURCE_COPPER_SIZE = 14

START_RESOURCE_IRON_POS_X = -29
START_RESOURCE_IRON_POS_Y = 16
START_RESOURCE_IRON_SIZE = 16

START_RESOURCE_OIL_POS_X = -39
START_RESOURCE_OIL_POS_Y = 0

-- Force the land area circle at the spawn to be fully grass
ENABLE_SPAWN_FORCE_GRASS = true

---------------------------------------
-- Safe Spawn Area Options
---------------------------------------

-- Safe area has no aliens
-- +/- this in x and y direction
SAFE_AREA_TILE_DIST = CHUNK_SIZE*6

-- Warning area has reduced aliens
-- +/- this in x and y direction
WARNING_AREA_TILE_DIST = CHUNK_SIZE*12

-- 1 : X (spawners alive : spawners destroyed) in this area
WARN_AREA_REDUCTION_RATIO = 10

-- Create a circle of land area for the spawn
ENFORCE_LAND_AREA_TILE_DIST = 48


---------------------------------------
-- Special Action Cooldowns
---------------------------------------
RESPAWN_COOLDOWN_IN_MINUTES = 60
RESPAWN_COOLDOWN_TICKS = TICKS_PER_MINUTE * RESPAWN_COOLDOWN_IN_MINUTES

-- Require playes to be online for at least 5 minutes
-- Else their character is removed and their spawn point is freed up for use
MIN_ONLIME_TIME_IN_MINUTES = 5
MIN_ONLINE_TIME = TICKS_PER_MINUTE * MIN_ONLIME_TIME_IN_MINUTES


-- Allow players to choose another spawn in the first 10 minutes
-- This does not allow creating a new spawn point. Only joining other players.
-- SPAWN_CHANGE_GRACE_PERIOD_IN_MINUTES = 10
-- SPAWN_GRACE_TIME = TICKS_PER_MINUTE * SPAWN_CHANGE_GRACE_PERIOD_IN_MINUTES


--------------------------------------------------------------------------------
-- Alien Options
--------------------------------------------------------------------------------

-- Enable/Disable enemy expansion (Applies to RSO as well!)
ENEMY_EXPANSION = false

-- Divide the alien factors by this number to reduce it (or multiply if < 1)
ENEMY_POLLUTION_FACTOR_DIVISOR = 10
ENEMY_DESTROY_FACTOR_DIVISOR = 5

--------------------------------------------------------------------------------
-- Long Reach Options
--------------------------------------------------------------------------------

BUILD_DIST_BONUS = 15
REACH_DIST_BONUS = BUILD_DIST_BONUS
RESOURCE_DIST_BONUS = 2

--------------------------------------------------------------------------------
-- Autofill Options
--------------------------------------------------------------------------------

AUTOFILL_TURRET_AMMO_QUANTITY = 10

--------------------------------------------------------------------------------
-- Use rso_config and rso_resourece_config for RSO config settings
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- DEBUG
--------------------------------------------------------------------------------

-- DEBUG prints for me
global.oarcDebugEnabled = false