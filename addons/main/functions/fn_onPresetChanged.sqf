/*
 * Function: LBH_fnc_onPresetChanged
 * Description: Handle preset combo selection change
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_onPresetChanged;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;

// Get selected preset
private _selIndex = lbCurSel _presetCombo;
if (_selIndex < 0) exitWith {};

private _preset = _presetCombo lbData _selIndex;

// Save last selected preset
missionNamespace setVariable ["LBH_lastPreset", _preset];

// Clear and populate category combo
lbClear _categoryCombo;

private _categories = _preset call LBH_fnc_getCategories;
{
    _x params ["_key", "_displayName", "_format"];
    _categoryCombo lbAdd _displayName;
    _categoryCombo lbSetData [lbSize _categoryCombo - 1, _key];

    // Add format indicator
    private _tooltip = switch (_format) do {
        case "cost": { "Cost format: [classname, supplies, ammo, fuel]" };
        case "simple": { "Simple format: array of classnames" };
        case "single": { "Single value" };
        default { "" };
    };
    _categoryCombo lbSetTooltip [lbSize _categoryCombo - 1, _tooltip];
} forEach _categories;

// Restore last selected category for this preset, or select first
private _lastCategory = missionNamespace getVariable ["LBH_lastCategory_" + _preset, ""];
private _categoryIndex = 0;
if (_lastCategory != "") then {
    for "_i" from 0 to (lbSize _categoryCombo - 1) do {
        if ((_categoryCombo lbData _i) isEqualTo _lastCategory) exitWith {
            _categoryIndex = _i;
        };
    };
};
if (lbSize _categoryCombo > 0) then {
    _categoryCombo lbSetCurSel _categoryIndex;
};

// Refresh list
call LBH_fnc_onCategoryChanged;
