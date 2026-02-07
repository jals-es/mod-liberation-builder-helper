/*
 * Function: LBH_fnc_onRecentPathSelected
 * Description: Handle selection of a recent path from the dropdown
 *
 * Arguments: None (called from dialog event)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_onRecentPathSelected;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ExportWizard", displayNull];
if (isNull _display) exitWith {};

private _recentCtrl = _display displayCtrl IDC_WIZARD_RECENT;
private _pathCtrl = _display displayCtrl IDC_WIZARD_PATH;

private _selectedIndex = lbCurSel _recentCtrl;

// Skip if first item (placeholder) is selected
if (_selectedIndex <= 0) exitWith {};

private _selectedPath = _recentCtrl lbText _selectedIndex;

// Set the path in the edit field
_pathCtrl ctrlSetText _selectedPath;

// Auto-validate the path
call LBH_fnc_validateMissionPath;

diag_log format ["[LBH] Selected recent path: %1", _selectedPath];
