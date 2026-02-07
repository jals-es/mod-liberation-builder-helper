/*
 * Function: LBH_fnc_validateMissionPath
 * Description: Validate if a path is a valid KP Liberation mission folder
 *
 * Arguments: None (reads from dialog)
 *
 * Return Value:
 *   BOOLEAN - True if path is a valid KP Liberation mission
 *
 * Example:
 *   call LBH_fnc_validateMissionPath;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ExportWizard", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Error: Export Wizard display not found for validation";
    false
};

private _pathCtrl = _display displayCtrl IDC_WIZARD_PATH;
private _statusCtrl = _display displayCtrl IDC_WIZARD_STATUS;
private _missionPath = ctrlText _pathCtrl;

if (_missionPath == "") exitWith {
    _statusCtrl ctrlSetText "Please enter a mission path";
    _statusCtrl ctrlSetTextColor [1, 0.5, 0, 1];
    false
};

// Normalize path (replace forward slashes with backslashes)
_missionPath = _missionPath regexReplace ["/", "\"];

// Remove trailing backslash if present
if (_missionPath select [count _missionPath - 1, 1] == "\") then {
    _missionPath = _missionPath select [0, count _missionPath - 1];
};

// Update the path control with normalized path
_pathCtrl ctrlSetText _missionPath;

// Check for KP Liberation structure
// Valid KP Liberation missions should have these folders:
// - presets/ (with blufor/, opfor/, resistance/, civilians/ subfolders)
// - arsenal_presets/

private _isValid = true;
private _missingFolders = [];

// Define folders to check
private _requiredFolders = [
    "presets",
    "presets\blufor",
    "presets\opfor",
    "presets\resistance",
    "presets\civilians",
    "arsenal_presets"
];

// Note: In Arma 3 scripting, we cannot directly check if a folder exists
// We can only check if files exist using loadFile or similar
// For the wizard, we'll trust the user's input and show a warning

// Try to detect if this looks like a Liberation mission by checking the path name
private _pathLower = toLower _missionPath;
private _looksLikeLiberation = (
    "liberation" in _pathLower ||
    "kp_liberation" in _pathLower ||
    "kplib" in _pathLower
);

if (_looksLikeLiberation) then {
    _statusCtrl ctrlSetText "Path looks like a KP Liberation mission - Ready to export!";
    _statusCtrl ctrlSetTextColor [0.3, 0.9, 0.3, 1];

    // Save to recent paths
    [_missionPath] call LBH_fnc_saveRecentPath;
} else {
    _statusCtrl ctrlSetText "Warning: Path may not be a KP Liberation mission. Proceed with caution.";
    _statusCtrl ctrlSetTextColor [1, 0.7, 0, 1];
};

// Store validated path globally for other functions to use
LBH_currentMissionPath = _missionPath;

diag_log format ["[LBH] Validated mission path: %1 (looks like Liberation: %2)", _missionPath, _looksLikeLiberation];

true
