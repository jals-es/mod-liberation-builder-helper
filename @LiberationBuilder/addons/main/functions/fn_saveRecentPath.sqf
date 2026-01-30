/*
 * Function: LBH_fnc_saveRecentPath
 * Description: Save a mission path to the recent paths list in profileNamespace
 *
 * Arguments:
 *   0: STRING - Path to save
 *
 * Return Value:
 *   BOOLEAN - True if saved successfully
 *
 * Example:
 *   ["D:\Arma3\Missions\kp_liberation.Altis"] call LBH_fnc_saveRecentPath;
 */

#include "..\script_component.hpp"

params [["_path", "", [""]]];

if (_path == "") exitWith {
    diag_log "[LBH] Cannot save empty path to recent paths";
    false
};

// Load current recent paths
private _recentPaths = profileNamespace getVariable ["LBH_recentMissionPaths", []];

// Ensure it's an array
if !(_recentPaths isEqualType []) then {
    _recentPaths = [];
};

// Remove this path if it already exists (to move it to top)
_recentPaths = _recentPaths - [_path];

// Add new path at the beginning
_recentPaths = [_path] + _recentPaths;

// Limit to 10 entries
if (count _recentPaths > 10) then {
    _recentPaths resize 10;
};

// Save back to profileNamespace
profileNamespace setVariable ["LBH_recentMissionPaths", _recentPaths];
saveProfileNamespace;

diag_log format ["[LBH] Saved path to recent: %1 (total: %2)", _path, count _recentPaths];

true
