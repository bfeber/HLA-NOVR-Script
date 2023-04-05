local map = GetMapName()
local class = thisEntity:GetClassname()
local name = thisEntity:GetName()
local player = Entities:GetLocalPlayer()

if name ~= "12712_shotgun_wheel" and name ~= "@pod_shell" and name ~= "589_panel_switch" and name ~= "tc_door_control" and (class == "item_health_station_charger" or (class == "prop_animinteractable" and not vlua.find(name, "5628_2901_barricade_door")) or class == "item_hlvr_combine_console_rack") and thisEntity:Attribute_GetIntValue("used", 0) == 0 then
    if name == "plug_console_starter_lever" then
        thisEntity:FireOutput("OnCompletionB_Forward", nil, nil, nil, 0)
    end
    
    thisEntity:Attribute_SetIntValue("used", 1)

    if class == "item_health_station_charger" or class == "item_hlvr_combine_console_rack" then
        DoEntFireByInstanceHandle(thisEntity, "EnableOnlyRunForward", "", 0, nil, nil)
    end

    local count = 0
    thisEntity:SetThink(function()
        DoEntFireByInstanceHandle(thisEntity, "SetCompletionValue", "" .. count, 0, nil, nil)
        
        if map == "a3_distillery" and name == "verticaldoor_wheel" then
            count = count + 0.001
        else
            count = count + 0.01
        end
        if count >= 1 then
            thisEntity:FireOutput("OnCompletionA_Forward", nil, nil, nil, 0)
            if name == "barricade_door_hook" then
                SendToConsole("ent_fire barricade_door setreturntocompletionstyle 0")
            end
            return nil
        else
            return 0
        end
    end, "AnimateCompletionValue", 0)
elseif name == "589_panel_switch" or name == "5628_2901_barricade_door_hook" then
    thisEntity:Attribute_SetIntValue("used", 1)

    local count = 0
    thisEntity:SetThink(function()
        DoEntFireByInstanceHandle(thisEntity, "SetCompletionValue", "" .. 1 - count, 0, nil, nil)
        count = count + 0.01
        if count >= 1 then
            thisEntity:FireOutput("OnCompletionA_Backward", nil, nil, nil, 0)
            return nil
        else
            return 0
        end
    end, "AnimateCompletionValue", 0)
end

if vlua.find(name, "_locker_door_") then
    thisEntity:ApplyLocalAngularVelocityImpulse(Vector(0,0,5000))
elseif vlua.find(name, "_hazmat_crate_lid") then
    thisEntity:ApplyLocalAngularVelocityImpulse(Vector(0,-5000,0))
elseif vlua.find(name, "electrical_panel_") and vlua.find(name, "_door") then
    thisEntity:ApplyLocalAngularVelocityImpulse(Vector(0,0,-5000))
end

if class == "prop_door_rotating_physics" and vlua.find(name, "padlock_door") then
    DoEntFireByInstanceHandle(thisEntity, "Close", "", 0, nil, nil)
end

if name == "1489_4074_port_demux" then
    SendToConsole("ent_fire_output 1489_4074_path_demux_3_0 onpoweron")
    SendToConsole("ent_fire_output 1489_4074_path_demux_3_3 onpoweron")
    SendToConsole("ent_fire_output 1489_4074_path_demux_3_6 onpoweron")
end

if name == "bridge_crank" then
    SendToConsole("ent_fire driven_bridge SetAnimation combine_barrel_arm_bridge_anim")
    SendToConsole("ent_fire drawbridge_brush Enable")
    StartSoundEventFromPosition("CombineVortPod.Lower", thisEntity:GetOrigin())
end

if name == "3_8223_prop_button" then
    SendToConsole("ent_fire_output 3_8223_handpose_combine_switchbox_button_press OnHandPosed")
end

if name == "3_8223_mesh_combine_switch_box" then
    SendToConsole("ent_fire_output 3_8223_switch_box_hack_plug OnHackSuccess")

end

if name == "589_test_outlet" then
    SendToConsole("ent_fire 589_vertical_door Open")
    SendToConsole("ent_fire_output 589_path_11 OnPowerOn")
end

if class == "item_combine_tank_locker" then
    DoEntFireByInstanceHandle(thisEntity, "PlayAnimation", "combine_locker_standing", 0, nil, nil)

    ent = Entities:FindByClassname(nil, "item_hlvr_combine_console_tank")
    while ent do
        if ent:GetMoveParent() then
            DoEntFireByInstanceHandle(ent, "EnablePickup", "", 0, nil, nil)
        end
        ent = Entities:FindByClassname(ent, "item_hlvr_combine_console_tank")
    end
