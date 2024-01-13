local map = GetMapName()
local name = thisEntity:GetName()
local class = thisEntity:GetClassname()
local model = thisEntity:GetModelName()
local player = Entities:GetLocalPlayer()

if thisEntity:Attribute_GetIntValue("junction_rotation", 0) == 3 then
    thisEntity:Attribute_SetIntValue("junction_rotation", 0)
else
    thisEntity:Attribute_SetIntValue("junction_rotation", thisEntity:Attribute_GetIntValue("junction_rotation", 0) + 1)
end

-- First Junction in the Puzzle
local toner_start_junction
-- First Junction input number
local toner_start_junction_input
-- Last/Success Path
local toner_end_path
-- example_toner_path = {{start_junction_input_number [leave out for first path], end_junction_input_number [leave out for dead end/last path]}, {start_junction_name [leave out for first path], end_junction_name [leave out for dead end/last path]}, absolute_start_position, absolute_end_position},
local toner_paths
-- example_toner_junction = {type [0 = I Junction, 1 = L Junction, 2 = T Junction, 3 = LL Junction], absolute_junction_position, toner_path_for_input_0, toner_path_for_input_1, toner_path_for_input_2, toner_path_for_input_3}
local toner_junctions

if map == "a2_quarantine_entrance" then
    toner_start_junction = "toner_junction_1"
    toner_start_junction_input = 2
    toner_end_path = "toner_path_5"

    toner_paths = {
        toner_path_1 = {{2}, {"toner_junction_1"}, Vector(-912.1, 1150.47, 100), Vector(-912.1, 1115, 100)},
        toner_path_2 = {{0, 2}, {"toner_junction_1", "toner_junction_2"}, Vector(-912.1, 1109, 100), Vector(-912.1, 1099, 100), Vector(-912.1, 1099, 108.658), Vector(-912.1, 1088.1, 108.658), Vector(-926, 1088.1, 108.658)},
        toner_path_3 = {{1}, {"toner_junction_2"}, Vector(-929, 1088.1, 111.658), Vector(-929, 1088.1, 144), Vector(-946, 1088.1, 144)},
        toner_path_5 = {{0}, {"toner_junction_3"}, Vector(-973, 1088.1, 98.4348), Vector(-986, 1088.1, 98.4348)},
        toner_path_7 = {{2, 3}, {"toner_junction_3", "toner_junction_2"}, Vector(-929, 1088.1, 105.658), Vector(-929, 1088.1, 98.4348), Vector(-947, 1088.1, 98.4348), Vector(-947, 1088.1, 69.5763), Vector(-947, 1088.1, 98.4348), Vector(-967, 1088.1, 98.4348)},
    }

    toner_junctions = {
        toner_junction_1 = {0, Vector(-912.1, 1112, 100), "toner_path_2", "", "toner_path_1", ""},
        toner_junction_2 = {1, Vector(-929, 1088.1, 108.658), "", "toner_path_3", "toner_path_2", "toner_path_7"},
        toner_junction_3 = {0, Vector(-970, 1088.1, 98.4348), "toner_path_5", "", "toner_path_7", ""},
    }
