/*
 * Function: LBH_fnc_addClassname
 * Description: Add a classname to a category with the appropriate format
 *
 * Arguments:
 *   0: STRING - Preset name (blufor, opfor, etc.)
 *   1: STRING - Category name
 *   2: STRING - Classname to add
 *   3: ARRAY - Cost values [supplies, ammo, fuel] (optional, for cost format)
 *
 * Return Value:
 *   BOOLEAN - True if added successfully
 *
 * Example:
 *   ["blufor", "infantry_units", "B_Soldier_F", [10, 0, 0]] call LBH_fnc_addClassname;
 *   ["opfor", "militia_squad", "O_Soldier_F"] call LBH_fnc_addClassname;
 */

#include "..\script_component.hpp"

params [
    ["_preset", "", [""]],
    ["_category", "", [""]],
    ["_classname", "", [""]],
    ["_costs", [0, 0, 0], [[]]]
];

if (_preset isEqualTo "" || {_category isEqualTo ""} || {_classname isEqualTo ""}) exitWith {
    diag_log "[LBH] addClassname: Invalid parameters";
    false
};

// Check if already exists (allow duplicates for opfor and resistance presets)
if !(_preset in ["opfor", "resistance"]) then {
    if ([_preset, _category, _classname] call LBH_fnc_hasClassname) exitWith {
        diag_log format ["[LBH] Classname %1 already exists in %2/%3", _classname, _preset, _category];
        [format ["Classname %1 already exists!", _classname], 1, 2] call LBH_fnc_showNotification;
        false
    };
};

// Ensure preset exists
if !(_preset in LBH_data) then {
    LBH_data set [_preset, createHashMap];
};

private _presetData = LBH_data get _preset;

// Get format type for this category
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

switch (_formatType) do {
    case "cost": {
        // Cost format: [[classname, supplies, ammo, fuel], ...]
        private _categoryData = _presetData getOrDefault [_category, []];
        _costs params [
            ["_supplies", 0, [0]],
            ["_ammo", 0, [0]],
            ["_fuel", 0, [0]]
        ];
        _categoryData pushBack [_classname, _supplies, _ammo, _fuel];
        _presetData set [_category, _categoryData];
    };

    case "simple": {
        // Simple format: [classname, ...]
        private _categoryData = _presetData getOrDefault [_category, []];
        _categoryData pushBack _classname;
        _presetData set [_category, _categoryData];
    };

    case "single": {
        // Single value format
        _presetData set [_category, _classname];
    };
};

LBH_data set [_preset, _presetData];

// Auto-save
call LBH_fnc_saveData;

diag_log format ["[LBH] Added %1 to %2/%3", _classname, _preset, _category];
[format ["Added: %1", _classname], 0, 1.5] call LBH_fnc_showNotification;

true
