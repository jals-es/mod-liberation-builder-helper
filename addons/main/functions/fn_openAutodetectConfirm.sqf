/*
 * Function: LBH_fnc_openAutodetectConfirm
 * Description: Open the autodetect confirmation dialog and populate the list
 *
 * Arguments:
 *   0: ARRAY - Array of detected items [[classname, preset, category, formatType], ...]
 *
 * Return Value: None
 *
 * Example:
 *   [_detectedItems] call LBH_fnc_openAutodetectConfirm;
 */

#include "..\script_component.hpp"

params [["_items", [], [[]]]];

if (count _items == 0) exitWith {
    ["No items to confirm!", 1, 2] call LBH_fnc_showNotification;
};

// Store pending items globally
LBH_pendingAutodetect = _items;

// Create dialog
createDialog "LBH_AutodetectConfirm";

private _display = uiNamespace getVariable ["LBH_AutodetectConfirm", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Failed to open autodetect confirm dialog";
};

private _list = _display displayCtrl IDC_AUTODETECT_LIST;

// Clear and populate the list
lnbClear _list;

{
    _x params ["_classname", "_preset", "_category", "_formatType"];

    // Try to get display name from config
    private _displayName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
    if (_displayName isEqualTo "") then {
        _displayName = getText (configFile >> "CfgWeapons" >> _classname >> "displayName");
    };
    if (_displayName isEqualTo "") then {
        _displayName = getText (configFile >> "CfgMagazines" >> _classname >> "displayName");
    };
    if (_displayName isEqualTo "") then {
        _displayName = _classname;
    };

    // Get category display name
    private _categoryDisplay = _category;
    private _categories = LBH_categories getOrDefault [_preset, []];
    {
        if ((_x select 0) isEqualTo _category) exitWith {
            _categoryDisplay = _x select 1;
        };
    } forEach _categories;

    // Add row: DisplayName | Classname | Preset | Category
    private _rowIndex = _list lnbAddRow [_displayName, _classname, toUpper _preset, _categoryDisplay];
    _list lnbSetData [[_rowIndex, 0], str _forEachIndex];

    // Color code by preset
    private _color = switch (_preset) do {
        case "blufor": { [0.4, 0.6, 1, 1] };
        case "opfor": { [1, 0.4, 0.4, 1] };
        case "resistance": { [0.4, 0.9, 0.4, 1] };
        case "civilians": { [0.8, 0.4, 0.8, 1] };
        case "arsenal": { [1, 0.8, 0.3, 1] };
        default { [1, 1, 1, 1] };
    };
    _list lnbSetColor [[_rowIndex, 2], _color];

} forEach _items;

diag_log format ["[LBH] Opened autodetect confirm dialog with %1 items", count _items];
