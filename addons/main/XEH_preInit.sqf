// Liberation Builder Helper - CBA Pre-Init
// Executed before mission init

#include "script_component.hpp"

// Initialize global variables
LBH_data = createHashMap;
LBH_initialized = false;
LBH_pendingCost = [];
LBH_pendingCostQueue = [];
LBH_importCurrentPreset = "";
LBH_importMode = "merge";

// Define preset structure
LBH_presets = [
    "blufor",
    "opfor",
    "resistance",
    "civilians",
    "arsenal"
];

// Define categories for each preset
LBH_categories = createHashMapFromArray [
    ["blufor", [
        ["infantry_units", "Infantry Units", "cost"],
        ["light_vehicles", "Light Vehicles", "cost"],
        ["heavy_vehicles", "Heavy Vehicles", "cost"],
        ["air_vehicles", "Air Vehicles", "cost"],
        ["static_vehicles", "Static Weapons", "cost"],
        ["buildings", "Buildings", "cost"],
        ["support_vehicles", "Support Vehicles", "cost"],
        ["blufor_squad_inf_light", "Squad (Light)", "simple"],
        ["blufor_squad_inf", "Squad (Infantry)", "simple"],
        ["blufor_squad_at", "Squad (AT)", "simple"],
        ["blufor_squad_aa", "Squad (AA)", "simple"],
        ["blufor_squad_recon", "Squad (Recon)", "simple"],
        ["blufor_squad_para", "Squad (Para)", "simple"],
        ["crewman_classname", "Crewman", "single"],
        ["pilot_classname", "Pilot", "single"],
        ["FOB_typename", "FOB Building", "single"],
        ["FOB_box_typename", "FOB Box", "single"],
        ["FOB_truck_typename", "FOB Truck", "single"],
        ["Arsenal_typename", "Arsenal Object", "single"],
        ["Respawn_truck_typename", "Respawn Truck", "single"],
        ["huron_typename", "Huron/Chinook", "single"],
        ["KP_liberation_little_bird_classname", "Little Bird", "single"],
        ["KP_liberation_boat_classname", "Boat", "single"],
        ["KP_liberation_truck_classname", "Truck", "single"]
    ]],
    ["opfor", [
        ["militia_squad", "Militia Squad", "simple"],
        ["militia_vehicles", "Militia Vehicles", "simple"],
        ["opfor_vehicles", "OPFOR Vehicles", "simple"],
        ["opfor_vehicles_low_intensity", "OPFOR Vehicles (Low)", "simple"],
        ["opfor_battlegroup_vehicles", "Battlegroup Vehicles", "simple"],
        ["opfor_battlegroup_vehicles_low_intensity", "Battlegroup (Low)", "simple"],
        ["opfor_troup_transports", "Troop Transports", "simple"],
        ["opfor_choppers", "Helicopters", "simple"],
        ["opfor_air", "Fixed-wing Aircraft", "simple"],
        ["opfor_arty", "Artillery", "simple"],
        ["opfor_static_aa", "Static AA", "simple"],
        ["opfor_radar", "Radar Systems", "simple"],
        ["opfor_ships", "Small Ships", "simple"],
        ["opfor_big_ships", "Large Ships", "simple"],
        ["elite_vehicles", "Elite Vehicles", "simple"],
        ["opfor_officer", "Officer", "single"],
        ["opfor_squad_leader", "Squad Leader", "single"],
        ["opfor_rifleman", "Rifleman", "single"],
        ["opfor_rpg", "RPG Soldier", "single"],
        ["opfor_medic", "Medic", "single"],
        ["opfor_sniper", "Sniper", "single"],
        ["opfor_grenadier", "Grenadier", "single"],
        ["opfor_machinegunner", "Machinegunner", "single"],
        ["opfor_heavygunner", "Heavy Gunner", "single"],
        ["opfor_marksman", "Marksman", "single"],
        ["opfor_sharpshooter", "Sharpshooter", "single"],
        ["opfor_aa", "AA Soldier", "single"],
        ["opfor_at", "AT Soldier", "single"],
        ["opfor_engineer", "Engineer", "single"],
        ["opfor_paratrooper", "Paratrooper", "single"],
        ["opfor_pilot", "Pilot", "single"],
        ["opfor_crew", "Crew", "single"]
    ]],
    ["resistance", [
        ["KP_liberation_guerilla_units", "Guerrilla Units", "simple"],
        ["KP_liberation_guerilla_vehicles", "Guerrilla Vehicles", "simple"],
        ["KP_liberation_guerilla_uniforms_1", "Uniforms (Tier 1)", "simple"],
        ["KP_liberation_guerilla_uniforms_2", "Uniforms (Tier 2)", "simple"],
        ["KP_liberation_guerilla_uniforms_3", "Uniforms (Tier 3)", "simple"],
        ["KP_liberation_guerilla_vests_1", "Vests (Tier 1)", "simple"],
        ["KP_liberation_guerilla_vests_2", "Vests (Tier 2)", "simple"],
        ["KP_liberation_guerilla_vests_3", "Vests (Tier 3)", "simple"],
        ["KP_liberation_guerilla_headgear_1", "Headgear (Tier 1)", "simple"],
        ["KP_liberation_guerilla_headgear_2", "Headgear (Tier 2)", "simple"],
        ["KP_liberation_guerilla_headgear_3", "Headgear (Tier 3)", "simple"],
        ["KP_liberation_guerilla_facegear", "Face Gear", "simple"]
    ]],
    ["civilians", [
        ["civilians", "Civilian Units", "simple"],
        ["civilian_vehicles", "Civilian Vehicles", "simple"]
    ]],
    ["arsenal", [
        ["GRLIB_arsenal_weapons", "Weapons", "simple"],
        ["GRLIB_arsenal_magazines", "Magazines", "simple"],
        ["GRLIB_arsenal_items", "Items", "simple"],
        ["GRLIB_arsenal_backpacks", "Backpacks", "simple"]
    ]]
];

// Initialize data storage
call LBH_fnc_init;

// Register keybind when in 3DEN editor
if (is3DEN) then {
    // Use spawn to ensure display is ready
    [] spawn {
        // Small delay to ensure display is fully initialized
        sleep 0.5;

        private _display = findDisplay 313;

        if (!isNull _display && isNil "LBH_keybindRegistered") then {
            LBH_keybindRegistered = true;

            _display displayAddEventHandler ["KeyDown", {
                params ["_display", "_key", "_shift", "_ctrl", "_alt"];
                // DIK_L = 0x26 (38), Ctrl+Shift+L
                if (_key == 0x26 && _ctrl && _shift && !_alt) then {
                    private _panelDisplay = uiNamespace getVariable ["LBH_MainPanel", displayNull];
                    if (isNull _panelDisplay) then {
                        call LBH_fnc_openPanel;
                    } else {
                        closeDialog 0;
                    };
                    true
                } else {
                    false
                };
            }];

            // Show welcome notification
            ["Liberation Builder Helper loaded. Press Ctrl+Shift+L to open panel.", 0, 3] call BIS_fnc_3DENNotification;
        };
    };
};

diag_log "[LBH] PreInit completed";