elseif map == "a2_headcrabs_tunnel" then
    toner_start_junction = "toner_junction_1"
    toner_start_junction_input = 0
    toner_end_path = ""

    toner_paths = {
        toner_path_1 = {{0}, {"toner_junction_1"}, Vector(-440.082, -591.641, 10.1066), Vector(-453.538, -583.872, 10.1066)},
        toner_path_2 = {{3}, {"toner_junction_1"}, Vector(-456.077, -582.406, 7.1066), Vector(-456.077, -582.406, 1.25), Vector(-492.011, -561.866, 1.25), Vector(-508.747, -590.854, 1.25)},
        toner_path_3 = {{1, 1}, {"toner_junction_1", "toner_junction_2"}, Vector(-456.077, -582.406, 13.1066), Vector(-456.077, -582.406, 20.25), Vector(-489.012, -563.389, 20.25), Vector(-507.848, -589.466, 20.25), Vector(-563.691, -557.735, 20.25), Vector(-563.471, -557.356, 3.5)},
        toner_path_5 = {{2}, {"toner_junction_2"}, Vector(-566.054, -555.864, 0.5), Vector(-591.523, -541.157, 0.5), Vector(-583.348, -527.429, 0.5), Vector(-612.043, -511.988, 3.5)},
        toner_path_6 = {{0}, {"toner_junction_2"}, Vector(-561.36, -558.574, 0.5), Vector(-551.359, -564.352, 0.5), Vector(-518.847, -584.56, 0.5)},
        toner_path_8 = {{}, {}, Vector(), Vector()},
        toner_path_10 = {{}, {}, Vector(), Vector()},
    }

    toner_junctions = {
        toner_junction_1 = {3, Vector(-456.077, -582.406, 10.1066), "toner_path_1", "toner_path_3", "", "toner_path_2"},
        toner_junction_2 = {3, Vector(-563.471, -557.356, 0.5), "toner_path_3", "toner_path_3", "toner_path_10", ""},
    }
elseif map == "a2_train_yard" then
    toner_start_junction = "train_gate_junction_0_1"
    toner_start_junction_input = 0
    toner_end_path = ""

    toner_paths = {
        train_gate_path_start = {{0}, {"train_gate_junction_0_1"}, Vector(733, 617, 88), Vector(733, 606, 88)},
        train_gate_path_00_to_01 = {{3, 1}, {"train_gate_junction_0_0", "train_gate_junction_0_1"}, Vector(733, 603, 91), Vector(733, 603, 105)},
        train_gate_path_00_to_10 = {{0, 2}, {"train_gate_junction_1_0", "train_gate_junction_0_0"}, Vector(733, 600, 108), Vector(733, 586, 108)},
        train_gate_path_01_to_02 = {{1, 3}, {"train_gate_junction_0_2", "train_gate_junction_0_1"}, Vector(733, 603, 85), Vector(733, 603, 71)},
        train_gate_path_01_to_11 = {{0, 2}, {"train_gate_junction_1_1", "train_gate_junction_0_1"}, Vector(733, 600, 88), Vector(733, 586, 88)},
        train_gate_path_02_to_12 = {{0, 2}, {"train_gate_junction_1_2", "train_gate_junction_0_2"}, Vector(733, 600, 68), Vector(733, 586, 68)},
        train_gate_path_10_to_11 = {{1, 3}, {"train_gate_junction_1_1", "train_gate_junction_1_0"}, Vector(733, 583, 105), Vector(733, 583, 91)},
        train_gate_path_10_to_20 = {{2, 0}, {"train_gate_junction_1_0", "train_gate_junction_2_0"}, Vector(733, 580, 108), Vector(733, 566, 108)},
        train_gate_path_11_to_12 = {{3, 1}, {"train_gate_junction_1_1", "train_gate_junction_1_2"}, Vector(733, 583, 71), Vector(733, 583, 85)},
        train_gate_path_11_to_21 = {{0, 2}, {"train_gate_junction_2_1", "train_gate_junction_1_1"}, Vector(733, 580, 88), Vector(733, 566, 88)},
        train_gate_path_12_to_22 = {{0, 2}, {"train_gate_junction_2_2", "train_gate_junction_1_2"}, Vector(733, 580, 68), Vector(733, 566, 68)},
        train_gate_path_20_to_21 = {{1, 3}, {"train_gate_junction_2_1", "train_gate_junction_2_0"}, Vector(733, 563, 105), Vector(733, 563, 91)},
        train_gate_path_21_to_22 = {{1, 3}, {"train_gate_junction_2_2", "train_gate_junction_2_1"}, Vector(733, 563, 85), Vector(733, 563, 71)},
        train_gate_path_20_to_end = {{}, {}, Vector(733, 560, 108), Vector(733, 549.5, 108)},
        train_gate_path_22_to_end = {{}, {}, Vector(733, 560, 68), Vector(733, 549.5, 68)},
    }
    toner_junctions = {
        train_gate_junction_0_0 = {1, Vector(733, 603, 108), "", "", "train_gate_path_00_to_10", "train_gate_path_00_to_01"},
        train_gate_junction_0_1 = {1, Vector(733, 603, 88), "train_gate_path_start", "train_gate_path_00_to_01", "train_gate_path_01_to_11", "train_gate_path_01_to_02"},
        train_gate_junction_0_2 = {1, Vector(733, 603, 68), "", "train_gate_path_01_to_02", "train_gate_path_02_to_12", ""},
        train_gate_junction_1_0 = {1, Vector(733, 583, 108), "train_gate_path_00_to_10", "", "train_gate_path_10_to_20", "train_gate_path_10_to_11"},
        train_gate_junction_1_1 = {2, Vector(733, 583, 88), "train_gate_path_01_to_11", "train_gate_path_10_to_11", "train_gate_path_11_to_21", "train_gate_path_11_to_12"},
        train_gate_junction_1_2 = {1, Vector(733, 583, 68), "train_gate_path_02_to_12", "train_gate_path_11_to_12", "train_gate_path_12_to_22", ""},
        train_gate_junction_2_0 = {1, Vector(733, 563, 108), "train_gate_path_10_to_20", "", "train_gate_path_20_to_end", "train_gate_path_20_to_21"},
        train_gate_junction_2_1 = {1, Vector(733, 563, 88), "train_gate_path_11_to_21", "train_gate_path_20_to_21", "", "train_gate_path_21_to_22"},
        train_gate_junction_2_2 = {0, Vector(733, 563, 68), "train_gate_path_12_to_22", "train_gate_path_21_to_22", "train_gate_path_22_to_end", ""},
    }
