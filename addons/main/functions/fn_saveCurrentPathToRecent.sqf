/*
 * Function: LBH_fnc_saveCurrentPathToRecent
 * Description: Save the current mission path from the wizard to recent paths
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_saveCurrentPathToRecent;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ExportWizard", displayNull];
if (isNull _display) exitWith {};

private _pathCtrl = _display displayCtrl IDC_WIZARD_PATH;
private _missionPath = ctrlText _pathCtrl;

if (_missionPath != "") then {
    [_missionPath] call LBH_fnc_saveRecentPath;
};
