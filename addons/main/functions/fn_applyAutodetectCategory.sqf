/*
 * Function: LBH_fnc_applyAutodetectCategory
 * Description: Apply selected category to the selected item in autodetect list
 *
 * Arguments: None
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
    ["Select an item first!", 1, 2] call LBH_fnc_showNotification;
};

private _selectedCombo = lbCurSel _combo;
if (_selectedCombo < 0) exitWith {
    ["Select a category!", 1, 2] call LBH_fnc_showNotification;
};

// Get new category data
private _newCategoryId = _combo lbData _selectedCombo;
private _newCategoryDisplay = _combo lbText _selectedCombo;

// Update the pending item
private _items = LBH_pendingAutodetect;
if (_selectedRow >= count _items) exitWith {};

private _item = _items select _selectedRow;
_item params ["_classname", "_preset", "_oldCategory", "_formatType"];

// Get the format type for the new category
private _categories = LBH_categories getOrDefault [_preset, []];
private _newFormatType = _formatType;
{
    if ((_x select 0) isEqualTo _newCategoryId) exitWith {
        _newFormatType = _x select 2;
    };
} forEach _categories;

// Update the item in the array
_items set [_selectedRow, [_classname, _preset, _newCategoryId, _newFormatType]];
LBH_pendingAutodetect = _items;

// Update the list display
_list lnbSetText [[_selectedRow, 3], _newCategoryDisplay];

["Category updated!", 0, 1] call LBH_fnc_showNotification;
