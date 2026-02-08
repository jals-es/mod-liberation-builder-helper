/*
 * Function: LBH_fnc_refreshImportCounts
 * Description: Refresh item counts displayed in the Import Wizard
 *
 * Arguments: None
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_refreshImportCounts;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ImportWizard", displayNull];
if (isNull _display) exitWith {};

private _presets = [
    ["blufor", IDC_IMPORT_COUNT_BLUFOR],
    ["opfor", IDC_IMPORT_COUNT_OPFOR],
    ["resistance", IDC_IMPORT_COUNT_RESISTANCE],
    ["civilians", IDC_IMPORT_COUNT_CIVILIANS],
    ["arsenal", IDC_IMPORT_COUNT_ARSENAL]
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