end

function DrawTonerPath(toner_path, powered)
    for i = 4, #toner_path do
        if powered then
            DebugDrawLine(toner_path[i - 1], toner_path[i], 0, 191, 255, false, -1)
        else
            DebugDrawLine(toner_path[i - 1], toner_path[i], 255, 165, 0, false, -1)
        end
    end
end

function DrawTonerJunction(junction, center, angles)
    local junction_type = junction[1]

    if junction_type == 0 then
        local min = RotatePosition(Vector(0,0,0), angles, Vector(0,-3,0))
        local max = RotatePosition(Vector(0,0,0), angles, Vector(0,3,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)
    elseif junction_type == 1 then
        local min = RotatePosition(Vector(0,0,0), angles, Vector(0,3,0))
        local max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,0,3))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)
    elseif junction_type == 2 then
        local min = RotatePosition(Vector(0,0,0), angles, Vector(0,-3,0))
        local max = RotatePosition(Vector(0,0,0), angles, Vector(0,3,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,0,-3))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)
    elseif junction_type == 3 then
        local min = RotatePosition(Vector(0,0,0), angles, Vector(0,0,1))
        local max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,3))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,1,0))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,3,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,0,-1))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,-3))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,-1,0))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,-3,0))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,1,0))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,1))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)

        min = RotatePosition(Vector(0,0,0), angles, Vector(0,-1,0))
        max = RotatePosition(Vector(0,0,0), angles, Vector(0,0,-1))
        DebugDrawLine(center + min, center + max, 0, 255, 0, false, -1)
    end
end

