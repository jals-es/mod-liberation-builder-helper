/*
 * Function: LBH_fnc_openImportTextArea
 * Description: Open the import text area popup for a specific preset
 *
 * Arguments:
 *   0: STRING - Preset name ("blufor", "opfor", "resistance", "civilians", "arsenal")
 *
 * Return Value: None
 *
 * Example:
 *   ["blufor"] call LBH_fnc_openImportTextArea;
 */

#include "..\script_component.hpp"

params [["_preset", "", [""]]];

if (_preset == "") exitWith {
    diag_log "[LBH] Error: No preset specified for import";
};

// Store current preset for processImport
LBH_importCurrentPreset = _preset;
LBH_importMode = "merge";

// Open the textarea dialog
createDialog "LBH_ImportTextArea";

// Set title dynamically after dialog opens
[] spawn {
    disableSerialization;
    waitUntil {!isNull (uiNamespace getVariable ["LBH_ImportTextArea", displayNull])};

    private _display = uiNamespace getVariable ["LBH_ImportTextArea", displayNull];
    if (isNull _display) exitWith {};

    // Set title based on preset
    private _presetName = switch (LBH_importCurrentPreset) do {
        case "blufor": { "BLUFOR" };
        case "opfor": { "OPFOR" };
        case "resistance": { "Resistance" };
        case "civilians": { "Civilians" };
        case "arsenal": { "Arsenal" };
        default { toUpper LBH_importCurrentPreset };
    };

    private _targetFile = switch (LBH_importCurrentPreset) do {
        case "blufor": { "presets/blufor/custom.sqf" };
        case "opfor": { "presets/opfor/custom.sqf" };
        case "resistance": { "presets/resistance/custom.sqf" };
        case "civilians": { "presets/civilians/custom.sqf" };
        case "arsenal": { "arsenal_presets/custom.sqf" };
        default { "custom.sqf" };
    };

    private _titleCtrl = _display displayCtrl IDC_IMPORT_TA_STATUS;
    _titleCtrl ctrlSetText format ["Import %1 (%2)", _presetName, _targetFile];

    // Set merge button as active (green) by default
    private _mergeCtrl = _display displayCtrl IDC_IMPORT_BTN_MERGE;
    _mergeCtrl ctrlSetBackgroundColor [0.1, 0.5, 0.2, 1];

    private _replaceCtrl = _display displayCtrl IDC_IMPORT_BTN_REPLACE;
    _replaceCtrl ctrlSetBackgroundColor [0.3, 0.3, 0.35, 1];
};

diag_log format ["[LBH] Opening import textarea for preset: %1", _preset];