end

if class == "item_hlvr_weapon_shotgun" then
    SendToConsole("give weapon_shotgun")
    SendToConsole("ent_fire 12712_relay_player_shotgun_is_ready Trigger")
    thisEntity:Kill()
end

if class == "item_hlvr_weapon_rapidfire" then
    SendToConsole("give weapon_smg1")
    thisEntity:Kill()
end

if class == "prop_dynamic" and thisEntity:GetModelName() == "models/props/alyx_hideout/button_plate.vmdl" then
    SendToConsole("ent_fire 2_8127_elev_button_test_floor_" .. player:Attribute_GetIntValue("next_elevator_floor", 2) .. " Trigger")

    if player:Attribute_GetIntValue("next_elevator_floor", 2) == 2 then
        player:Attribute_SetIntValue("next_elevator_floor", 1)
    else
        player:Attribute_SetIntValue("next_elevator_floor", 2)
    end
end


if map == "a3_hotel_interior_rooftop" and name == "window_sliding1" then
    SendToConsole("fadein 0.2")
    SendToConsole("setpos_exact 788 -1420 576")
    SendToConsole("-use")
    thisEntity:SetThink(function()
        SendToConsole("+use")
    end, "", 0)
end

if name == "2860_window_sliding1" then
    SendToConsole("fadein 0.2")
    SendToConsole("setpos_exact 1437 -1422 140")
end

if name == "power_stake_1_start" then
    SendToConsole("ent_fire_output toner_path_alarm_1 OnPowerOn")
    SendToConsole("ent_fire toner_path_6_relay_debug Trigger")
end

if name == "2_11128_cshield_station_prop_button" then
    SendToConsole("ent_fire 2_11128_cshield_station_relay_button_pressed Trigger")
end

if name == "2_11128_cshield_station_1" then
    SendToConsole("ent_fire_output 2_11128_cshield_station_hack_plug OnHackSuccess")
end

if name == "2_7371_combine_locker" then
    SendToConsole("ent_fire_output 2_7371_locker_hack_plug OnHackSuccess")
end

if name == "2_7288_combine_locker" then
    SendToConsole("ent_fire_output 2_7288_locker_hack_plug OnHackSuccess")
end

if name == "2_8792_combine_locker" then
    SendToConsole("ent_fire_output 2_8792_locker_hack_plug OnHackSuccess")
end

if name == "417_591_combine_locker" then
    SendToConsole("ent_fire_output 417_591_locker_hack_plug OnHackSuccess")
end

if name == "2_4255_combine_locker" then
    SendToConsole("ent_fire_output 2_4255_locker_hack_plug OnHackSuccess")
end

if name == "351_2845_combine_locker" then
    SendToConsole("ent_fire_output 351_2845_locker_hack_plug OnHackSuccess")
end

if name == "2_11759_combine_locker" then
    SendToConsole("ent_fire_output 2_11759_locker_hack_plug OnHackSuccess")
end

if name == "2_5877_combine_locker" then
    SendToConsole("ent_fire_output 2_5877_locker_hack_plug OnHackSuccess")
end

if name == "2_6661_combine_locker" then
    SendToConsole("ent_fire_output 2_6661_locker_hack_plug OnHackSuccess")
end

if name == "879_combine_locker" then
    SendToConsole("ent_fire_output 879_locker_hack_plug OnHackSuccess")
end

if name == "1517_1920_combine_locker" then
    SendToConsole("ent_fire_output 1517_1920_locker_hack_plug OnHackSuccess")
end

if name == "254_2183_1620_combine_locker" then
    SendToConsole("ent_fire_output 254_2183_1620_locker_hack_plug OnHackSuccess")
end

if name == "254_16189_combine_locker" then
    SendToConsole("ent_fire_output 254_16189_locker_hack_plug OnHackSuccess")
    SendToConsole("ent_fire_output 254_16189_locker_hack_plug OnPuzzleSuccess")
end

if name == "1962_combine_locker" then
    SendToConsole("ent_fire_output 1962_locker_hack_plug OnHackSuccess")
end

if name == "2_8127_elev_button_floor_1_call" then
    SendToConsole("ent_fire_output 2_8127_elev_button_floor_1_call OnIn")
end

if name == "2_203_elev_button_floor_1" then
    SendToConsole("ent_fire_output 2_203_elev_button_floor_1_handpose onhandposed")
end