function PowerTonerPath(junction, junction_name, junction_input)
    if map == "a2_train_yard" then
        junction_name = "5325_4704_" .. junction_name
    end

    local junction_entity = Entities:FindByName(nil, junction_name)

    if map == "a2_train_yard" then
        junction_name = string.gsub(junction_name, "5325_4704_", "") 
    end

    local junction_rotation = junction_entity:Attribute_GetIntValue("junction_rotation", 0)

    local junction_types = {
        { -- Type 1: I Junction
            {{2}, { }, {0}, { }}, -- Rotation 0
            {{ }, {3}, { }, {1}}, -- Rotation 1
            {{2}, { }, {0}, { }}, -- Rotation 2
            {{ }, {3}, { }, {1}}, -- Rotation 3
        },
        { -- Type 2: L Junction
            {{1}, {0}, { }, { }}, -- Rotation 0
            {{ }, {2}, {1}, { }}, -- Rotation 1
            {{ }, { }, {3}, {2}}, -- Rotation 2
            {{3}, { }, { }, {0}}, -- Rotation 3
        },
        { -- Type 3: T Junction
            {{2, 3}, {    }, {0, 3}, {0, 2}}, -- Rotation 0
            {{1, 3}, {0, 3}, {    }, {0, 1}}, -- Rotation 1
            {{1, 2}, {0, 2}, {0, 1}, {    }}, -- Rotation 2
            {{    }, {2, 3}, {1, 3}, {1, 2}}, -- Rotation 3
        },
        { -- Type 4: LL Junction
            {{1}, {0}, {3}, {2}}, -- Rotation 0
            {{3}, {2}, {1}, {0}}, -- Rotation 1
            {{1}, {0}, {3}, {2}}, -- Rotation 2
            {{3}, {2}, {1}, {0}}, -- Rotation 3
        },
    }

    local junction_type = junction[1]
    local output_toner_paths = junction_types[junction_type + 1][junction_rotation + 1][junction_input + 1]

    for i = 1, #output_toner_paths do
        print(output_toner_paths[i] + 3)
        local toner_path_powered_name = junction[output_toner_paths[i] + 3]

        if toner_path_powered_name ~= "" then
            if map == "a2_train_yard" then
                toner_path_powered_name = "5325_4704_" .. toner_path_powered_name
            end

            local toner_path_powered_entity = Entities:FindByName(nil, toner_path_powered_name)
            if toner_path_powered_entity:Attribute_GetIntValue("toner_path_powered", 0) == 0 then
                toner_path_powered_entity:Attribute_SetIntValue("toner_path_powered", 1)
                SendToConsole("ent_fire_output " .. toner_path_powered_name .. " OnPowerOn")

                if map == "a2_train_yard" then
                    toner_path_powered_name = string.gsub(toner_path_powered_name, "5325_4704_", "") 
                end

                for j = 1, #toner_paths[toner_path_powered_name][1] do
                    local next_toner_junction_name = toner_paths[toner_path_powered_name][2][j]
                    if next_toner_junction_name ~= "" and next_toner_junction_name ~= junction_name then
                        local next_toner_junction = toner_junctions[next_toner_junction_name]
                        local next_toner_junction_input = toner_paths[toner_path_powered_name][1][j]
                        PowerTonerPath(next_toner_junction, next_toner_junction_name, next_toner_junction_input)
                    end
                end

                if toner_path_powered_name == toner_end_path then
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())
                    StartSoundEventFromPosition("Toner.PortComplete", player:EyePosition())

                    player:Attribute_SetIntValue("circuit_" .. map .. "_" .. toner_start_junction .. "_completed", 1)

                    player:SetThink(function()
                        DebugDrawClear()
                    end, "TonerComplete", 3)
                end
            end
        end
    end
end

