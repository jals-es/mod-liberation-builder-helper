/*
 * Function: LBH_fnc_onCategoryChanged
 * Description: Handle category combo selection change
 *
 * Arguments: None (uses UI controls)
 *
 * Return Value: None
 *
 * Example:
 *   call LBH_fnc_onCategoryChanged;
 */

#include "..\script_component.hpp"

// Save last selected category for current preset
private _display = uiNamespace getVariable ["LBH_MainPanel", displayNull];
if (!isNull _display) then {
    private _presetCombo = _display displayCtrl IDC_PRESET_COMBO;
    private _categoryCombo = _display displayCtrl IDC_CATEGORY_COMBO;

    private _presetIndex = lbCurSel _presetCombo;
    private _categoryIndex = lbCurSel _categoryCombo;

    if (_presetIndex >= 0 && _categoryIndex >= 0) then {
        private _preset = _presetCombo lbData _presetIndex;
        private _category = _categoryCombo lbData _categoryIndex;
        missionNamespace setVariable ["LBH_lastCategory_" + _preset, _category];
    };
};

call LBH_fnc_refreshList;
