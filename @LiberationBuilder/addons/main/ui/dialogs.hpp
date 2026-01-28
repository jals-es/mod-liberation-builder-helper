// Liberation Builder Helper - Dialog Definitions
#include "defines.hpp"

// Main Management Panel
class LBH_MainPanel {
    idd = IDD_MAIN_PANEL;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_MainPanel', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_MainPanel', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = 0.25 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.5 * safezoneW;
            h = 0.7 * safezoneH;
        };
        class TitleBar : LBH_RscTitle {
            x = 0.25 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.5 * safezoneW;
            h = 0.04 * safezoneH;
            text = "Liberation Builder Helper";
        };
    };

    class Controls {
        // Preset selection (BLUFOR, OPFOR, etc.)
        class PresetLabel : LBH_RscText {
            x = 0.26 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Preset:";
        };
        class PresetCombo : LBH_RscCombo {
            idc = IDC_PRESET_COMBO;
            x = 0.34 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.025 * safezoneH;
            onLBSelChanged = "call LBH_fnc_onPresetChanged;";
        };

        // Category selection
        class CategoryLabel : LBH_RscText {
            x = 0.51 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Category:";
        };
        class CategoryCombo : LBH_RscCombo {
            idc = IDC_CATEGORY_COMBO;
            x = 0.59 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.025 * safezoneH;
            onLBSelChanged = "call LBH_fnc_onCategoryChanged;";
        };

        // Search field
        class SearchLabel : LBH_RscText {
            x = 0.26 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Search:";
        };
        class SearchEdit : LBH_RscEdit {
            idc = IDC_SEARCH_EDIT;
            x = 0.34 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
            onKeyUp = "call LBH_fnc_onSearchChanged;";
        };

        // Classname list (multi-column)
        class ClassnameList : LBH_RscListNBox {
            idc = IDC_CLASSNAME_LIST;
            x = 0.26 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.48 * safezoneW;
            h = 0.48 * safezoneH;
            columns[] = {0, 0.55, 0.7, 0.85};
        };

        // Status text
        class StatusText : LBH_RscText {
            idc = IDC_STATUS_TEXT;
            x = 0.26 * safezoneW + safezoneX;
            y = 0.77 * safezoneH + safezoneY;
            w = 0.48 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Ready";
            colorText[] = {0.7, 0.7, 0.7, 1};
        };

        // Buttons
        class BtnAdd : LBH_RscButton {
            idc = IDC_BTN_ADD;
            x = 0.26 * safezoneW + safezoneX;
            y = 0.80 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Add Manual";
            action = "call LBH_fnc_addManualClassname;";
        };
        class BtnRemove : LBH_RscButton {
            idc = IDC_BTN_REMOVE;
            x = 0.36 * safezoneW + safezoneX;
            y = 0.80 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Remove";
            action = "call LBH_fnc_removeSelected;";
        };
        class BtnExport : LBH_RscButton {
            idc = IDC_BTN_EXPORT;
            x = 0.46 * safezoneW + safezoneX;
            y = 0.80 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Export";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_exportPreset;";
        };
        class BtnClear : LBH_RscButton {
            idc = IDC_BTN_CLEAR;
            x = 0.56 * safezoneW + safezoneX;
            y = 0.80 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Clear All";
            colorBackground[] = {0.5, 0.1, 0.1, 1};
            action = "call LBH_fnc_clearCategory;";
        };
        class BtnClose : LBH_RscButton {
            idc = IDC_BTN_CLOSE;
            x = 0.66 * safezoneW + safezoneX;
            y = 0.80 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Close";
            action = "closeDialog 0;";
        };
    };
};

// Cost Input Dialog
class LBH_CostDialog {
    idd = IDD_COST_DIALOG;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_CostDialog', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_CostDialog', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = 0.35 * safezoneW + safezoneX;
            y = 0.35 * safezoneH + safezoneY;
            w = 0.3 * safezoneW;
            h = 0.3 * safezoneH;
        };
        class TitleBar : LBH_RscTitle {
            x = 0.35 * safezoneW + safezoneX;
            y = 0.35 * safezoneH + safezoneY;
            w = 0.3 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Set Resource Costs";
        };
    };

    class Controls {
        // Classname display
        class ClassnameLabel : LBH_RscText {
            idc = IDC_COST_CLASSNAME;
            x = 0.36 * safezoneW + safezoneX;
            y = 0.40 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.025 * safezoneH;
            style = ST_CENTER;
            text = "";
        };

        // Supplies
        class SuppliesLabel : LBH_RscText {
            x = 0.36 * safezoneW + safezoneX;
            y = 0.44 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Supplies:";
        };
        class SuppliesEdit : LBH_RscEdit {
            idc = IDC_COST_SUPPLIES;
            x = 0.47 * safezoneW + safezoneX;
            y = 0.44 * safezoneH + safezoneY;
            w = 0.12 * safezoneW;
            h = 0.025 * safezoneH;
            text = "0";
        };

        // Ammunition
        class AmmoLabel : LBH_RscText {
            x = 0.36 * safezoneW + safezoneX;
            y = 0.48 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Ammunition:";
        };
        class AmmoEdit : LBH_RscEdit {
            idc = IDC_COST_AMMO;
            x = 0.47 * safezoneW + safezoneX;
            y = 0.48 * safezoneH + safezoneY;
            w = 0.12 * safezoneW;
            h = 0.025 * safezoneH;
            text = "0";
        };

        // Fuel
        class FuelLabel : LBH_RscText {
            x = 0.36 * safezoneW + safezoneX;
            y = 0.52 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
            text = "Fuel:";
        };
        class FuelEdit : LBH_RscEdit {
            idc = IDC_COST_FUEL;
            x = 0.47 * safezoneW + safezoneX;
            y = 0.52 * safezoneH + safezoneY;
            w = 0.12 * safezoneW;
            h = 0.025 * safezoneH;
            text = "0";
        };

        // Buttons
        class BtnOK : LBH_RscButton {
            idc = IDC_COST_OK;
            x = 0.40 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.035 * safezoneH;
            text = "OK";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmCost;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_COST_CANCEL;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Cancel";
            action = "closeDialog 0;";
        };
    };
};

// Category Selection Dialog
class LBH_CategorySelect {
    idd = IDD_CATEGORY_SELECT;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_CategorySelect', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_CategorySelect', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = 0.35 * safezoneW + safezoneX;
            y = 0.25 * safezoneH + safezoneY;
            w = 0.3 * safezoneW;
            h = 0.5 * safezoneH;
        };
        class TitleBar : LBH_RscTitle {
            x = 0.35 * safezoneW + safezoneX;
            y = 0.25 * safezoneH + safezoneY;
            w = 0.3 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Select Category";
        };
    };

    class Controls {
        class CategoryList : LBH_RscListBox {
            idc = IDC_CATSEL_LIST;
            x = 0.36 * safezoneW + safezoneX;
            y = 0.30 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.35 * safezoneH;
        };

        class BtnOK : LBH_RscButton {
            idc = IDC_CATSEL_OK;
            x = 0.40 * safezoneW + safezoneX;
            y = 0.67 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Select";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmCategory;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_CATSEL_CANCEL;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.67 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.035 * safezoneH;
            text = "Cancel";
            action = "closeDialog 0;";
        };
    };
};
