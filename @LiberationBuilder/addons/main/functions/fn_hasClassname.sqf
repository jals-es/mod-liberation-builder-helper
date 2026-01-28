/*
 * Function: LBH_fnc_hasClassname
 * Description: Check if a classname already exists in a category
 *
 * Arguments:
 *   0: STRING - Preset name (blufor, opfor, etc.)
 *   1: STRING - Category name
 *   2: STRING - Classname to check
 *
 * Return Value:
 *   BOOLEAN - True if classname exists
 *
 * Example:
 *   ["blufor", "infantry_units", "B_Soldier_F"] call LBH_fnc_hasClassname;
 */

#include "..\script_component.hpp"

params [
    ["_preset", "", [""]],
    ["_category", "", [""]],
    ["_classname", "", [""]]
];

if (_preset isEqualTo "" || {_category isEqualTo ""} || {_classname isEqualTo ""}) exitWith {false};

private _presetData = LBH_data getOrDefault [_preset, createHashMap];
private _categoryData = _presetData getOrDefault [_category, []];

// Handle different data formats
if (_categoryData isEqualType "") then {
    // Single value format
    _categoryData isEqualTo _classname
} else {
    // Array format
    private _found = false;

    // Get format type for this category
    private _categories = LBH_categories getOrDefault [_preset, []];
    private _formatType = "simple";
    {
        if ((_x select 0) isEqualTo _category) exitWith {
            _formatType = _x select 2;
        };
    } forEach _categories;

    if (_formatType isEqualTo "cost") then {
        // Cost format: [[classname, s, a, f], ...]
        {
            if ((_x select 0) isEqualTo _classname) exitWith {
                _found = true;
            };
        } forEach _categoryData;
    } else {
        // Simple format: [classname, ...]
        _found = _classname in _categoryData;
    };

    _found
};
