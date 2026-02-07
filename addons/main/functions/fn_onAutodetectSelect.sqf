/*
 * Function: LBH_fnc_onAutodetectSelect
 * Description: Called when a row is selected in the autodetect list, populates the category combo
 *
 * Arguments: None (uses event handler params)
 *
 * Return Value: None
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_AutodetectConfirm", displayNull];
if (isNull _display) exitWith {};

private _list = _display displayCtrl IDC_AUTODETECT_LIST;
private _combo = _display displayCtrl IDC_AUTODETECT_CATEGORY_COMBO;

private _selectedRow = lnbCurSelRow _list;
if (_selectedRow < 0) exitWith {
    lbClear _combo;
};

// Get the selected item's data
private _items = LBH_pendingAutodetect;
if (_selectedRow >= count _items) exitWith {};

private _item = _items select _selectedRow;
_item params ["_classname", "_preset", "_currentCategory", "_formatType"];

// Clear and populate combo with categories for this preset
lbClear _combo;

private _categories = LBH_categories getOrDefault [_preset, []];
private _selectedIndex = 0;

{
    _x params ["_catId", "_catDisplay", "_catFormat"];
    private _idx = _combo lbAdd _catDisplay;
    _combo lbSetData [_idx, _catId];

    // Select current category
    if (_catId isEqualTo _currentCategory) then {
        _selectedIndex = _idx;
    };
} forEach _categories;

_combo lbSetCurSel _selectedIndex;
