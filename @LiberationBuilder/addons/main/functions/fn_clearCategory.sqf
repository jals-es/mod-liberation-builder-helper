/*
 * Function: LBH_fnc_clearCategory
 * Description: Clear all items from the current category
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_clearCategory;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;

// Get current selections
private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;

if (_presetIndex < 0 || _categoryIndex < 0) exitWith {
    ["No category selected!", "PLAIN", 2] call LBH_fnc_showNotification;
};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;

// Get format type
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

// Clear category data
private _presetData = LBH_data getOrDefault [_preset, createHashMap];

switch (_formatType) do {
    case "single": {
        _presetData set [_category, ""];
    };
    default {
        _presetData set [_category, []];
    };
};

LBH_data set [_preset, _presetData];

// Save
call LBH_fnc_saveData;

// Refresh list
call LBH_fnc_refreshList;

[format ["Cleared: %1", _category], "PLAIN DOWN", 2] call LBH_fnc_showNotification;
