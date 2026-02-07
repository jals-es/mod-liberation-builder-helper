/*
 * Function: LBH_fnc_exportCurrentCategory
 * Description: Export only the currently selected category to clipboard (no headers)
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value:
 *   BOOLEAN - True if successful
 *
 * Example:
 *   call LBH_fnc_exportCurrentCategory;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {
    ["Open the Management Panel first!", 1, 2] call LBH_fnc_showNotification;
    false
};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;

private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;

if (_presetIndex < 0 || _categoryIndex < 0) exitWith {
    ["No category selected!", 1, 2] call LBH_fnc_showNotification;
    false
};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;

// Get data for this category
private _presetData = LBH_data getOrDefault [_preset, createHashMap];
private _categoryData = _presetData getOrDefault [_category, []];

// Get format type
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
private _displayName = _category;
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _displayName = _x select 1;
        _formatType = _x select 2;
    };
} forEach _categories;

private _output = "";

switch (_formatType) do {
    case "cost": {
        _output = [_categoryData, _category] call LBH_fnc_formatCostArray;
    };
    case "simple": {
        _output = [_categoryData, _category] call LBH_fnc_formatSimpleArray;
    };
    case "single": {
        if (_categoryData isEqualType "" && {_categoryData != ""}) then {
            _output = format ["%1 = ""%2"";", _category, _categoryData];
        } else {
            _output = format ["%1 = """";", _category];
        };
    };
};

// Copy to clipboard
copyToClipboard _output;

private _itemCount = if (_formatType isEqualTo "single") then {
    if (_categoryData isEqualType "" && {_categoryData != ""}) then {1} else {0}
} else {
    count _categoryData
};

[format ["%1 copied to clipboard! (%2 items)", _displayName, _itemCount], 0, 3] call LBH_fnc_showNotification;

diag_log format ["[LBH] Exported category %1/%2 to clipboard (%3 items)", _preset, _category, _itemCount];

true
