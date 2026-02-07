/*
 * Function: LBH_fnc_removeSelected
 * Description: Remove the selected item from the list
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_removeSelected;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;
private _list = _display displayCtrl IDC_CLASSNAME_LIST;

// Get current selections
private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;
private _listIndex = lnbCurSelRow _list;

if (_presetIndex < 0 || _categoryIndex < 0 || _listIndex < 0) exitWith {
    ["No item selected!", 1, 2] call LBH_fnc_showNotification;
};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;
private _classname = _list lnbData [_listIndex, 0];

// Remove classname
[_preset, _category, _classname] call LBH_fnc_removeClassname;

// Refresh list
call LBH_fnc_refreshList;
