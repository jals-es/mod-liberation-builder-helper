// Liberation Builder Helper - Dialog Definitions
// Note: defines.hpp is included via config.cpp before this file

// Main Management Panel
class LBH_MainPanel {
    idd = IDD_MAIN_PANEL;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_MainPanel', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_MainPanel', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = "0.25 * safezoneW + safezoneX";
            y = "0.15 * safezoneH + safezoneY";
            w = "0.5 * safezoneW";
            h = "0.7 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.25 * safezoneW + safezoneX";
            y = "0.15 * safezoneH + safezoneY";
            w = "0.5 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Liberation Builder Helper";
        };
    };

    class Controls {
        // Preset selection (BLUFOR, OPFOR, etc.)
        class PresetLabel : LBH_RscText {
            x = "0.26 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Preset:";
        };
        class PresetCombo : LBH_RscCombo {
            idc = IDC_PRESET_COMBO;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.15 * safezoneW";
            h = "0.025 * safezoneH";
            onLBSelChanged = "call LBH_fnc_onPresetChanged;";
        };

        // Category selection
        class CategoryLabel : LBH_RscText {
            x = "0.51 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Category:";
        };
        class CategoryCombo : LBH_RscCombo {
            idc = IDC_CATEGORY_COMBO;
            x = "0.59 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.15 * safezoneW";
            h = "0.025 * safezoneH";
            onLBSelChanged = "call LBH_fnc_onCategoryChanged;";
        };

        // Search field
        class SearchLabel : LBH_RscText {
            x = "0.26 * safezoneW + safezoneX";
            y = "0.24 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Search:";
        };
        class SearchEdit : LBH_RscEdit {
            idc = IDC_SEARCH_EDIT;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.24 * safezoneH + safezoneY";
            w = "0.25 * safezoneW";
            h = "0.025 * safezoneH";
            onKeyUp = "call LBH_fnc_onSearchChanged;";
        };

        // Classname list (multi-column)
        class ClassnameList : LBH_RscListNBox {
            idc = IDC_CLASSNAME_LIST;
            x = "0.26 * safezoneW + safezoneX";
            y = "0.28 * safezoneH + safezoneY";
            w = "0.48 * safezoneW";
            h = "0.48 * safezoneH";
            columns[] = {0, 0.55, 0.7, 0.85};
        };

        // Status text
        class StatusText : LBH_RscText {
            idc = IDC_STATUS_TEXT;
            x = "0.26 * safezoneW + safezoneX";
            y = "0.77 * safezoneH + safezoneY";
            w = "0.48 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Ready";
            colorText[] = {0.7, 0.7, 0.7, 1};
        };

        // Buttons
        class BtnAdd : LBH_RscButton {
            idc = IDC_BTN_ADD;
            x = "0.26 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.09 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Add Manual";
            action = "call LBH_fnc_addManualClassname;";
        };
        class BtnRemove : LBH_RscButton {
            idc = IDC_BTN_REMOVE;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.09 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Remove";
            action = "call LBH_fnc_removeSelected;";
        };
        class BtnExport : LBH_RscButton {
            idc = IDC_BTN_EXPORT;
            x = "0.46 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.09 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Export";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_exportCurrentCategory;";
        };
        class BtnClear : LBH_RscButton {
            idc = IDC_BTN_CLEAR;
            x = "0.56 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.09 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Clear All";
            colorBackground[] = {0.5, 0.1, 0.1, 1};
            action = "call LBH_fnc_clearCategory;";
        };
        class BtnClose : LBH_RscButton {
            idc = IDC_BTN_CLOSE;
            x = "0.66 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.035 * safezoneH";
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
            x = "0.35 * safezoneW + safezoneX";
            y = "0.35 * safezoneH + safezoneY";
            w = "0.3 * safezoneW";
            h = "0.3 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.35 * safezoneW + safezoneX";
            y = "0.35 * safezoneH + safezoneY";
            w = "0.3 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Set Resource Costs";
        };
    };

    class Controls {
        // Category display (Adding to: PRESET > CATEGORY)
        class CategoryLabel : LBH_RscText {
            idc = IDC_COST_CATEGORY;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.39 * safezoneH + safezoneY";
            w = "0.28 * safezoneW";
            h = "0.022 * safezoneH";
            style = ST_CENTER;
            sizeEx = 0.022;
            colorText[] = {0.6, 0.8, 1, 1};
            text = "";
        };

        // Classname display
        class ClassnameLabel : LBH_RscText {
            idc = IDC_COST_CLASSNAME;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.41 * safezoneH + safezoneY";
            w = "0.28 * safezoneW";
            h = "0.025 * safezoneH";
            style = ST_CENTER;
            text = "";
        };

        // Supplies
        class SuppliesLabel : LBH_RscText {
            x = "0.36 * safezoneW + safezoneX";
            y = "0.44 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Supplies:";
        };
        class SuppliesEdit : LBH_RscEdit {
            idc = IDC_COST_SUPPLIES;
            x = "0.47 * safezoneW + safezoneX";
            y = "0.44 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.025 * safezoneH";
            text = "0";
        };

        // Ammunition
        class AmmoLabel : LBH_RscText {
            x = "0.36 * safezoneW + safezoneX";
            y = "0.48 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Ammunition:";
        };
        class AmmoEdit : LBH_RscEdit {
            idc = IDC_COST_AMMO;
            x = "0.47 * safezoneW + safezoneX";
            y = "0.48 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.025 * safezoneH";
            text = "0";
        };

        // Fuel
        class FuelLabel : LBH_RscText {
            x = "0.36 * safezoneW + safezoneX";
            y = "0.52 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Fuel:";
        };
        class FuelEdit : LBH_RscEdit {
            idc = IDC_COST_FUEL;
            x = "0.47 * safezoneW + safezoneX";
            y = "0.52 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.025 * safezoneH";
            text = "0";
        };

        // Buttons
        class BtnOK : LBH_RscButton {
            idc = IDC_COST_OK;
            x = "0.40 * safezoneW + safezoneX";
            y = "0.58 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.035 * safezoneH";
            text = "OK";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmCost;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_COST_CANCEL;
            x = "0.52 * safezoneW + safezoneX";
            y = "0.58 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Cancel";
            action = "LBH_pendingCost = []; LBH_pendingCostQueue = nil; closeDialog 0;";
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
            x = "0.35 * safezoneW + safezoneX";
            y = "0.25 * safezoneH + safezoneY";
            w = "0.3 * safezoneW";
            h = "0.5 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.35 * safezoneW + safezoneX";
            y = "0.25 * safezoneH + safezoneY";
            w = "0.3 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Select Category";
        };
    };

    class Controls {
        class CategoryList : LBH_RscListBox {
            idc = IDC_CATSEL_LIST;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.30 * safezoneH + safezoneY";
            w = "0.28 * safezoneW";
            h = "0.35 * safezoneH";
        };

        class BtnOK : LBH_RscButton {
            idc = IDC_CATSEL_OK;
            x = "0.40 * safezoneW + safezoneX";
            y = "0.67 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Select";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmCategory;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_CATSEL_CANCEL;
            x = "0.52 * safezoneW + safezoneX";
            y = "0.67 * safezoneH + safezoneY";
            w = "0.1 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Cancel";
            action = "closeDialog 0;";
        };
    };
};

