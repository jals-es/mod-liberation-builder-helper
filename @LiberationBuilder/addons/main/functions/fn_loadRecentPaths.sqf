/*
 * Function: LBH_fnc_loadRecentPaths
 * Description: Load recent mission paths from profileNamespace
 *
 * Arguments: None
 *
 * Return Value:
 *   ARRAY - Array of recent path strings (max 10)
 *
 * Example:
 *   private _paths = call LBH_fnc_loadRecentPaths;
 */

#include "..\script_component.hpp"

private _recentPaths = profileNamespace getVariable ["LBH_recentMissionPaths", []];

// Ensure it's an array
if !(_recentPaths isEqualType []) then {
    _recentPaths = [];
};

// Filter out empty strings and duplicates
_recentPaths = _recentPaths select {_x isEqualType "" && {_x != ""}};
_recentPaths = _recentPaths arrayIntersect _recentPaths;

// Limit to 10 entries
if (count _recentPaths > 10) then {
    _recentPaths resize 10;
};

diag_log format ["[LBH] Loaded %1 recent paths", count _recentPaths];

_recentPaths
