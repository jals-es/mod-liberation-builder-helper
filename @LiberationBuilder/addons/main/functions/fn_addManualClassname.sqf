/*
 * Function: LBH_fnc_addManualClassname
 * Description: Manually add a classname via text input
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_addManualClassname;
 */

#include "..\script_component.hpp"

private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (isNull _display) exitWith {};

private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;

// Get current selections
private _presetIndex = lbCurSel _presetCombo;
private _categoryIndex = lbCurSel _categoryCombo;

if (_presetIndex < 0 || _categoryIndex < 0) exitWith {
    ["No category selected!", "PLAIN", 2] call LBH_fnc_showNotification;
};

private _preset = _presetCombo lbData _presetIndex;
private _category = _categoryCombo lbData _categoryIndex;

// Get format type
private _categories = LBH_categories getOrDefault [_preset, []];
private _formatType = "simple";
{
    if ((_x select 0) isEqualTo _category) exitWith {
        _formatType = _x select 2;
    };
} forEach _categories;

// Prompt for classname
["Enter classname:", "", {
    params ["_classname", "_args"];
    _args params ["_preset", "_category", "_formatType"];

    if (_classname isEqualTo "") exitWith {};

    if (_formatType isEqualTo "cost") then {
        // Store pending data for cost dialog
        LBH_pendingCost = [_preset, _category, _classname];

        // Open cost dialog
        createDialog "LBH_CostDialog";

        // Set classname display
        private _costDisplay = uiNamespace getVariable ["LBH_CostDialog", displayNull];
        if (!isNull _costDisplay) then {
            (_costDisplay displayCtrl IDC_COST_CLASSNAME) ctrlSetText _classname;
        };
    } else {
        // Add directly
        [_preset, _category, _classname] call LBH_fnc_addClassname;

        // Refresh list
        call LBH_fnc_refreshList;
    };
}, [_preset, _category, _formatType]] call BIS_fnc_3DENTextInput;
