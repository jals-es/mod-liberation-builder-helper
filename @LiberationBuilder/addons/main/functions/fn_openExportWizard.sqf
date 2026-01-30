/*
 * Function: LBH_fnc_openExportWizard
 * Description: Initialize the Export Wizard dialog controls
 *
 * Arguments: None (called from dialog onLoad)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_openExportWizard;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ExportWizard", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Error: Export Wizard display not found";
};

// Load recent paths
private _recentPaths = call LBH_fnc_loadRecentPaths;
private _recentCtrl = _display displayCtrl IDC_WIZARD_RECENT;
lbClear _recentCtrl;
_recentCtrl lbAdd "-- Select Recent Path --";
{
    _recentCtrl lbAdd _x;
} forEach _recentPaths;
_recentCtrl lbSetCurSel 0;

// Count items for each preset
private _presets = [
    ["blufor", IDC_WIZARD_COUNT_BLUFOR],
    ["opfor", IDC_WIZARD_COUNT_OPFOR],
    ["resistance", IDC_WIZARD_COUNT_RESISTANCE],
    ["civilians", IDC_WIZARD_COUNT_CIVILIANS],
    ["arsenal", IDC_WIZARD_COUNT_ARSENAL]
];

{
    _x params ["_preset", "_idc"];
    private _presetData = LBH_data getOrDefault [_preset, createHashMap];
    private _totalItems = 0;

    // Count all items in all categories
    {
        private _value = _y;
        if (_value isEqualType []) then {
            _totalItems = _totalItems + (count _value);
        } else {
            if (_value isEqualType "" && {_value != ""}) then {
                _totalItems = _totalItems + 1;
            };
        };
    } forEach _presetData;

    private _countCtrl = _display displayCtrl _idc;
    _countCtrl ctrlSetText str _totalItems;
} forEach _presets;

// Set initial status
private _statusCtrl = _display displayCtrl IDC_WIZARD_STATUS;
_statusCtrl ctrlSetText "Enter a KP Liberation mission path and click 'Validate Path'";

diag_log "[LBH] Export Wizard initialized";