if name == "2_203_inside_elevator_button" then
    SendToConsole("ent_fire_output 2_203_elev_door_is_open onfalse")
    SendToConsole("+use")
    thisEntity:SetThink(function()
        SendToConsole("-use")
    end, "", 0)
end

if name == "inside_elevator_button" then
    SendToConsole("ent_fire elev_button_elevator unlock")
    SendToConsole("ent_fire_output elev_button_elevator_handpose onhandposed")
    SendToConsole("+use")
    thisEntity:SetThink(function()
        SendToConsole("-use")
    end, "", 0)
end

if name == "5325_4205_5030_door_hack_prop" then
    SendToConsole("ent_fire_output 5325_4205_5030_door_hack_plug OnHackSuccess")
end

if name == "2_5425_door_hack_prop" then
    SendToConsole("ent_fire_output 2_5425_door_hack_plug OnHackSuccess")
end

if name == "2041_door_hack_prop" then
    SendToConsole("ent_fire_output 2041_door_hack_plug OnHackSuccess")
end

if name == "console_opener_prop_handle_interact" then
    SendToConsole("ent_fire_output console_opener_logic_isselected_1 ontrue")
    SendToConsole("ent_fire_output console_opener_logic_isselected_2 ontrue")
    SendToConsole("ent_fire_output console_opener_logic_isselected_3 ontrue")
    SendToConsole("ent_fire_output console_opener_logic_isselected_4 ontrue")
    SendToConsole("ent_fire_output console_opener_logic_isselected_5 ontrue")
end

if name == "@pod_shell" then
    SendToConsole("ent_fire @pod_shell unlock")
end

if name == "ChoreoPhysProxy" then
    SendToConsole("ent_fire eli_fall_relay Trigger")
end

if name == "traincar_01_hatch" then
    SendToConsole("ent_fire_output traincar_01_hackplug OnHackSuccess")
end

if name == "5325_4704_toner_port_train_gate" then
    SendToConsole("ent_fire_output 5325_4704_train_gate_path_20_to_end OnPowerOn")
    SendToConsole("ent_fire_output 5325_4704_train_gate_path_22_to_end OnPowerOn")
end

if name == "interactive_wheel" then
    SendToConsole("ent_fire 3338_2787_verticaldoor_movelinear open")
    return
end

if name == "interactive_wheel2" then
    SendToConsole("ent_fire 2678_4876_verticaldoor_movelinear open")
    return
end

if name == "12712_shotgun_wheel" then
    SendToConsole("ent_fire !picker SetCompletionValue 10")
    return
end

if name == "bell" then
    DoEntFireByInstanceHandle(thisEntity, "PlayAnimation", "chain_pull", 0, nil, nil)
    DoEntFireByInstanceHandle(thisEntity, "SetPlaybackRate", "8", 0, nil, nil)
    SendToConsole("ent_fire_output bell OnCompletionA_Forward")
    return
end

if name == "4910_135_interactive_wheel" then
    SendToConsole("ent_fire 4910_139_verticaldoor_movelinear Open")
    return
end

if name == "270_trip_mine_item_1" then
    SendToConsole("ent_fire 270_trip_mine_item_1 deactivatemine")
end

if class == "prop_hlvr_crafting_station_console" then
    SendToConsole("ent_fire prop_hlvr_crafting_station OpenStation")
end

if class == "item_hlvr_combine_console_tank" then
    if thisEntity:GetMoveParent() then
        DoEntFireByInstanceHandle(thisEntity, "ClearParent", "", 0, nil, nil)
    else
        thisEntity:ApplyLocalAngularVelocityImpulse(Vector(150,0,0))
    end
end

if class == "prop_dynamic" and thisEntity:GetModelName() == "models/props_combine/health_charger/combine_health_charger_vr_pad.vmdl" then
    if tostring(thisEntity:GetMaterialGroupMask()) == "5" then
        if player:GetHealth() == player:GetMaxHealth() then
            StartSoundEvent("HealthStation.Deny", player)
        else
            StartSoundEvent("HealthStation.Start", player)
            SendToConsole("ent_fire player_speedmod ModifySpeed 0")
            thisEntity:SetThink(function()
                StartSoundEvent("HealthStation.Loop", player)
            end, "Loop", .7)
            thisEntity:SetThink(function()
                if player:GetHealth() < player:GetMaxHealth() then
                    player:SetHealth(player:GetHealth() + 1)
                    return 0.1
                else
                    StopSoundEvent("HealthStation.Loop", player)
                    StartSoundEvent("HealthStation.Complete", player)
                    thisEntity:StopThink("Loop")
                    SendToConsole("ent_fire player_speedmod ModifySpeed 1")
                end
                
            end, "Heal", 0)
        end
    end