// Export Wizard Dialog
class LBH_ExportWizard {
    idd = IDD_EXPORT_WIZARD;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_ExportWizard', _this select 0]; call LBH_fnc_openExportWizard;";
    onUnload = "uiNamespace setVariable ['LBH_ExportWizard', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = "0.20 * safezoneW + safezoneX";
            y = "0.12 * safezoneH + safezoneY";
            w = "0.60 * safezoneW";
            h = "0.76 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.20 * safezoneW + safezoneX";
            y = "0.12 * safezoneH + safezoneY";
            w = "0.60 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Export to KP Liberation Mission";
        };
    };

    class Controls {
        // Mission Path Input
        class PathLabel : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.18 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Mission Path:";
        };
        class PathEdit : LBH_RscEdit {
            idc = IDC_WIZARD_PATH;
            x = "0.22 * safezoneW + safezoneX";
            y = "0.21 * safezoneH + safezoneY";
            w = "0.48 * safezoneW";
            h = "0.03 * safezoneH";
            text = "";
        };
        class BtnBrowse : LBH_RscButton {
            idc = IDC_WIZARD_BROWSE;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.21 * safezoneH + safezoneY";
            w = "0.07 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Browse";
            action = "call LBH_fnc_browseMissionPath;";
        };

        // Recent Paths Dropdown
        class RecentLabel : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.25 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Recent:";
        };
        class RecentCombo : LBH_RscCombo {
            idc = IDC_WIZARD_RECENT;
            x = "0.30 * safezoneW + safezoneX";
            y = "0.25 * safezoneH + safezoneY";
            w = "0.40 * safezoneW";
            h = "0.025 * safezoneH";
            onLBSelChanged = "call LBH_fnc_onRecentPathSelected;";
        };

        // Validation Status
        class StatusText : LBH_RscText {
            idc = IDC_WIZARD_STATUS;
            x = "0.22 * safezoneW + safezoneX";
            y = "0.29 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Enter mission path to validate...";
            colorText[] = {0.7, 0.7, 0.7, 1};
        };

        // Separator line
        class Separator1 : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.32 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.002 * safezoneH";
            colorBackground[] = {0.4, 0.4, 0.4, 1};
        };

        // Table Header
        class HeaderPreset : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.34 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Preset";
            style = ST_CENTER;
            colorBackground[] = {0.25, 0.25, 0.3, 1};
        };
        class HeaderItems : LBH_RscText {
            x = "0.34 * safezoneW + safezoneX";
            y = "0.34 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Items";
            style = ST_CENTER;
            colorBackground[] = {0.25, 0.25, 0.3, 1};
        };
        class HeaderTarget : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.34 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Target File";
            style = ST_CENTER;
            colorBackground[] = {0.25, 0.25, 0.3, 1};
        };
        class HeaderActions : LBH_RscText {
            x = "0.64 * safezoneW + safezoneX";
            y = "0.34 * safezoneH + safezoneY";
            w = "0.14 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Actions";
            style = ST_CENTER;
            colorBackground[] = {0.25, 0.25, 0.3, 1};
        };

        // ========== BLUFOR Row ==========
        class RowBluforBg : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.37 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            colorBackground[] = {0.18, 0.18, 0.22, 1};
        };
        class LabelBlufor : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.38 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.04 * safezoneH";
            text = "BLUFOR";
            style = ST_CENTER + ST_VCENTER;
            colorText[] = {0.4, 0.6, 1, 1};
        };
        class CountBlufor : LBH_RscText {
            idc = IDC_WIZARD_COUNT_BLUFOR;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.38 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.04 * safezoneH";
            text = "0";
            style = ST_CENTER + ST_VCENTER;
        };
        class TargetBlufor : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.38 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.04 * safezoneH";
            text = "presets/blufor/custom.sqf";
            sizeEx = 0.025;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };
        class BtnCopyBlufor : LBH_RscButton {
            idc = IDC_WIZARD_COPY_BLUFOR;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.385 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Copy";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "['blufor'] call LBH_fnc_exportPresetToClipboard;";
        };
        class BtnOpenBlufor : LBH_RscButton {
            idc = IDC_WIZARD_OPEN_BLUFOR;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.385 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Open";
            action = "['blufor'] call LBH_fnc_openMissionFolder;";
        };

        // ========== OPFOR Row ==========
        class RowOpforBg : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.44 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            colorBackground[] = {0.15, 0.15, 0.18, 1};
        };
        class LabelOpfor : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.45 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.04 * safezoneH";
            text = "OPFOR";
            style = ST_CENTER + ST_VCENTER;
            colorText[] = {1, 0.4, 0.4, 1};
        };
        class CountOpfor : LBH_RscText {
            idc = IDC_WIZARD_COUNT_OPFOR;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.45 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.04 * safezoneH";
            text = "0";
            style = ST_CENTER + ST_VCENTER;
        };
        class TargetOpfor : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.45 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.04 * safezoneH";
            text = "presets/opfor/custom.sqf";
            sizeEx = 0.025;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };
        class BtnCopyOpfor : LBH_RscButton {
            idc = IDC_WIZARD_COPY_OPFOR;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.455 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Copy";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "['opfor'] call LBH_fnc_exportPresetToClipboard;";
        };
        class BtnOpenOpfor : LBH_RscButton {
            idc = IDC_WIZARD_OPEN_OPFOR;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.455 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Open";
            action = "['opfor'] call LBH_fnc_openMissionFolder;";
        };

        // ========== Resistance Row ==========
        class RowResistanceBg : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.51 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            colorBackground[] = {0.18, 0.18, 0.22, 1};
        };
        class LabelResistance : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.52 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Resistance";
            style = ST_CENTER + ST_VCENTER;
            colorText[] = {0.4, 0.9, 0.4, 1};
        };
        class CountResistance : LBH_RscText {
            idc = IDC_WIZARD_COUNT_RESISTANCE;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.52 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.04 * safezoneH";
            text = "0";
            style = ST_CENTER + ST_VCENTER;
        };
        class TargetResistance : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.52 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.04 * safezoneH";
            text = "presets/resistance/custom.sqf";
            sizeEx = 0.025;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };
        class BtnCopyResistance : LBH_RscButton {
            idc = IDC_WIZARD_COPY_RESISTANCE;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.525 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Copy";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "['resistance'] call LBH_fnc_exportPresetToClipboard;";
        };
        class BtnOpenResistance : LBH_RscButton {
            idc = IDC_WIZARD_OPEN_RESISTANCE;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.525 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Open";
            action = "['resistance'] call LBH_fnc_openMissionFolder;";
        };

        // ========== Civilians Row ==========
        class RowCiviliansBg : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.58 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            colorBackground[] = {0.15, 0.15, 0.18, 1};
        };
        class LabelCivilians : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.59 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Civilians";
            style = ST_CENTER + ST_VCENTER;
            colorText[] = {0.8, 0.4, 0.8, 1};
        };
        class CountCivilians : LBH_RscText {
            idc = IDC_WIZARD_COUNT_CIVILIANS;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.59 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.04 * safezoneH";
            text = "0";
            style = ST_CENTER + ST_VCENTER;
        };
        class TargetCivilians : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.59 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.04 * safezoneH";
            text = "presets/civilians/custom.sqf";
            sizeEx = 0.025;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };
        class BtnCopyCivilians : LBH_RscButton {
            idc = IDC_WIZARD_COPY_CIVILIANS;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.595 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Copy";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "['civilians'] call LBH_fnc_exportPresetToClipboard;";
        };
        class BtnOpenCivilians : LBH_RscButton {
            idc = IDC_WIZARD_OPEN_CIVILIANS;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.595 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Open";
            action = "['civilians'] call LBH_fnc_openMissionFolder;";
        };

        // ========== Arsenal Row ==========
        class RowArsenalBg : LBH_RscBackground {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.65 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            colorBackground[] = {0.18, 0.18, 0.22, 1};
        };
        class LabelArsenal : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Arsenal";
            style = ST_CENTER + ST_VCENTER;
            colorText[] = {1, 0.8, 0.3, 1};
        };
        class CountArsenal : LBH_RscText {
            idc = IDC_WIZARD_COUNT_ARSENAL;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.04 * safezoneH";
            text = "0";
            style = ST_CENTER + ST_VCENTER;
        };
        class TargetArsenal : LBH_RscText {
            x = "0.40 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.24 * safezoneW";
            h = "0.04 * safezoneH";
            text = "arsenal_presets/custom.sqf";
            sizeEx = 0.025;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };
        class BtnCopyArsenal : LBH_RscButton {
            idc = IDC_WIZARD_COPY_ARSENAL;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.665 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Copy";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "['arsenal'] call LBH_fnc_exportPresetToClipboard;";
        };
        class BtnOpenArsenal : LBH_RscButton {
            idc = IDC_WIZARD_OPEN_ARSENAL;
            x = "0.71 * safezoneW + safezoneX";
            y = "0.665 * safezoneH + safezoneY";
            w = "0.06 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Open";
            action = "['arsenal'] call LBH_fnc_openMissionFolder;";
        };

        // ========== Instructions ==========
        class InstructionsText : LBH_RscText {
            x = "0.22 * safezoneW + safezoneX";
            y = "0.73 * safezoneH + safezoneY";
            w = "0.56 * safezoneW";
            h = "0.06 * safezoneH";
            text = "Click 'Copy' to copy preset to clipboard, then paste into the target file. Click 'Open' to open the folder.";
            sizeEx = 0.022;
            colorText[] = {0.6, 0.6, 0.6, 1};
        };

        // ========== Bottom Buttons ==========
        class BtnValidate : LBH_RscButton {
            x = "0.50 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Validate Path";
            action = "call LBH_fnc_validateMissionPath;";
        };
        class BtnClose : LBH_RscButton {
            idc = IDC_WIZARD_CLOSE;
            x = "0.64 * safezoneW + safezoneX";
            y = "0.80 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Close";
            action = "closeDialog 0;";
        };
    };
};

