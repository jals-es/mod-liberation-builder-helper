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

// Close dialog
closeDialog 0;

// Add classname with costs
[_preset, _category, _classname, [_supplies, _ammo, _fuel]] call LBH_fnc_addClassname;

// Clear pending data
LBH_pendingCost = [];

// Refresh main panel list if open
call LBH_fnc_refreshList;
