/*
 * Function: LBH_fnc_confirmTextInput
 * Description: Handle OK button from text input dialog
 *
 * Arguments: None (uses UI controls and LBH_textInputCallback)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_confirmTextInput;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_TextInput", displayNull];
if (isNull _display) exitWith {};

// Get the input text
private _inputText = ctrlText (_display displayCtrl IDC_TEXT_INPUT_EDIT);

// Close dialog first
closeDialog 0;

// Execute callback if defined
if (!isNil "LBH_textInputCallback" && {LBH_textInputCallback isEqualType []}) then {
    private _callback = LBH_textInputCallback select 0;
    private _args = if (count LBH_textInputCallback > 1) then {LBH_textInputCallback select 1} else {[]};

    // Clear callback before executing
    LBH_textInputCallback = nil;

    // Execute callback with input text and args
    [_inputText, _args] call _callback;
};
