/*
 * Function: LBH_fnc_openPanel
 * Description: Open the main management panel
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_openPanel;
 */

#include "..\script_component.hpp"

// Close existing dialog if open
if (!isNull (uiNamespace getVariable ["LBH_MainPanel", displayNull])) exitWith {
    closeDialog 0;
};

// Create dialog
createDialog "LBH_MainPanel";

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];

if (isNull _display) exitWith {
    diag_log "[LBH] Failed to open management panel";
};

// Populate preset combo
private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
{
    private _presetName = _x;
    private _displayName = switch (_presetName) do {
        case "blufor": { "BLUFOR" };
        case "opfor": { "OPFOR" };
        case "resistance": { "Resistance" };
        case "civilians": { "Civilians" };
        case "arsenal": { "Arsenal" };
        default { _presetName };
    };
    _presetCombo lbAdd _displayName;
    _presetCombo lbSetData [lbSize _presetCombo - 1, _presetName];
} forEach LBH_presets;

// Select first preset
_presetCombo lbSetCurSel 0;

// Trigger preset change to populate categories
call LBH_fnc_onPresetChanged;

diag_log "[LBH] Management panel opened";