function ToggleTonerJunction()
    local junction_name = thisEntity:GetName()

    if map == "a2_train_yard" then
        junction_name = string.gsub(junction_name, "5325_4704_", "") 
    end

    local junction = toner_junctions[junction_name]

    if junction then
        DebugDrawClear()

        local angles = thisEntity:GetAngles()
        StartSoundEventFromPosition("Toner.JunctionRotate", player:EyePosition())

        local new_index = thisEntity:Attribute_GetIntValue("junction_rotation", 0) + 1
        local old_index = new_index - 1
        if old_index == 0 then
            old_index = 4
        end

        local ent = Entities:FindByClassname(nil, "info_hlvr_toner_path")
        while ent do
            ent:FireOutput("OnPowerOff", nil, nil, nil, 0)
            ent:Attribute_SetIntValue("toner_path_powered", 0)
            ent = Entities:FindByClassname(ent, "info_hlvr_toner_path")
        end

        PowerTonerPath(toner_junctions[toner_start_junction], toner_start_junction, toner_start_junction_input)

        for toner_junction_name, toner_junction in pairs(toner_junctions) do
            if map == "a2_train_yard" then
                toner_junction_name = "5325_4704_" .. toner_junction_name
            end

            local junction_entity = Entities:FindByName(nil, toner_junction_name)
            local angles = junction_entity:GetAngles()
            angles = QAngle(angles.x, angles.y, junction_entity:Attribute_GetIntValue("junction_rotation", 0) * 90)
            DrawTonerJunction(toner_junction, toner_junction[2], angles)
        end

        for toner_path_name, toner_path in pairs(toner_paths) do
            if map == "a2_train_yard" then
                toner_path_name = "5325_4704_" .. toner_path_name
            end

            if toner_path_name == "toner_path_1" or toner_path_name == "5325_4704_train_gate_path_start" then
                Entities:FindByName(nil, toner_path_name):Attribute_SetIntValue("toner_path_powered", 1)
            end

            DrawTonerPath(toner_path, Entities:FindByName(nil, toner_path_name):Attribute_GetIntValue("toner_path_powered", 0) == 1)
        end
    end
end

if class == "info_hlvr_toner_port" and (thisEntity:Attribute_GetIntValue("used", 0) == 0 or thisEntity:Attribute_GetIntValue("redraw_toner", 0) == 1) then
    DoEntFireByInstanceHandle(thisEntity, "OnPlugRotated", "", 0, nil, nil)
    DebugDrawClear()
    if toner_junctions then
        for junction_name, junction in pairs(toner_junctions) do
            if map == "a2_train_yard" then
                junction_name = "5325_4704_" .. junction_name
            end

            local junction_entity = Entities:FindByName(nil, junction_name)
            local angles = junction_entity:GetAngles()
            angles = QAngle(angles.x, angles.y, junction_entity:Attribute_GetIntValue("junction_rotation", 0) * 90)
            DrawTonerJunction(junction, junction[2], angles)
        end
        for toner_path_name, toner_path in pairs(toner_paths) do
            if map == "a2_train_yard" then
                toner_path_name = "5325_4704_" .. toner_path_name
            end

            if toner_path_name == "toner_path_1" or toner_path_name == "5325_4704_train_gate_path_start" then
                Entities:FindByName(nil, toner_path_name):Attribute_SetIntValue("toner_path_powered", 1)
            end

            DrawTonerPath(toner_path, Entities:FindByName(nil, toner_path_name):Attribute_GetIntValue("toner_path_powered", 0) == 1)
        end
    end

    if thisEntity:Attribute_GetIntValue("redraw_toner", 0) == 0 then
        if map == "a3_station_street" and name == "power_stake_1_start" then
            SendToConsole("ent_fire_output toner_path_alarm_1 OnPowerOn")
            SendToConsole("ent_fire toner_path_6_relay_debug Trigger")
        end

        if map == "a3_hotel_lobby_basement" and name == "power_stake_1_start" then
            SendToConsole("ent_fire_output power_logic_enable_lights OnTrigger")
            SendToConsole("ent_fire_output toner_path_11 OnPowerOn")
            player:Attribute_SetIntValue("EnabledHotelLobbyPower", 1)
        end

        if map == "a3_hotel_street" and name == "power_stake_1_start" then
            SendToConsole("ent_fire_output toner_path_11 onpoweron")
        end

        if map == "a3_c17_processing_plant" and name == "shack_path_6_port_1" then
            DoEntFireByInstanceHandle(thisEntity, "Disable", "", 0, nil, nil)
            -- TODO: Remove once puzzle implemented
            SendToConsole("ent_fire_output shack_path_5 OnPowerOn")
        end

        if map == "a3_distillery" then
            if name == "freezer_toner_outlet_1" then
                SendToConsole("ent_fire_output barricade_door OnCompletionA_Backward")
                SendToConsole("ent_fire_output freezer_toner_path_3 OnPowerOn")
                SendToConsole("ent_fire_output freezer_toner_path_6 OnPowerOn")
                SendToConsole("ent_remove debug_teleport_player_freezer_door")
                SendToConsole("ent_fire relay_debug_freezer_breakout Trigger")
            end

            if name == "freezer_toner_outlet_2" then
                SendToConsole("ent_fire_output freezer_toner_path_7 OnPowerOn")
                -- TODO: Remove once puzzle implemented
                SendToConsole("ent_fire_output freezer_toner_path_8 OnPowerOn 0 0 5")
            end
        end

        if map == "a4_c17_zoo" and name == "589_test_outlet" then
            SendToConsole("ent_fire_output 589_path_unlock_door OnPowerOn")
            SendToConsole("ent_fire_output 589_path_11 OnPowerOn")
        end

        if map == "a4_c17_tanker_yard" and name == "1489_4074_port_demux" then
            SendToConsole("ent_fire_output 1489_4074_path_demux_3_0 onpoweron")
            SendToConsole("ent_fire_output 1489_4074_path_demux_3_3 onpoweron")
            SendToConsole("ent_fire_output 1489_4074_path_demux_3_6 onpoweron")
        end

        if map == "a4_c17_parking_garage" then
            if name == "toner_port" then
                SendToConsole("ent_fire_output toner_path_2 OnPowerOn")
                Entities:FindByName(nil, "falling_cabinet_door"):ApplyLocalAngularVelocityImpulse(Vector(0, 1200, 0))
            elseif name == "toner_port_2" then
                SendToConsole("ent_fire_output toner_path_5 OnPowerOn")
            elseif name == "toner_port_3" then
                SendToConsole("ent_fire_output toner_path_8 OnPowerOn")
                if Entities:FindByName(nil, "door_reset"):GetCycle() >= 0.99 then
                    SendToConsole("ent_fire_output door_reset OnCompletionA_Forward")
                end
            end
        end
    end

    thisEntity:Attribute_SetIntValue("used", 1)
    thisEntity:Attribute_SetIntValue("redraw_toner", 0)
