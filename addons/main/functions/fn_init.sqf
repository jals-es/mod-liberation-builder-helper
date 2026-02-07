/*
 * Function: LBH_fnc_init
 * Description: Initialize the Liberation Builder Helper data structure
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_init;
 */

#include "..\script_component.hpp"

// Try to load existing data from profileNamespace
private _savedData = profileNamespace getVariable ["LBH_savedData", createHashMap];

if (count _savedData > 0) then {
    LBH_data = _savedData;
    diag_log "[LBH] Loaded existing data from profile";
} else {
    // Initialize empty data structure
    LBH_data = createHashMapFromArray [
        ["blufor", createHashMapFromArray [
            ["infantry_units", []],
            ["light_vehicles", []],
            ["heavy_vehicles", []],
            ["air_vehicles", []],
            ["static_vehicles", []],
            ["buildings", []],
            ["support_vehicles", []],
            ["blufor_squad_inf_light", []],
            ["blufor_squad_inf", []],
            ["blufor_squad_at", []],
            ["blufor_squad_aa", []],
            ["blufor_squad_recon", []],
            ["blufor_squad_para", []],
            ["crewman_classname", ""],
            ["pilot_classname", ""],
            ["FOB_typename", ""],
            ["FOB_box_typename", ""],
            ["FOB_truck_typename", ""],
            ["Arsenal_typename", ""],
            ["Respawn_truck_typename", ""],
            ["huron_typename", ""],
            ["KP_liberation_little_bird_classname", ""],
            ["KP_liberation_boat_classname", ""],
            ["KP_liberation_truck_classname", ""]
        ]],
        ["opfor", createHashMapFromArray [
            ["militia_squad", []],
            ["militia_vehicles", []],
            ["opfor_vehicles", []],
            ["opfor_vehicles_low_intensity", []],
            ["opfor_battlegroup_vehicles", []],
            ["opfor_battlegroup_vehicles_low_intensity", []],
            ["opfor_troup_transports", []],
            ["opfor_choppers", []],
            ["opfor_air", []],
            ["opfor_arty", []],
            ["opfor_static_aa", []],
            ["opfor_radar", []],
            ["opfor_ships", []],
            ["opfor_big_ships", []],
            ["elite_vehicles", []],
            ["opfor_officer", ""],
            ["opfor_squad_leader", ""],
            ["opfor_rifleman", ""],
            ["opfor_rpg", ""],
            ["opfor_medic", ""],
            ["opfor_sniper", ""],
            ["opfor_grenadier", ""],
            ["opfor_machinegunner", ""],
            ["opfor_heavygunner", ""],
            ["opfor_marksman", ""],
            ["opfor_sharpshooter", ""],
            ["opfor_aa", ""],
            ["opfor_at", ""],
            ["opfor_engineer", ""],
            ["opfor_paratrooper", ""],
            ["opfor_pilot", ""],
            ["opfor_crew", ""]
        ]],
        ["resistance", createHashMapFromArray [
            ["KP_liberation_guerilla_units", []],
            ["KP_liberation_guerilla_vehicles", []],
            ["KP_liberation_guerilla_uniforms_1", []],
            ["KP_liberation_guerilla_uniforms_2", []],
            ["KP_liberation_guerilla_uniforms_3", []],
            ["KP_liberation_guerilla_vests_1", []],
            ["KP_liberation_guerilla_vests_2", []],
            ["KP_liberation_guerilla_vests_3", []],
            ["KP_liberation_guerilla_headgear_1", []],
            ["KP_liberation_guerilla_headgear_2", []],
            ["KP_liberation_guerilla_headgear_3", []],
            ["KP_liberation_guerilla_facegear", []]
        ]],
        ["civilians", createHashMapFromArray [
            ["civilians", []],
            ["civilian_vehicles", []]
        ]],
        ["arsenal", createHashMapFromArray [
            ["GRLIB_arsenal_weapons", []],
            ["GRLIB_arsenal_magazines", []],
            ["GRLIB_arsenal_items", []],
            ["GRLIB_arsenal_backpacks", []]
        ]]
    ];
    diag_log "[LBH] Initialized new data structure";
};

true
