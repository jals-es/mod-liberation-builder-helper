/*
 * Function: LBH_fnc_removeClassname
 * Description: Remove a classname from a category
 *
 * Arguments:
 *   0: STRING - Preset name (blufor, opfor, etc.)
 *   1: STRING - Category name
 *   2: STRING - Classname to remove
 *
 * Return Value:
 *   BOOLEAN - True if removed successfully
 *
 * Example:
 *   ["blufor", "infantry_units", "B_Soldier_F"] call LBH_fnc_removeClassname;
 */

#include "..\script_component.hpp"

params [
    ["_preset", "", [""]],
    ["_category", "", [""]],
    ["_classname", "", [""]]
];

if (_preset isEqualTo "" || {_category isEqualTo ""} || {_classname isEqualTo ""}) exitWith {
    diag_log "[LBH] removeClassname: Invalid parameters";
    false
};

if !(_preset in LBH_data) exitWith {
    diag_log format ["[LBH] Preset %1 not found", _preset];
    false
};

private _presetData = LBH_data get _preset;

if !(_category in _presetData) exitWith {
    diag_log format ["[LBH] Category %1 not found in %2", _category, _preset];
    false
};

// Get format type for this category
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

private _removed = false;

switch (_formatType) do {
    case "cost": {
        // Cost format: [[classname, supplies, ammo, fuel], ...]
        private _categoryData = _presetData get _category;
        private _index = -1;
        {
            if ((_x select 0) isEqualTo _classname) exitWith {
                _index = _forEachIndex;
            };
        } forEach _categoryData;

        if (_index >= 0) then {
            _categoryData deleteAt _index;
            _presetData set [_category, _categoryData];
            _removed = true;
        };
    };

    case "simple": {
        // Simple format: [classname, ...]
        private _categoryData = _presetData get _category;
        private _index = _categoryData find _classname;
        if (_index >= 0) then {
            _categoryData deleteAt _index;
            _presetData set [_category, _categoryData];
            _removed = true;
        };
    };

    case "single": {
        // Single value format - clear it
        if ((_presetData get _category) isEqualTo _classname) then {
            _presetData set [_category, ""];
            _removed = true;
        };
    };
};

if (_removed) then {
    LBH_data set [_preset, _presetData];
    call LBH_fnc_saveData;
    diag_log format ["[LBH] Removed %1 from %2/%3", _classname, _preset, _category];
    [format ["Removed: %1", _classname], 0, 1.5] call LBH_fnc_showNotification;
};

_removed
