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

// Restore last selected preset or select first
private _lastPreset = missionNamespace getVariable ["LBH_lastPreset", ""];
private _presetIndex = 0;
if (_lastPreset != "") then {
    for "_i" from 0 to (lbSize _presetCombo - 1) do {
        if ((_presetCombo lbData _i) isEqualTo _lastPreset) exitWith {
            _presetIndex = _i;
        };
    };
};
_presetCombo lbSetCurSel _presetIndex;

// Trigger preset change to populate categories (this will also restore category)
call LBH_fnc_onPresetChanged;

diag_log "[LBH] Management panel opened";