// Text Input Dialog
class LBH_TextInput {
    idd = IDD_TEXT_INPUT;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_TextInput', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_TextInput', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = "0.35 * safezoneW + safezoneX";
            y = "0.40 * safezoneH + safezoneY";
            w = "0.30 * safezoneW";
            h = "0.15 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.35 * safezoneW + safezoneX";
            y = "0.40 * safezoneH + safezoneY";
            w = "0.30 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Enter Classname";
        };
    };

    class Controls {
        class InputLabel : LBH_RscText {
            idc = IDC_TEXT_INPUT_LABEL;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.44 * safezoneH + safezoneY";
            w = "0.28 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Classname:";
        };
        class InputEdit : LBH_RscEdit {
            idc = IDC_TEXT_INPUT_EDIT;
            x = "0.36 * safezoneW + safezoneX";
            y = "0.47 * safezoneH + safezoneY";
            w = "0.28 * safezoneW";
            h = "0.03 * safezoneH";
            text = "";
        };
        class BtnOK : LBH_RscButton {
            idc = IDC_TEXT_INPUT_OK;
            x = "0.40 * safezoneW + safezoneX";
            y = "0.51 * safezoneH + safezoneY";
            w = "0.10 * safezoneW";
            h = "0.03 * safezoneH";
            text = "OK";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmTextInput;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_TEXT_INPUT_CANCEL;
            x = "0.52 * safezoneW + safezoneX";
            y = "0.51 * safezoneH + safezoneY";
            w = "0.10 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Cancel";
            action = "LBH_textInputCallback = nil; closeDialog 0;";
        };
    };
};

