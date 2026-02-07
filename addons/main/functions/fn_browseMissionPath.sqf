/*
 * Function: LBH_fnc_browseMissionPath
 * Description: Show instructions for browsing mission path (Arma 3 has no native folder browser)
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Note: Arma 3 does not have a native folder browser dialog.
 * This function shows instructions and copies a hint to clipboard.
 *
 * Example:
 *   call LBH_fnc_browseMissionPath;
 */

#include "..\script_component.hpp"

// Arma 3 doesn't have a native folder browser dialog
// Show a helpful message and copy an example path

private _examplePath = "C:\Users\YourName\Documents\Arma 3\missions\kp_liberation.Altis";
copyToClipboard _examplePath;

["No folder browser in Arma 3. Example path copied to clipboard - edit as needed.", 0, 5] call LBH_fnc_showNotification;

diag_log "[LBH] Browse button clicked - showing instructions";
