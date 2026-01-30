/*
 * Function: LBH_fnc_loadData
 * Description: Load saved data from profileNamespace
 *
 * Arguments: None
 *
 * Return Value:
 *   Boolean - True if data was loaded successfully
 *
 * Example:
 *   call LBH_fnc_loadData;
 */

#include "..\script_component.hpp"

private _savedData = profileNamespace getVariable ["LBH_savedData", createHashMap];

if (count _savedData > 0) then {
    LBH_data = _savedData;
    diag_log "[LBH] Data loaded from profile";
    ["Data loaded successfully", 0, 2] call LBH_fnc_showNotification;
    true
} else {
    diag_log "[LBH] No saved data found";
    ["No saved data found", 1, 2] call LBH_fnc_showNotification;
    false
};
