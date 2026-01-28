/*
 * Function: LBH_fnc_showNotification
 * Description: Show a notification to the user (3DEN or in-game)
 *
 * Arguments:
 *   0: STRING - Message to display
 *   1: STRING - Type (optional, default "PLAIN")
 *   2: NUMBER - Duration in seconds (optional, default 3)
 *
 * Return Value: None
 *
 * Example:
 *   ["Classname added!", "PLAIN", 2] call LBH_fnc_showNotification;
 */

#include "..\script_component.hpp"

params [
    ["_message", "", [""]],
    ["_type", "PLAIN", [""]],
    ["_duration", 3, [0]]
];

if (_message isEqualTo "") exitWith {};

if (is3DEN) then {
    // 3DEN notification
    [_message, _type, _duration] call BIS_fnc_3DENNotification;
} else {
    // In-game hint
    hint _message;

    // Auto-hide hint after duration
    [{hintSilent ""}, [], _duration] call CBA_fnc_waitAndExecute;
};
