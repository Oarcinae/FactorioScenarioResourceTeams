-- copper_iron_divide_guis.lua
-- Dec 2016
-- GUI code specific to this scenario

-- I made a separate file for all the GUI related functions

require("copper_iron_divide")

local SPAWN_GUI_MAX_WIDTH = 450
local SPAWN_GUI_MAX_HEIGHT = 650


--------------------------------------------------------------------------------
-- Welcome Text Gui
-- Meant to be display the first time a player joins the server
-- Has only one button to continue to the next GUI
--------------------------------------------------------------------------------
function DisplayWelcomeTextGui(player)
    player.gui.center.add{name = "welcome_msg",
                            type = "frame",
                            direction = "vertical",
                            caption=global.welcome_msg_title}
    local wGui = player.gui.center.welcome_msg

    wGui.style.maximal_width = SPAWN_GUI_MAX_WIDTH
    wGui.style.maximal_height = SPAWN_GUI_MAX_HEIGHT



    wGui.add{name = "welcome_msg_lbl1", type = "label",
                    caption=WELCOME_MSG1}
    wGui.add{name = "welcome_msg_lbl2", type = "label",
                    caption=WELCOME_MSG2}
    wGui.add{name = "welcome_msg_spacer1", type = "label",
                    caption=" "}

    ApplyStyle(wGui.welcome_msg_lbl1, my_label_style)
    ApplyStyle(wGui.welcome_msg_lbl2, my_label_style)
    ApplyStyle(wGui.welcome_msg_spacer1, my_spacer_style)

    wGui.add{name = "other_msg_lbl1", type = "label",
                    caption=OTHER_MSG1}
    wGui.add{name = "other_msg_lbl2", type = "label",
                    caption=OTHER_MSG2}
    wGui.add{name = "other_msg_spacer1", type = "label",
                    caption=" "}

    ApplyStyle(wGui.other_msg_lbl1, my_label_style)
    ApplyStyle(wGui.other_msg_lbl2, my_label_style)
    ApplyStyle(wGui.other_msg_spacer1, my_spacer_style)

    -- wGui.add{name = "welcome_msg_lbl3", type = "label",
    --                 caption=WELCOME_MSG3}
    -- wGui.add{name = "welcome_msg_lbl4", type = "label",
    --                 caption=WELCOME_MSG4}
    -- wGui.add{name = "welcome_msg_lbl5", type = "label",
    --                 caption=WELCOME_MSG5}
    wGui.add{name = "welcome_msg_lbl6", type = "label",
                    caption=WELCOME_MSG6}
    wGui.add{name = "welcome_msg_spacer2", type = "label",
                    caption=" "}

    -- ApplyStyle(wGui.welcome_msg_lbl3, my_warning_style)
    -- ApplyStyle(wGui.welcome_msg_lbl4, my_warning_style)
    -- ApplyStyle(wGui.welcome_msg_lbl5, my_warning_style)
    ApplyStyle(wGui.welcome_msg_lbl6, my_label_style)
    ApplyStyle(wGui.welcome_msg_spacer2, my_spacer_style)


    wGui.add{name = "welcome_okay_btn",
                    type = "button",
                    caption="I Understand"}
end


--------------------------------------------------------------------------------
-- Handle Welcome Gui Click
--------------------------------------------------------------------------------
function WelcomeTextGuiClick(event)
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.player_index]
    local buttonClicked = event.element.name

    if (buttonClicked == "welcome_okay_btn") then
        if (player.gui.center.welcome_msg ~= nil) then
            player.gui.center.welcome_msg.destroy()
        end
        DisplaySpawnOptions(player)
    end
end