end

if name == "room1_lights_circuitbreaker_switch" then
    SendToConsole("ent_fire_output controlroom_circuitbreaker_relay ontrigger")
end

if map == "a2_train_yard" then
    if class == "item_hlvr_combine_console_rack" then
        local ent = Entities:FindByName(nil, "5325_3947_combine_console")
        DoEntFireByInstanceHandle(ent, "RackOpening", "1", 0, thisEntity, thisEntity)
    end
end

if map == "a2_drainage" then
    if name == "2678_5785_door_hack_prop" then
        SendToConsole("ent_fire_output 2678_5785_door_hack_plug OnHackSuccess")
    end
end

if map == "a2_headcrabs_tunnel" then
    if name == "toner_start" then
        SendToConsole("ent_fire_output toner_path_2 OnPowerOff")
        SendToConsole("ent_fire_output toner_path_8 OnPowerOff")
    end

    if name == "flashlight" then
        SendToConsole("ent_fire_output flashlight OnAttachedToHand")
        SendToConsole("bind F inv_flashlight")
        player:Attribute_SetIntValue("has_flashlight", 1)
        SendToConsole("ent_remove flashlight")
    end
end

if map == "a2_quarantine_entrance" then
    if name == "toner_port" and thisEntity:Attribute_GetIntValue("used", 0) == 0 then
        SendToConsole("ent_fire_output toner_path_5 OnPowerOn")
    end

    if class == "item_hlvr_combine_console_rack" then
        local ent = Entities:FindByName(nil, "17670_combine_console")
        DoEntFireByInstanceHandle(ent, "RackOpening", "1", 0, thisEntity, thisEntity)
    end
    
    if name == "27788_combine_locker" then
        SendToConsole("ent_fire_output 27788_locker_hack_plug OnHackSuccess")
    end
end

if map == "a3_hotel_lobby_basement" then
    if name == "power_stake_1_start" then
        SendToConsole("ent_fire_output power_logic_enable_lights ontrigger")
        SendToConsole("ent_fire_output path_2_panel onpoweron")
        SendToConsole("ent_fire_output power_logic_enable_lift ontrigger")
    end

    if name == "elev_button_floor_1" then
        SendToConsole("ent_fire_output elev_button_floor_1 OnIn")
    end
end

if GetMapName() == "a3_distillery" then
    if name == "11578_2635_380_button_center" then
        SendToConsole("ent_fire_output 11578_2635_380_button_center_pusher onin")
    end

    if name == "intro_rollup_door" then
        SendToConsole("ent_fire_output intro_rollup_door oncompletiona_forward")
        SendToConsole("ent_fire door_xen_crust break")
        SendToConsole("ent_fire relay_door_xen_crust_c trigger")
        SendToConsole("ent_fire relay_door_xen_crust_d trigger")
        SendToConsole("ent_fire relay_door_xen_crust_e trigger")
    end

    if name == "barricade_door" then
        SendToConsole("ent_fire barricade_door setreturntocompletionamount 1")
    end

    if name == "tc_door_control" then
        SendToConsole("ent_fire tc_door_control setcompletionvalue 0")
        SendToConsole("ent_fire relay_close_compactor_doors trigger")
    end

    if name == "11478_6233_tutorial_wheel" then
        SendToConsole("ent_fire 11478_6233_verticaldoor_wheel_tutorial open")
    end

    if name == "verticaldoor_wheel" then
        SendToConsole("ent_fire @verticaldoor setspeed 10")
        SendToConsole("ent_fire @verticaldoor open")
    end

    if name == "11479_2385_button_pusher_prop" then
        SendToConsole("ent_fire_output 11479_2385_button_center_pusher onin")
    end

    if name == "11479_2386_button_pusher_prop" then
        SendToConsole("ent_fire_output 11479_2386_button_center_pusher onin")
    end

    if name == "freezer_toner_outlet_1" then
        SendToConsole("ent_fire_output freezer_toner_path_3 onpoweron")
        SendToConsole("ent_fire_output freezer_toner_path_6 onpoweron")
        SendToConsole("ent_remove debug_teleport_player_freezer_door")
        SendToConsole("ent_fire relay_debug_freezer_breakout trigger")
    end

    if name == "freezer_toner_outlet_2" then
        SendToConsole("ent_fire_output freezer_toner_path_7 onpoweron")
    end

    if name == "freezer_port_b_2" then
        SendToConsole("ent_fire_output freezer_toner_path_8 onpoweron")
    end

    if name == "plug_console_starter_lever" then
        SendToConsole("ent_fire_output plug_console_starter_lever oncompletionb_forward")
    end

    if name == "11578_2420_181_antlion_plug_crank_a" then
        SendToConsole("ent_fire_output 11578_2420_181_antlion_plug_crank_a oncompletionc_forward")
    end

    if name == "11578_2420_183_antlion_plug_crank_a" then
        SendToConsole("ent_fire_output 11578_2420_183_antlion_plug_crank_a oncompletionc_forward")
    end

    if name == "antlion_plug_crank_c" then
        SendToConsole("ent_fire_output antlion_plug_crank_c oncompletionc_forward")
    end
