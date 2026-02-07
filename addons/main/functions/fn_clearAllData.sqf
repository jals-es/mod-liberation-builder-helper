/*
 * Function: LBH_fnc_clearAllData
 * Description: Show confirmation dialog to clear all saved data from all presets
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_clearAllData;
 */

#include "..\script_component.hpp"

// Use 3DEN confirmation dialog
// The OK button will execute the actual clear function
[
    "This will delete ALL classnames from ALL presets (BLUFOR, OPFOR, Resistance, Civilians, Arsenal). This cannot be undone!",
    "Clear ALL Data?",
    [nil, {call LBH_fnc_doClearAllData;}],
    nil,
    "\A3\ui_f\data\map\markers\military\warning_CA.paa",
    findDisplay 313
] call BIS_fnc_3DENShowMessage;
