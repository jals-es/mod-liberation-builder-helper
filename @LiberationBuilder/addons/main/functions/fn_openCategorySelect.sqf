/*
 * Function: LBH_fnc_openCategorySelect
 * Description: Open category selection dialog for context menu
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_openCategorySelect;
 */

#include "..\script_component.hpp"

// Get selected objects
private _selected = get3DENSelected "object";
if (count _selected == 0) exitWith {
    ["No objects selected!", "PLAIN", 2] call LBH_fnc_showNotification;
};

// Create dialog
createDialog "LBH_CategorySelect";

private _display = uiNamespace getVariable ["LBH_CategorySelect", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Failed to open category select dialog";
};

private _list = _display displayCtrl IDC_CATSEL_LIST;
lbClear _list;

// Populate with all presets and categories
{
    private _preset = _x;
    private _presetDisplayName = switch (_preset) do {
        case "blufor": { "BLUFOR" };
        case "opfor": { "OPFOR" };
        case "resistance": { "Resistance" };
        case "civilians": { "Civilians" };
        case "arsenal": { "Arsenal" };
        default { _preset };
    };

    private _categories = _preset call LBH_fnc_getCategories;
    {
        _x params ["_key", "_displayName", "_format"];
        private _fullDisplay = format ["%1 > %2", _presetDisplayName, _displayName];
        private _index = _list lbAdd _fullDisplay;
        _list lbSetData [_index, format ["%1|%2", _preset, _key]];
    } forEach _categories;
} forEach LBH_presets;

// Select first item
if (lbSize _list > 0) then {
    _list lbSetCurSel 0;
};
