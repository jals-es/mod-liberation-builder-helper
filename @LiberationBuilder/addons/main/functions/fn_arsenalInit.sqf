/*
 * Function: LBH_fnc_arsenalInit
 * Description: Initialize ACE Arsenal integration
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_arsenalInit;
 */

#include "..\script_component.hpp"

// Check if ACE Arsenal is loaded
if !(isClass (configFile >> "CfgPatches" >> "ace_arsenal")) exitWith {
    diag_log "[LBH] ACE Arsenal not found, skipping integration";
};

// Add event handler for arsenal opened
["ace_arsenal_displayOpened", {
    params ["_display"];

    diag_log "[LBH] ACE Arsenal opened, adding export button";

    // Wait a frame for arsenal to fully initialize
    [{
        params ["_display"];

        // Try to add custom button to the arsenal
        // ACE Arsenal uses right panel buttons
        private _buttonPanel = _display displayCtrl 911; // Right panel

        if (isNull _buttonPanel) exitWith {
            diag_log "[LBH] Could not find arsenal button panel";
        };

        // Create a hint message instead of modifying ACE directly
        // This is more compatible approach
        hint "Liberation Builder Helper active.\nUse 'Export Loadout' to export items.";
        [{hintSilent ""}, [], 3] call CBA_fnc_waitAndExecute;

    }, [_display], 0.1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

// Add keybind for arsenal export (Ctrl+Shift+E)
["Liberation Builder Helper", "LBH_ArsenalExport", "Export Arsenal Loadout", {
    // Check if in arsenal
    if (isNull (uiNamespace getVariable ["ace_arsenal_display", displayNull])) exitWith {false};

    call LBH_fnc_arsenalExport;
    true
}, {}, [0x12, [true, true, false]]] call CBA_fnc_addKeybind; // E key with Ctrl+Shift

diag_log "[LBH] ACE Arsenal integration initialized";
