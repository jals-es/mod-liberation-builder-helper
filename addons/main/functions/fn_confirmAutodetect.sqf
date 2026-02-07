/*
 * Function: LBH_fnc_confirmAutodetect
 * Description: Process confirmed autodetected items and add them
 *
 * Arguments: None (uses LBH_pendingAutodetect global)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_confirmAutodetect;
 */

#include "..\script_component.hpp"

private _items = LBH_pendingAutodetect;

if (isNil "_items" || {count _items == 0}) exitWith {
    closeDialog 0;
    ["No items to process!", 1, 2] call LBH_fnc_showNotification;
};

closeDialog 0;

private _addedCount = 0;
private _skippedCount = 0;
private _costQueue = [];

{
    _x params ["_classname", "_preset", "_category", "_formatType"];

    // Handle cost format - queue for cost dialog
    if (_formatType isEqualTo "cost") then {
        // Check if already exists (allow duplicates for opfor and resistance)
        private _allowDuplicate = _preset in ["opfor", "resistance"];
        if (!_allowDuplicate && {[_preset, _category, _classname] call LBH_fnc_hasClassname}) then {
            _skippedCount = _skippedCount + 1;
        } else {
            _costQueue pushBack [_preset, _category, _classname];
        };
    } else {
        // Simple or single format - add directly
        if ([_preset, _category, _classname] call LBH_fnc_addClassname) then {
            _addedCount = _addedCount + 1;
        } else {
            _skippedCount = _skippedCount + 1;
        };
    };
} forEach _items;

// Clear pending items
LBH_pendingAutodetect = [];

// Process cost queue if any
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
        // Set category display
        private _presetDisplay = toUpper _preset;
        private _categoryDisplay = _cat;
        private _categories = LBH_categories getOrDefault [_preset, []];
        {
            if ((_x select 0) isEqualTo _cat) exitWith {
                _categoryDisplay = _x select 1;
            };
        } forEach _categories;
        (_display displayCtrl IDC_COST_CATEGORY) ctrlSetText format ["Adding to: %1 > %2", _presetDisplay, _categoryDisplay];
        (_display displayCtrl IDC_COST_CLASSNAME) ctrlSetText _cls;
    };

    // Show partial summary
    if (_addedCount > 0 || _skippedCount > 0) then {
        private _msg = format ["Simple items added: %1", _addedCount];
        if (_skippedCount > 0) then {
            _msg = _msg + format [" (Skipped: %1)", _skippedCount];
        };
        _msg = _msg + format [". Processing %1 cost items...", count _costQueue];
        [_msg, 0, 3] call LBH_fnc_showNotification;
    };
} else {
    // No cost items, show final summary
    if (_addedCount > 0 || _skippedCount > 0) then {
        private _msg = format ["Added: %1", _addedCount];
        if (_skippedCount > 0) then {
            _msg = _msg + format [" (Skipped: %1)", _skippedCount];
        };
        [_msg, 0, 2] call LBH_fnc_showNotification;
    };
};

diag_log format ["[LBH] Autodetect confirmed: Added %1, Skipped %2, Cost queue %3", _addedCount, _skippedCount, count _costQueue];
