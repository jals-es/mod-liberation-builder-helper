/*
 * Function: LBH_fnc_saveData
 * Description: Save current data to profileNamespace
 *
 * Arguments: None
 *
 * Return Value:
 *   Boolean - True if data was saved successfully
 *
 * Example:
 *   call LBH_fnc_saveData;
 */

#include "..\script_component.hpp"

profileNamespace setVariable ["LBH_savedData", LBH_data];
saveProfileNamespace;

diag_log "[LBH] Data saved to profile";

true
