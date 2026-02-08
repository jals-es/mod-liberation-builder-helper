/*
 * Function: LBH_fnc_openImportWizard
 * Description: Initialize the Import Wizard dialog controls
 *
 * Arguments: None (called from dialog onLoad)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_openImportWizard;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ImportWizard", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Error: Import Wizard display not found";
};

// Refresh item counts
call LBH_fnc_refreshImportCounts;

diag_log "[LBH] Import Wizard initialized";
