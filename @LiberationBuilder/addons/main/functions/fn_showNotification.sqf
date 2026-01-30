/*
 * Function: LBH_fnc_showNotification
 * Description: Show a notification to the user (3DEN or in-game)
 *
 * Arguments:
 *   0: STRING - Message to display
 *   1: NUMBER - Type (optional, default 0) - 0=Info, 1=Warning, 2=Error
 *   2: NUMBER - Duration in seconds (optional, default 3)
 *
 * Return Value: None
 *
 * Example:
 *   ["Classname added!", 0, 2] call LBH_fnc_showNotification;
 */

#include "..\script_component.hpp"

params [
    ["_message", "", [""]],
    ["_type", 0, [0]],
    ["_duration", 3, [0]]
];

if (_message isEqualTo "") exitWith {};

if (is3DEN) then {
    // 3DEN notification - types: 0=Info, 1=Warning, 2=Error
    [_message, _type, _duration] call BIS_fnc_3DENNotification;
} else {
    // In-game hint
    hint _message;

    // Auto-hide hint after duration
    [{hintSilent ""}, [], _duration] call CBA_fnc_waitAndExecute;
};
