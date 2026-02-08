/*
 * Function: LBH_fnc_editCost
 * Description: Open cost dialog to edit an existing item's costs (double-click handler)
 *
 * Arguments: None (reads from UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_editCost;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;
private _list = _display displayCtrl IDC_CLASSNAME_LIST;

private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;
private _rowIndex = lnbCurSelRow _list;

if (_presetIndex < 0 || _categoryIndex < 0 || _rowIndex < 0) exitWith {};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;

// Check if this category uses cost format
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

// Only allow editing costs for "cost" format categories
if (_formatType != "cost") exitWith {};

// Get the classname from the list
private _classname = _list lnbData [_rowIndex, 0];
if (_classname isEqualTo "") exitWith {};

// Find current costs in data
private _presetData = LBH_data getOrDefault [_preset, createHashMap];
private _categoryData = _presetData getOrDefault [_category, []];

private _currentCosts = [0, 0, 0];
private _dataIndex = -1;
{
    if ((_x select 0) isEqualTo _classname) exitWith {
        _currentCosts = [_x select 1, _x select 2, _x select 3];
        _dataIndex = _forEachIndex;
    };
} forEach _categoryData;

if (_dataIndex < 0) exitWith {};

// Store pending edit data (with edit flag)
LBH_pendingCost = [_preset, _category, _classname];
LBH_pendingCostEdit = true;
LBH_pendingCostEditIndex = _dataIndex;

// Open cost dialog
createDialog "LBH_CostDialog";

// Fill in current values after dialog opens
[_classname, _currentCosts, _preset, _category] spawn {
    params ["_classname", "_costs", "_preset", "_category"];
    disableSerialization;

    waitUntil {!isNull (uiNamespace getVariable ["LBH_CostDialog", displayNull])};

    private _display = uiNamespace getVariable ["LBH_CostDialog", displayNull];
    if (isNull _display) exitWith {};

    // Set category label
    private _presetDisplay = toUpper _preset;
    private _categoryDisplay = _category;
    private _categories = LBH_categories getOrDefault [_preset, []];
    {
        if ((_x select 0) isEqualTo _category) exitWith {
            _categoryDisplay = _x select 1;
        };
    } forEach _categories;
    (_display displayCtrl IDC_COST_CATEGORY) ctrlSetText format ["Editing: %1 > %2", _presetDisplay, _categoryDisplay];

    // Set classname
    (_display displayCtrl IDC_COST_CLASSNAME) ctrlSetText _classname;

    // Set current costs
    (_display displayCtrl IDC_COST_SUPPLIES) ctrlSetText str (_costs select 0);
    (_display displayCtrl IDC_COST_AMMO) ctrlSetText str (_costs select 1);
    (_display displayCtrl IDC_COST_FUEL) ctrlSetText str (_costs select 2);
};

diag_log format ["[LBH] Editing cost for %1 in %2/%3 (index %4)", _classname, _preset, _category, _dataIndex];
