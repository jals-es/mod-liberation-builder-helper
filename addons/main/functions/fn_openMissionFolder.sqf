/*
 * Function: LBH_fnc_openMissionFolder
 * Description: Open the target folder for a preset in Windows Explorer
 *
 * Arguments:
 *   0: STRING - Preset name ("blufor", "opfor", "resistance", "civilians", "arsenal")
 *
 * Return Value:
 *   BOOLEAN - True if path is valid
 *
 * Example:
 *   ["blufor"] call LBH_fnc_openMissionFolder;
 */

#include "..\script_component.hpp"

params [["_preset", "", [""]]];

// Get the mission path from the wizard dialog
private _display = uiNamespace getVariable ["LBH_ExportWizard", displayNull];
if (isNull _display) exitWith {
    ["Export Wizard not open!", 1, 3] call LBH_fnc_showNotification;
    false
};

private _pathCtrl = _display displayCtrl IDC_WIZARD_PATH;
private _missionPath = ctrlText _pathCtrl;

if (_missionPath == "") exitWith {
    ["Please enter a mission path first!", 1, 3] call LBH_fnc_showNotification;
    false
};

// Determine the subfolder based on preset
private _subFolder = switch (_preset) do {
    case "blufor": { "presets\blufor" };
    case "opfor": { "presets\opfor" };
    case "resistance": { "presets\resistance" };
    case "civilians": { "presets\civilians" };
    case "arsenal": { "arsenal_presets" };
    default { "" };
};

if (_subFolder == "") exitWith {
    ["Invalid preset specified!", 1, 3] call LBH_fnc_showNotification;
    false
};

// Build full path
private _fullPath = _missionPath + "\" + _subFolder;

// Normalize path separators for Windows
_fullPath = _fullPath regexReplace ["/", "\"];

// Open folder in Windows Explorer using shellExecute
// Note: shellExecute is available in Arma 3 for opening URLs/files
// We use "explorer" to open the folder
"explorer" callExtension _fullPath;

// Alternative method using copyToClipboard and showing a hint
// Since shellExecute may not work in all cases, also copy path to clipboard
copyToClipboard _fullPath;

[format ["Path copied: %1", _fullPath], 0, 3] call LBH_fnc_showNotification;

diag_log format ["[LBH] Opening folder: %1", _fullPath];

true