// Autodetect Confirmation Dialog
class LBH_AutodetectConfirm {
    idd = IDD_AUTODETECT_CONFIRM;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['LBH_AutodetectConfirm', _this select 0];";
    onUnload = "uiNamespace setVariable ['LBH_AutodetectConfirm', displayNull];";

    class ControlsBackground {
        class Background : LBH_RscBackground {
            x = "0.20 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.60 * safezoneW";
            h = "0.60 * safezoneH";
        };
        class TitleBar : LBH_RscTitle {
            x = "0.20 * safezoneW + safezoneX";
            y = "0.20 * safezoneH + safezoneY";
            w = "0.60 * safezoneW";
            h = "0.04 * safezoneH";
            text = "Confirm Auto-detected Items";
        };
    };

    class Controls {
        // Instructions
        class Instructions : LBH_RscText {
            x = "0.21 * safezoneW + safezoneX";
            y = "0.25 * safezoneH + safezoneY";
            w = "0.58 * safezoneW";
            h = "0.025 * safezoneH";
            text = "Review detected items. Select an item and use the dropdown to change its category.";
            sizeEx = 0.022;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };

        // Item list (multi-column: DisplayName | Classname | Preset | Category)
        class ItemList : LBH_RscListNBox {
            idc = IDC_AUTODETECT_LIST;
            x = "0.21 * safezoneW + safezoneX";
            y = "0.29 * safezoneH + safezoneY";
            w = "0.58 * safezoneW";
            h = "0.36 * safezoneH";
            columns[] = {0, 0.30, 0.55, 0.75};
            onLBSelChanged = "call LBH_fnc_onAutodetectSelect;";
        };