end

if class == "info_hlvr_toner_junction" and toner_start_junction ~= nil and player:Attribute_GetIntValue("circuit_" .. map .. "_" .. toner_start_junction .. "_completed", 0) == 0 then
    ToggleTonerJunction()
end

if model == "models/props_combine/combine_doors/combine_door_sm01.vmdl" or model == "models/props_combine/combine_lockers/combine_locker_doors.vmdl" then
    if thisEntity:GetSequence() == "open_idle" then
        return
    end

    local ent = Entities:FindByClassnameNearest("info_hlvr_holo_hacking_plug", thisEntity:GetCenter(), 40)

    if ent and ent:Attribute_GetIntValue("used", 0) == 0 then
        ent:Attribute_SetIntValue("used", 1)
        DoEntFireByInstanceHandle(ent, "BeginHack", "", 0, nil, nil)
        DoEntFireByInstanceHandle(ent, "EndHack", "", 1.8, nil, nil)
        ent:FireOutput("OnHackSuccess", nil, nil, nil, 1.8)
        ent:FireOutput("OnPuzzleSuccess", nil, nil, nil, 1.8)
    end
end

-- Combine Fabricator
if class == "prop_hlvr_crafting_station_console" then
    local function AnimTagListener(sTagName, nStatus)
        if sTagName == 'Bootup Done' and nStatus == 2 then
            thisEntity:Attribute_SetIntValue("crafting_station_ready", 1)
        elseif sTagName == 'Crafting Done' and nStatus == 2 then
            if Convars:GetStr("chosen_upgrade") == "pistol_upgrade_aimdownsights" then
                player:Attribute_SetIntValue("pistol_upgrade_aimdownsights", 1)
                SendToConsole("give weapon_pistol")
                SendToConsole("viewmodel_update")
                SendToConsole("ent_fire text_pistol_upgrade_aimdownsights ShowMessage")
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
            elseif Convars:GetStr("chosen_upgrade") == "pistol_upgrade_burstfire" then
                player:Attribute_SetIntValue("pistol_upgrade_burstfire", 1)
                SendToConsole("give weapon_pistol")
                SendToConsole("viewmodel_update")
                SendToConsole("ent_fire text_pistol_upgrade_burstfire ShowMessage")
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
            elseif Convars:GetStr("chosen_upgrade") == "pistol_upgrade_hopper" then
                player:Attribute_SetIntValue("pistol_upgrade_hopper", 1)
                SendToConsole("give weapon_pistol")
                SendToConsole("viewmodel_update")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade animation is not implemented", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            elseif Convars:GetStr("chosen_upgrade") == "pistol_upgrade_lasersight" then
                player:Attribute_SetIntValue("pistol_upgrade_lasersight", 1)
                SendToConsole("give weapon_pistol")
                SendToConsole("viewmodel_update")
                SendToConsole("pistol_use_new_accuracy 1")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade does not have a model yet", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            elseif Convars:GetStr("chosen_upgrade") == "shotgun_upgrade_grenadelauncher" then
                player:Attribute_SetIntValue("shotgun_upgrade_grenadelauncher", 1)
                SendToConsole("give weapon_shotgun")
                SendToConsole("viewmodel_update")
                SendToConsole("ent_fire text_shotgun_upgrade_grenadelauncher ShowMessage")
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
            elseif Convars:GetStr("chosen_upgrade") == "shotgun_upgrade_doubleshot" then
                player:Attribute_SetIntValue("shotgun_upgrade_doubleshot", 1)
                SendToConsole("give weapon_shotgun")
                SendToConsole("viewmodel_update")
                SendToConsole("ent_fire text_shotgun_upgrade_doubleshot ShowMessage")
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
            elseif Convars:GetStr("chosen_upgrade") == "shotgun_upgrade_lasersight" then
                player:Attribute_SetIntValue("shotgun_upgrade_lasersight", 1)
                SendToConsole("give weapon_shotgun")
                SendToConsole("viewmodel_update")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade does not have a model yet", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            elseif Convars:GetStr("chosen_upgrade") == "shotgun_upgrade_hopper" then
                player:Attribute_SetIntValue("shotgun_upgrade_hopper", 1)
                SendToConsole("give weapon_shotgun")
                SendToConsole("viewmodel_update")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade animation is not implemented", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            elseif Convars:GetStr("chosen_upgrade") == "smg_upgrade_aimdownsights" then
                player:Attribute_SetIntValue("smg_upgrade_aimdownsights", 1)
                SendToConsole("give weapon_ar2")
                SendToConsole("viewmodel_update")
                SendToConsole("ent_fire text_smg_upgrade_aimdownsights ShowMessage")
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
            elseif Convars:GetStr("chosen_upgrade") == "smg_upgrade_lasersight" then
                player:Attribute_SetIntValue("smg_upgrade_lasersight", 1)
                SendToConsole("give weapon_ar2")
                SendToConsole("viewmodel_update")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade does not have a model yet", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            elseif Convars:GetStr("chosen_upgrade") == "smg_upgrade_casing" then
                player:Attribute_SetIntValue("smg_upgrade_casing", 1)
                SendToConsole("give weapon_ar2")
                SendToConsole("viewmodel_update")

                -- TODO: Implement weapon upgrade and remove message
                local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=10, ["x"]=-1, ["y"]=0.6})
                DoEntFireByInstanceHandle(ent, "SetText", "This weapon upgrade animation is not implemented", 0, nil, nil)
                DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
            end

            SendToConsole("ent_fire point_clientui_world_panel Enable")
            SendToConsole("ent_fire weapon_in_fabricator Kill")
            thisEntity:SetGraphParameterBool("bCrafting", false)
            Convars:SetStr("chosen_upgrade", "")
            Convars:SetStr("weapon_in_crafting_station", "")
        elseif sTagName == 'Trays Retracted' and nStatus == 2 then
            thisEntity:Attribute_SetIntValue("cancel_cooldown_done", 1)
        end
    end

    thisEntity:RegisterAnimTagListener(AnimTagListener)
end
