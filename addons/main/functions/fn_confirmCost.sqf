/*
 * Function: LBH_fnc_confirmCost
 * Description: Confirm and add classname with specified costs
 *
 * Arguments: None (uses UI controls and LBH_pendingCost)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_confirmCost;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_CostDialog", displayNull];
if (isNull _display) exitWith {};

if (count LBH_pendingCost == 0) exitWith {
    closeDialog 0;
    diag_log "[LBH] confirmCost: No pending cost data";
};

// Get pending data
LBH_pendingCost params ["_preset", "_category", "_classname"];

// Get cost values from dialog
private _supplies = parseNumber (ctrlText (_display displayCtrl IDC_COST_SUPPLIES));
private _ammo = parseNumber (ctrlText (_display displayCtrl IDC_COST_AMMO));
private _fuel = parseNumber (ctrlText (_display displayCtrl IDC_COST_FUEL));

// Validate (ensure non-negative)
_supplies = _supplies max 0;
_ammo = _ammo max 0;
_fuel = _fuel max 0;

// Check if this is an edit or a new addition
private _isEdit = !isNil "LBH_pendingCostEdit" && {LBH_pendingCostEdit};

if (_isEdit) then {
    // Edit mode: update existing item in-place
    private _editIndex = LBH_pendingCostEditIndex;
    private _presetData = LBH_data getOrDefault [_preset, createHashMap];
    private _categoryData = _presetData getOrDefault [_category, []];

    if (_editIndex >= 0 && {_editIndex < count _categoryData}) then {
        _categoryData set [_editIndex, [_classname, _supplies, _ammo, _fuel]];
        _presetData set [_category, _categoryData];
        LBH_data set [_preset, _presetData];
        call LBH_fnc_saveData;
        diag_log format ["[LBH] Updated costs for %1: [%2, %3, %4]", _classname, _supplies, _ammo, _fuel];
        [format ["Updated: %1", _classname], 0, 1.5] call LBH_fnc_showNotification;
    };

    LBH_pendingCostEdit = nil;
    LBH_pendingCostEditIndex = nil;
} else {
    // Add mode: add new classname with costs
    [_preset, _category, _classname, [_supplies, _ammo, _fuel]] call LBH_fnc_addClassname;
};

// Clear current pending data
LBH_pendingCost = [];

// Check if there are more items in the queue
private _hasMoreItems = false;
private _nextData = [];

if (!isNil "LBH_pendingCostQueue" && {LBH_pendingCostQueue isEqualType []} && {count LBH_pendingCostQueue > 0}) then {
    // Remove the first item (we just processed it)
    LBH_pendingCostQueue deleteAt 0;

    // Check if there are more items
    if (count LBH_pendingCostQueue > 0) then {
        _hasMoreItems = true;
        _nextData = LBH_pendingCostQueue select 0;
    } else {
        // Queue is empty
        LBH_pendingCostQueue = [];
    };
};

// Close dialog
closeDialog 0;

// Process next item if any
if (_hasMoreItems) then {
    _nextData params ["_nextPreset", "_nextCategory", "_nextClassname"];
    LBH_pendingCost = [_nextPreset, _nextCategory, _nextClassname];

    // Spawn to wait for dialog to close then open next one
    [_nextClassname] spawn {
        params ["_cls"];

        // Wait for current dialog to close
        waitUntil {isNull (uiNamespace getVariable ["LBH_CostDialog", displayNull])};
        sleep 0.05;

        // Open new dialog
        createDialog "LBH_CostDialog";

        // Wait for new dialog to open
        waitUntil {!isNull (uiNamespace getVariable ["LBH_CostDialog", displayNull])};

        private _newDisplay = uiNamespace getVariable ["LBH_CostDialog", displayNull];
        if (!isNull _newDisplay) then {
            (_newDisplay displayCtrl IDC_COST_CLASSNAME) ctrlSetText _cls;
            (_newDisplay displayCtrl IDC_COST_SUPPLIES) ctrlSetText "0";
            (_newDisplay displayCtrl IDC_COST_AMMO) ctrlSetText "0";
            (_newDisplay displayCtrl IDC_COST_FUEL) ctrlSetText "0";
        };

        diag_log format ["[LBH] Opened cost dialog for next item: %1", _cls];
    };
} else {
    if (!isNil "LBH_pendingCostQueue" && {LBH_pendingCostQueue isEqualType []} && {count LBH_pendingCostQueue == 0}) then {
        ["All items added!", 0, 2] call LBH_fnc_showNotification;
    };
};

// Refresh main panel list if open
call LBH_fnc_refreshList;