end

if name == "lift_button_box" then
    if thisEntity:Attribute_GetIntValue("used", 0) == 1 then
        SendToConsole("ent_fire_output lift_button_down onin")
        thisEntity:Attribute_SetIntValue("used", 0)
    else
        SendToConsole("ent_fire_output lift_button_up onin")
        thisEntity:Attribute_SetIntValue("used", 1)
    end
end

if name == "1517_3301_lift_prop_animated" then
    SendToConsole("ent_fire_output lift_button_down onin")
end

if name == "shack_path_6_port_1" then
    SendToConsole("ent_fire_output pallet_panel_power_on ontrigger")
end

if name == "pallet_lever_vertical" then
    SendToConsole("ent_fire_output pallet_logic_phys_raise ontrigger")
end

if name == "pallet_lever" then
    SendToConsole("ent_fire_output pallet_logic_extend ontrigger")
end

if class == "baseanimating" and vlua.find(name, "Console") then
    SendToConsole("ent_fire_output *_console_hacking_plug OnHackSuccess")
    SendToConsole("ent_fire item_hlvr_combine_console_tank DisablePickup")
    SendToConsole("ent_fire 5325_3947_combine_console AddOutput OnTankAdded>item_hlvr_combine_console_tank>DisablePickup>>0>1")
end

if class == "item_hlvr_grenade_xen" then
    DoEntFireByInstanceHandle(thisEntity, "ArmGrenade", "", 0, nil, nil)
end

local item_pickup_params = { ["userid"]=player:GetUserID(), ["item"]=class, ["item_name"]=name }

if class == "item_hlvr_crafting_currency_small" then
    if name == "currency_booby_trap" then
        thisEntity:FireOutput("OnPlayerPickup", nil, nil, nil, 0)
    end

    FireGameEvent("item_pickup", item_pickup_params)
    SendToConsole("hlvr_addresources 0 0 0 1")
    StartSoundEventFromPosition("Inventory.BackpackGrabItemResin", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_clip_energygun" then
    FireGameEvent("item_pickup", item_pickup_params)
    if name == "pistol_clip_1" then
        SendToConsole("ent_remove weapon_bugbait")
        SendToConsole("give weapon_pistol")
    else
        SendToConsole("hlvr_addresources 10 0 0 0")
    end
    StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_clip_energygun_multiple" then
    FireGameEvent("item_pickup", item_pickup_params)
    SendToConsole("hlvr_addresources 40 0 0 0")
    StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_clip_shotgun_multiple" then
    FireGameEvent("item_pickup", item_pickup_params)
    SendToConsole("hlvr_addresources 0 0 4 0")
    StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_clip_shotgun_single" then
    FireGameEvent("item_pickup", item_pickup_params)
    SendToConsole("hlvr_addresources 0 0 1 0")
    StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_clip_rapidfire" then
    FireGameEvent("item_pickup", item_pickup_params)
    SendToConsole("hlvr_addresources 0 30 0 0")
    StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
    thisEntity:Kill()
elseif class == "item_hlvr_grenade_frag" then
    if thisEntity:GetSequence() == "vr_grenade_unarmed_idle" then
        FireGameEvent("item_pickup", item_pickup_params)
        StartSoundEventFromPosition("Inventory.DepositItem", player:EyePosition())
        SendToConsole("give weapon_frag")
        thisEntity:Kill()
    end
elseif class == "item_healthvial" then
    if player:GetHealth() < player:GetMaxHealth() then
        player:SetHealth(min(player:GetHealth() + 10, player:GetMaxHealth()))
        FireGameEvent("item_pickup", item_pickup_params)
        StartSoundEventFromPosition("HealthPen.Stab", player:EyePosition())
        StartSoundEventFromPosition("HealthPen.Success01", player:EyePosition())
        StartSoundEventFromPosition("HealthPen.Success02", player:EyePosition())
        thisEntity:Kill()
    end
end