--------------------------------------------------------------------------------
-- Display the spawn options and explanation
--------------------------------------------------------------------------------
function DisplaySpawnOptions(player)
    player.gui.center.add{name = "spawn_opts",
                            type = "frame",
                            direction = "vertical",
                            caption="Starting Info"}
    local sGui = player.gui.center.spawn_opts
    sGui.style.maximal_width = SPAWN_GUI_MAX_WIDTH
    sGui.style.maximal_height = SPAWN_GUI_MAX_HEIGHT


    -- Warnings and explanations...
    sGui.add{name = "warning_lbl1", type = "label",
                    caption="Please read the following instructions carefully..."}
    sGui.add{name = "warning_spacer", type = "label",
                    caption=" "}
    ApplyStyle(sGui.warning_lbl1, my_warning_style)
    ApplyStyle(sGui.warning_spacer, my_spacer_style)

    sGui.add{name = "spawn_msg_lbl1", type = "label",
                    caption=SPAWN_MSG1}
    sGui.add{name = "spawn_msg_lbl2", type = "label",
                    caption=SPAWN_MSG2}
    sGui.add{name = "spawn_msg_lbl3", type = "label",
                    caption=SPAWN_MSG3}
    sGui.add{name = "spawn_msg_lbl4", type = "label",
                    caption=SPAWN_MSG4}
    sGui.add{name = "spawn_msg_lbl5", type = "label",
                    caption=SPAWN_MSG5}
    sGui.add{name = "spawn_msg_spacer", type = "label",
                    caption="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}
    ApplyStyle(sGui.spawn_msg_lbl1, my_label_style)
    ApplyStyle(sGui.spawn_msg_lbl2, my_label_style)
    ApplyStyle(sGui.spawn_msg_lbl3, my_label_style)
    ApplyStyle(sGui.spawn_msg_lbl4, my_label_style)
    ApplyStyle(sGui.spawn_msg_lbl5, my_label_style)
    ApplyStyle(sGui.spawn_msg_spacer, my_spacer_style)



    sGui.add{name = "default_spawn_btn",
                    type = "button",
                    caption="Join the game"}
    sGui.add{name = "normal_spawn_lbl1", type = "label",
                    caption="This is the only spawn option (for now)."}
    sGui.add{name = "normal_spawn_lbl2", type = "label",
                    caption="You join whichever group has fewer ONLINE players."}
    sGui.add{name = "normal_spawn_lbl3", type = "label",
                    caption=" "}
    ApplyStyle(sGui.normal_spawn_lbl1, my_label_style)
    ApplyStyle(sGui.normal_spawn_lbl2, my_label_style)
    ApplyStyle(sGui.normal_spawn_lbl3, my_label_style)

    -- Some final notes
    sGui.add{name = "note_spacer1", type = "label",
                    caption="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}

    sGui.add{name = "note_lbl1", type = "label",
                    caption=SPAWN_NOTE1}
    sGui.add{name = "note_lbl2", type = "label",
                    caption=SPAWN_NOTE2}
    sGui.add{name = "note_lbl3", type = "label",
                    caption=SPAWN_NOTE3}
    sGui.add{name = "note_spacer3", type = "label",
                    caption=" "}
    ApplyStyle(sGui.note_lbl1, my_note_style)
    ApplyStyle(sGui.note_lbl2, my_note_style)
    ApplyStyle(sGui.note_lbl3, my_note_style)
    ApplyStyle(sGui.note_spacer1, my_spacer_style)
    -- ApplyStyle(sGui.note_spacer2, my_spacer_style)
    ApplyStyle(sGui.note_spacer3, my_spacer_style)
end


--------------------------------------------------------------------------------
-- Handle the gui click of the spawn options
--------------------------------------------------------------------------------
function SpawnOptsGuiClick(event)
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.player_index]
    local buttonClicked = event.element.name


    -- Check if a valid button on the gui was pressed
    -- and delete the GUI
    if ((buttonClicked == "default_spawn_btn") or
        (buttonClicked == "join_iron_btn") or
        (buttonClicked == "join_copper_btn")) then

        if (player.gui.center.spawn_opts ~= nil) then
            player.gui.center.spawn_opts.destroy()
        end

    end

    if (buttonClicked == "default_spawn_btn") then
        StartAssignPlayerToTeam(player)

    elseif ((buttonClicked == "join_iron_btn") or (buttonClicked == "join_copper_btn")) then
        -- Not implemented yet
    end
end


--------------------------------------------------------------------------------
-- Provide a button at the top left to switch teams
--------------------------------------------------------------------------------
function CreateSpawnCtrlGui(player)
  if player.gui.top.spwn_ctrls == nil then
      player.gui.top.add{name="spwn_ctrls", type="button", caption="Team Options"}
  end   
end

--------------------------------------------------------------------------------
-- This is a toggle function, it either shows or hides the spawn controls
--------------------------------------------------------------------------------
function ExpandSpawnCtrlGui(player, tick)
    local spwnCtrlPanel = player.gui.left["spwn_ctrl_panel"]
    if (spwnCtrlPanel) then
        spwnCtrlPanel.destroy()
    else
        local spwnCtrlPanel = player.gui.left.add{type="frame",
                            name="spwn_ctrl_panel", caption="Options:"}
        local spwnCtrls = spwnCtrlPanel.add{type="scroll-pane",
                            name="spwn_ctrl_panel", caption=""}
        ApplyStyle(spwnCtrls, my_fixed_width_style)
        spwnCtrls.style.maximal_height = SPAWN_GUI_MAX_HEIGHT
        spwnCtrls.horizontal_scroll_policy = "never"

        -- NOT IMPLEMENTED YET
        -- Need to provide a button to switch teams in case players leave
    end
end


function SpawnCtrlGuiClick(event) 
    if not (event and event.element and event.element.valid) then return end
        
    local player = game.players[event.element.player_index]
    local name = event.element.name

    if (name == "spwn_ctrls") then
        ExpandSpawnCtrlGui(player, event.tick)       
    end

    if (name == "switch_team_btn") then
        -- NOT IMPLEMENTED
    end
end


win_condition_red_style = {
    minimal_width = 50,
    font_color = {r=1,g=0,b=0}
}

win_condition_green_style = {
    minimal_width = 50,
    font_color = {r=0,g=1,b=0}
}

function CreateWinConditionGui(event)
  local player = game.players[event.player_index]
  if player.gui.top.win == nil then
      player.gui.top.add{name="win", type="button", caption="Win"}
  end   
end

local function ExpandWinConditionGui(player)
    local frame = player.gui.left["win-panel"]
    if (frame) then
        frame.destroy()
    else
        local frame = player.gui.left.add{type="frame", name="win-panel", 
                            direction = "vertical", caption="Required to win:"}
        local iron_label = frame.add{name = "iron_team_win", type = "label", caption=" "}
        local copper_label = frame.add{name = "copper_team_win", type = "label", caption=" "}
        
        if (global.satellite_sent[TEAM_IRON] > 0) then
            iron_label.caption = "Iron Satellite Launched - DONE"
            ApplyStyle(iron_label, win_condition_green_style)
        else
            iron_label.caption = "Iron Satellite NOT Launched"
            ApplyStyle(iron_label, win_condition_red_style)
        end

        if (global.satellite_sent[TEAM_COPPER] > 0) then
            copper_label.caption = "Copper Satellite Launched - DONE"
            ApplyStyle(copper_label, win_condition_green_style)
        else
            copper_label.caption = "Copper Satellite NOT Launched"
            ApplyStyle(copper_label, win_condition_red_style)
        end
    end
end

function WinConditionGuiClick(event) 
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.element.player_index]
    local name = event.element.name

    if (name == "win") then
        ExpandWinConditionGui(player)        
    end  
end

function UpdateWinConditionGui()
    for _,player in pairs(game.connected_players) do

         local frame = player.gui.left["win-panel"]

         if (frame == nil) then
            ExpandWinConditionGui(player)
         else

            local frame = player.gui.left["win-panel"]
            local iron_label = player.gui.left["win-panel"].iron_team_win
            local copper_label = player.gui.left["win-panel"].copper_team_win

            if (global.satellite_sent[TEAM_IRON] > 0) then
                iron_label.caption = "Iron Satellite Launched - DONE"
                ApplyStyle(iron_label, win_condition_green_style)
            else
                iron_label.caption = "Iron Satellite NOT Launched"
                ApplyStyle(iron_label, win_condition_red_style)
            end

            if (global.satellite_sent[TEAM_COPPER] > 0) then
                copper_label.caption = "Copper Satellite Launched - DONE"
                ApplyStyle(copper_label, win_condition_green_style)
            else
                copper_label.caption = "Copper Satellite NOT Launched"
                ApplyStyle(copper_label, win_condition_red_style)
            end
         end
    end
end