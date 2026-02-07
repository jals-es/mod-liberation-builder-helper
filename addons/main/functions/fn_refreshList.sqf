/*
 * Function: LBH_fnc_refreshList
 * Description: Refresh the classname list in the management panel
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_refreshList;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;
private _searchEdit = _display displayCtrl IDC_SEARCH_EDIT;
private _list = _display displayCtrl IDC_CLASSNAME_LIST;
private _statusText = _display displayCtrl IDC_STATUS_TEXT;

// Get current selections
private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;

if (_presetIndex < 0 || _categoryIndex < 0) exitWith {
    lnbClear _list;
    _statusText ctrlSetText "No category selected";
};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;
private _searchText = toLower (ctrlText _searchEdit);

// Clear list
lnbClear _list;

// Get data for this category
private _presetData = LBH_data getOrDefault [_preset, createHashMap];
private _categoryData = _presetData getOrDefault [_category, []];

// Get format type
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

private _itemCount = 0;

switch (_formatType) do {
    case "cost": {
        // Cost format: [[classname, supplies, ammo, fuel], ...]
        {
            _x params ["_classname", "_supplies", "_ammo", "_fuel"];

            // Apply search filter
            if (_searchText != "" && {!(_searchText in toLower _classname)}) then {
                continue;
            };

            private _rowIndex = _list lnbAddRow [_classname, str _supplies, str _ammo, str _fuel];
            _list lnbSetData [[_rowIndex, 0], _classname];
            _itemCount = _itemCount + 1;
        } forEach _categoryData;
    };

    case "simple": {
        // Simple format: [classname, ...]
        {
            private _classname = _x;

            // Skip empty entries
            if (_classname isEqualTo "") then {
                continue;
            };

            // Apply search filter
            if (_searchText != "" && {!(_searchText in toLower _classname)}) then {
                continue;
            };

            private _rowIndex = _list lnbAddRow [_classname, "-", "-", "-"];
            _list lnbSetData [[_rowIndex, 0], _classname];
            _itemCount = _itemCount + 1;
        } forEach _categoryData;
    };

    case "single": {
        // Single value format
        private _classname = _categoryData;
        if (_classname isEqualType "" && {_classname != ""}) then {
            // Apply search filter
            if (_searchText == "" || {_searchText in toLower _classname}) then {
                private _rowIndex = _list lnbAddRow [_classname, "-", "-", "-"];
                _list lnbSetData [[_rowIndex, 0], _classname];
                _itemCount = 1;
            };
        };
    };
};

// Update status
_statusText ctrlSetText format ["%1 items in %2", _itemCount, _category];
