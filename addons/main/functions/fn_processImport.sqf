/*
 * Function: LBH_fnc_processImport
 * Description: Process imported SQF text, compile it, read variables and apply to LBH_data
 *
 * Arguments: None (reads from dialog controls and global variables)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_processImport;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_ImportTextArea", displayNull];
if (isNull _display) exitWith {
    diag_log "[LBH] Error: Import TextArea display not found";
};

// Read text from textarea
private _textCtrl = _display displayCtrl IDC_IMPORT_TEXT;
private _text = ctrlText _textCtrl;

if (_text isEqualTo "") exitWith {
    ["Import failed: textarea is empty!", 1, 3] call LBH_fnc_showNotification;
};

private _preset = LBH_importCurrentPreset;
private _mode = LBH_importMode;

if (_preset == "") exitWith {
    ["Import failed: no preset selected!", 1, 3] call LBH_fnc_showNotification;
};

// Get categories for this preset
private _categories = LBH_categories getOrDefault [_preset, []];
if (count _categories == 0) exitWith {
    ["Import failed: unknown preset!", 1, 3] call LBH_fnc_showNotification;
};

// Backup current missionNamespace variables and clear them
private _backup = createHashMap;
{
    _x params ["_varName", "_displayName", "_format"];
    private _currentVal = missionNamespace getVariable [_varName, nil];
    if (!isNil "_currentVal") then {
        _backup set [_varName, _currentVal];
    };
    missionNamespace setVariable [_varName, nil];
} forEach _categories;

// Strip comments before compiling
// The Arma 3 multiline edit control may mangle newlines, breaking block comments

// Remove block comments /* ... */
private _inBlock = false;
private _chars = toArray _text;
private _cleaned = [];
private _i = 0;
private _len = count _chars;

while {_i < _len} do {
    if (_inBlock) then {
        // Look for */
        if (_i + 1 < _len && {(_chars select _i) == 42 && {(_chars select (_i + 1)) == 47}}) then {
            _inBlock = false;
            _i = _i + 2;
        } else {
            _i = _i + 1;
        };
    } else {
        if (_i + 1 < _len && {(_chars select _i) == 47 && {(_chars select (_i + 1)) == 42}}) then {
            // Found /*
            _inBlock = true;
            _i = _i + 2;
        } else {
            if (_i + 1 < _len && {(_chars select _i) == 47 && {(_chars select (_i + 1)) == 47}}) then {
                // Found // - skip until newline (10) or carriage return (13)
                _i = _i + 2;
                while {_i < _len && {!((_chars select _i) in [10, 13])}} do {
                    _i = _i + 1;
                };
            } else {
                _cleaned pushBack (_chars select _i);
                _i = _i + 1;
            };
        };
    };
};

private _cleanText = toString _cleaned;
diag_log format ["[LBH] Import: text length %1 -> %2 after stripping comments", _len, count _cleaned];

// Compile and execute the pasted SQF text
call compile _cleanText;

if (!_success) exitWith {
    // Restore backup
    {
        _x params ["_varName"];
        private _backupVal = _backup getOrDefault [_varName, nil];
        if (isNil "_backupVal") then {
            missionNamespace setVariable [_varName, nil];
        } else {
            missionNamespace setVariable [_varName, _backupVal];
        };
    } forEach _categories;
    ["Import failed: SQF compilation error! Check your syntax.", 1, 5] call LBH_fnc_showNotification;
};

// Ensure preset data hashmap exists
private _presetData = LBH_data getOrDefault [_preset, createHashMap];

// Read variables and apply to LBH_data
private _importedCount = 0;

{
    _x params ["_varName", "_displayName", "_format"];

    private _importedValue = missionNamespace getVariable [_varName, nil];

    if (!isNil "_importedValue") then {
        switch (_format) do {
            case "single": {
                // Single variable: must be a non-empty string
                if (_importedValue isEqualType "" && {_importedValue != ""}) then {
                    _presetData set [_varName, _importedValue];
                    _importedCount = _importedCount + 1;
                };
            };
            case "simple": {
                // Simple array: must be array of strings
                if (_importedValue isEqualType []) then {
                    private _validItems = _importedValue select {_x isEqualType ""};
                    if (count _validItems > 0) then {
                        if (_mode == "replace") then {
                            _presetData set [_varName, _validItems];
                        } else {
                            // Merge: add items that don't already exist
                            private _existing = _presetData getOrDefault [_varName, []];
                            {
                                if !(_x in _existing) then {
                                    _existing pushBack _x;
                                };
                            } forEach _validItems;
                            _presetData set [_varName, _existing];
                        };
                        _importedCount = _importedCount + (count _validItems);
                    };
                };
            };
            case "cost": {
                // Cost array: must be array of [string, num, num, num]
                if (_importedValue isEqualType []) then {
                    private _validItems = _importedValue select {
                        _x isEqualType [] &&
                        {count _x >= 4} &&
                        {(_x select 0) isEqualType ""} &&
                        {(_x select 1) isEqualType 0} &&
                        {(_x select 2) isEqualType 0} &&
                        {(_x select 3) isEqualType 0}
                    };
                    if (count _validItems > 0) then {
                        if (_mode == "replace") then {
                            _presetData set [_varName, _validItems];
                        } else {
                            // Merge: add items whose classname doesn't already exist
                            private _existing = _presetData getOrDefault [_varName, []];
                            private _existingNames = _existing apply {_x select 0};
                            {
                                if !((_x select 0) in _existingNames) then {
                                    _existing pushBack _x;
                                };
                            } forEach _validItems;
                            _presetData set [_varName, _existing];
                        };
                        _importedCount = _importedCount + (count _validItems);
                    };
                };
            };
        };
    };
} forEach _categories;

// Restore missionNamespace variables from backup
{
    _x params ["_varName"];
    private _backupVal = _backup getOrDefault [_varName, nil];
    if (isNil "_backupVal") then {
        missionNamespace setVariable [_varName, nil];
    } else {
        missionNamespace setVariable [_varName, _backupVal];
    };
} forEach _categories;

// Save data
LBH_data set [_preset, _presetData];
call LBH_fnc_saveData;

// Show success notification
private _presetName = switch (_preset) do {
    case "blufor": { "BLUFOR" };
    case "opfor": { "OPFOR" };
    case "resistance": { "Resistance" };
    case "civilians": { "Civilians" };
    case "arsenal": { "Arsenal" };
    default { toUpper _preset };
};

private _modeStr = if (_mode == "merge") then { "merged" } else { "replaced" };
[format ["Import successful! %1 items %2 into %3.", _importedCount, _modeStr, _presetName], 0, 5] call LBH_fnc_showNotification;

// Close textarea popup
closeDialog 0;

// Refresh import wizard counts if still open
[] spawn {
    sleep 0.3;
    call LBH_fnc_refreshImportCounts;
};

diag_log format ["[LBH] Import completed: %1 items %2 into %3", _importedCount, _modeStr, _preset];