        // Category change controls
        class CategoryLabel : LBH_RscText {
            idc = IDC_AUTODETECT_CATEGORY_LABEL;
            x = "0.21 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Change category:";
            sizeEx = 0.025;
        };
        class CategoryCombo : LBH_RscCombo {
            idc = IDC_AUTODETECT_CATEGORY_COMBO;
            x = "0.34 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.30 * safezoneW";
            h = "0.03 * safezoneH";
            onLBSelChanged = "call LBH_fnc_onAutodetectCategoryChange;";
        };
        class BtnApply : LBH_RscButton {
            idc = -1;
            x = "0.65 * safezoneW + safezoneX";
            y = "0.66 * safezoneH + safezoneY";
            w = "0.08 * safezoneW";
            h = "0.03 * safezoneH";
            text = "Apply";
            colorBackground[] = {0.3, 0.5, 0.7, 1};
            action = "call LBH_fnc_applyAutodetectCategory;";
        };

        // Buttons
        class BtnConfirm : LBH_RscButton {
            idc = IDC_AUTODETECT_OK;
            x = "0.45 * safezoneW + safezoneX";
            y = "0.73 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Confirm All";
            colorBackground[] = {0.1, 0.5, 0.2, 1};
            action = "call LBH_fnc_confirmAutodetect;";
        };
        class BtnCancel : LBH_RscButton {
            idc = IDC_AUTODETECT_CANCEL;
            x = "0.59 * safezoneW + safezoneX";
            y = "0.73 * safezoneH + safezoneY";
            w = "0.12 * safezoneW";
            h = "0.035 * safezoneH";
            text = "Cancel";
            action = "LBH_pendingAutodetect = []; closeDialog 0;";
        };
    };
};
