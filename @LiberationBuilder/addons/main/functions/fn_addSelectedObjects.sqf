/*
 * Function: LBH_fnc_addSelectedObjects
 * Description: Add selected objects from 3DEN editor to a category
 *
 * Arguments:
 *   0: STRING or BOOLEAN - Preset name, or true for auto-detect
 *   1: STRING - Category name (optional if auto-detect)
 *
 * Return Value:
 *   NUMBER - Count of objects added
 *
 * Example:
 *   ["blufor", "infantry_units"] call LBH_fnc_addSelectedObjects;
 *   [true] call LBH_fnc_addSelectedObjects; // Auto-detect
 */

#include "..\script_component.hpp"

params [
    ["_presetOrAuto", "", ["", true]],
    ["_category", "", [""]]
];

// Get selected objects in 3DEN
private _selected = get3DENSelected "object";

if (count _selected == 0) exitWith {
    ["No objects selected!", 1, 2] call LBH_fnc_showNotification;
    0
};

private _addedCount = 0;
private _skippedCount = 0;
private _costQueue = [];

{
    private _entity = _x;
    private _classname = typeOf _entity;

    // Skip empty classnames
    if (_classname isEqualTo "") then {
        _skippedCount = _skippedCount + 1;
        continue;
    };

    private _targetPreset = "";
    private _targetCategory = "";
    private _formatType = "simple";

    // Auto-detect or use provided values
    if (_presetOrAuto isEqualType true && {_presetOrAuto}) then {
        // Auto-detect type
        private _detected = _classname call LBH_fnc_detectObjectType;
        if (count _detected > 0) then {
            _targetPreset = _detected select 0;
            _targetCategory = _detected select 1;
            _formatType = _detected select 2;
        };
    } else {
        _targetPreset = _presetOrAuto;
        _targetCategory = _category;

        // Get format type
        private _categories = LBH_categories getOrDefault [_targetPreset, []];
        {
            if ((_x select 0) isEqualTo _targetCategory) exitWith {
                _formatType = _x select 2;
            };
        } forEach _categories;
    };

    if (_targetPreset isEqualTo "" || {_targetCategory isEqualTo ""}) then {
        diag_log format ["[LBH] Could not determine category for %1", _classname];
        _skippedCount = _skippedCount + 1;
        continue;
    };

    // Handle cost format - queue for cost dialog
    if (_formatType isEqualTo "cost") then {
        // Check if already exists
        if ([_targetPreset, _targetCategory, _classname] call LBH_fnc_hasClassname) then {
            [format ["Classname %1 already exists in %2/%3", _classname, _targetPreset, _targetCategory], 1, 2] call LBH_fnc_showNotification;
            _skippedCount = _skippedCount + 1;
        } else {
            // Add to queue for cost dialog processing
            _costQueue pushBack [_targetPreset, _targetCategory, _classname];
        };
    } else {
        // Simple or single format - add directly
        if ([_targetPreset, _targetCategory, _classname] call LBH_fnc_addClassname) then {
            _addedCount = _addedCount + 1;
        } else {
            _skippedCount = _skippedCount + 1;
        };
    };
} forEach _selected;

// Process cost queue - store it globally and open first dialog
if (count _costQueue > 0) then {
    LBH_pendingCostQueue = _costQueue;

    // Process first item in queue
    private _first = _costQueue select 0;
    _first params ["_preset", "_cat", "_cls"];

    LBH_pendingCost = [_preset, _cat, _cls];

    // Open cost dialog
    createDialog "LBH_CostDialog";

    private _display = uiNamespace getVariable ["LBH_CostDialog", displayNull];
    if (!isNull _display) then {
        (_display displayCtrl IDC_COST_CLASSNAME) ctrlSetText _cls;
    };
} else {
    // No cost items, show summary
    if (_addedCount > 0 || _skippedCount > 0) then {
        private _msg = format ["Added: %1", _addedCount];
        if (_skippedCount > 0) then {
            _msg = _msg + format [" (Skipped: %1)", _skippedCount];
        };
        [_msg, 0, 2] call LBH_fnc_showNotification;
    };
};

_addedCount
