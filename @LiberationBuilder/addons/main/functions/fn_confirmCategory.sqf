/*
 * Function: LBH_fnc_confirmCategory
 * Description: Confirm category selection and add objects
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_confirmCategory;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_CategorySelect", displayNull];
if (isNull _display) exitWith {};

private _list = _display displayCtrl IDC_CATSEL_LIST;
private _selIndex = lbCurSel _list;

if (_selIndex < 0) exitWith {
    closeDialog 0;
    ["No category selected!", "PLAIN", 2] call LBH_fnc_showNotification;
};

// Parse data (format: "preset|category")
private _data = _list lbData _selIndex;
private _parts = _data splitString "|";

if (count _parts != 2) exitWith {
    closeDialog 0;
    diag_log format ["[LBH] Invalid category data: %1", _data];
};

private _preset = _parts select 0;
private _category = _parts select 1;

// Close dialog
closeDialog 0;

// Add selected objects to this category
[_preset, _category] call LBH_fnc_addSelectedObjects;
