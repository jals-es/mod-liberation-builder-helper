/*
 * Function: LBH_fnc_openCostDialog
 * Description: Open the cost input dialog for a classname
 *
 * Arguments:
 *   0: STRING - Preset name
 *   1: STRING - Category name
 *   2: STRING - Classname
 *
 * Return Value: None
 *
 * Example:
 *   ["blufor", "infantry_units", "B_Soldier_F"] call LBH_fnc_openCostDialog;
 */

#include "..\script_component.hpp"

params [
    ["_preset", "", [""]],
    ["_category", "", [""]],
    ["_classname", "", [""]]
];

if (_preset isEqualTo "" || {_category isEqualTo ""} || {_classname isEqualTo ""}) exitWith {
    diag_log "[LBH] openCostDialog: Invalid parameters";
};

// Store pending data
LBH_pendingCost = [_preset, _category, _classname];

// Create dialog
createDialog "LBH_CostDialog";

private _display = uiNamespace getVariable ["LBH_CostDialog", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Failed to open cost dialog";
};

// Set category display (Adding to: PRESET > CATEGORY)
private _presetDisplay = toUpper _preset;
private _categoryDisplay = _category;
// Try to get display name from categories
private _categories = LBH_categories getOrDefault [_preset, []];
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _categoryDisplay = _x select 1;
    };
} forEach _categories;
(_display displayCtrl IDC_COST_CATEGORY) ctrlSetText format ["Adding to: %1 > %2", _presetDisplay, _categoryDisplay];

// Set classname display
(_display displayCtrl IDC_COST_CLASSNAME) ctrlSetText _classname;

// Reset cost fields
(_display displayCtrl IDC_COST_SUPPLIES) ctrlSetText "0";
(_display displayCtrl IDC_COST_AMMO) ctrlSetText "0";
(_display displayCtrl IDC_COST_FUEL) ctrlSetText "0";
