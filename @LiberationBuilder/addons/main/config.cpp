// Liberation Builder Helper - Main Configuration
#include "script_component.hpp"

class CfgPatches {
    class LBH_Main {
        name = "Liberation Builder Helper";
        author = "LBH Team";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.00;
        requiredAddons[] = {"A3_3DEN", "cba_main", "cba_xeh"};
        version = VERSION;
        versionStr = VERSION_STR;
        versionAr[] = {VERSION_AR};
    };
};

class CfgMods {
    class LBH {
        dir = "@LiberationBuilder";
        name = "Liberation Builder Helper";
        picture = "";
        hidePicture = "false";
        hideName = "false";
        actionName = "GitHub";
        action = "";
        description = "A mod to help build KP Liberation missions";
    };
};

class CfgFunctions {
    class LBH {
        class Main {
            file = "x\lbh\addons\main\functions";

            // Core functions
            class init {};
            class loadData {};
            class saveData {};
            class showNotification {};

            // Classname management
            class addClassname {};
            class removeClassname {};
            class hasClassname {};
            class detectObjectType {};
            class getCategories {};

            // UI functions
            class openPanel {};
            class onPresetChanged {};
            class onCategoryChanged {};
            class onSearchChanged {};
            class refreshList {};
            class removeSelected {};
            class clearCategory {};
            class addManualClassname {};

            // Cost dialog
            class openCostDialog {};
            class confirmCost {};

            // Category select dialog
            class openCategorySelect {};
            class confirmCategory {};

            // 3DEN Editor functions
            class addSelectedObjects {};

            // Export functions
            class exportPreset {};
            class formatCostArray {};
            class formatSimpleArray {};

            // ACE Arsenal integration
            class arsenalInit {};
            class arsenalExport {};
            class parseLoadout {};
        };
    };
};

// 3DEN Editor Integration
class Cfg3DEN {
    class EventHandlers {
        class LBH {
            onMissionLoad = "call LBH_fnc_init;";
        };
    };

    class Menu {
        // Main Liberation Builder menu
        class LBH_Menu {
            text = "Liberation Builder";
            picture = "";
            action = "";
            items[] = {
                "LBH_AddBlufor",
                "LBH_AddOpfor",
                "LBH_AddResistance",
                "LBH_AddCivilians",
                "LBH_AddArsenal",
                "LBH_Separator1",
                "LBH_OpenPanel",
                "LBH_ExportAll"
            };
        };

        // BLUFOR submenu
        class LBH_AddBlufor {
            text = "Add to BLUFOR";
            picture = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
            items[] = {
                "LBH_BLUFOR_Infantry",
                "LBH_BLUFOR_LightVehicles",
                "LBH_BLUFOR_HeavyVehicles",
                "LBH_BLUFOR_AirVehicles",
                "LBH_BLUFOR_StaticWeapons",
                "LBH_BLUFOR_Buildings",
                "LBH_BLUFOR_Support"
            };
        };

        class LBH_BLUFOR_Infantry {
            text = "Infantry Units";
            action = "['blufor', 'infantry_units'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_LightVehicles {
            text = "Light Vehicles";
            action = "['blufor', 'light_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_HeavyVehicles {
            text = "Heavy Vehicles";
            action = "['blufor', 'heavy_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_AirVehicles {
            text = "Air Vehicles";
            action = "['blufor', 'air_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_StaticWeapons {
            text = "Static Weapons";
            action = "['blufor', 'static_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_Buildings {
            text = "Buildings";
            action = "['blufor', 'buildings'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_BLUFOR_Support {
            text = "Support Vehicles";
            action = "['blufor', 'support_vehicles'] call LBH_fnc_addSelectedObjects;";
        };

        // OPFOR submenu
        class LBH_AddOpfor {
            text = "Add to OPFOR";
            picture = "\A3\ui_f\data\map\markers\nato\o_inf.paa";
            items[] = {
                "LBH_OPFOR_Militia",
                "LBH_OPFOR_Vehicles",
                "LBH_OPFOR_VehiclesLow",
                "LBH_OPFOR_Battlegroup",
                "LBH_OPFOR_Choppers",
                "LBH_OPFOR_Air",
                "LBH_OPFOR_StaticAA"
            };
        };

        class LBH_OPFOR_Militia {
            text = "Militia Squad";
            action = "['opfor', 'militia_squad'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_Vehicles {
            text = "Vehicles";
            action = "['opfor', 'opfor_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_VehiclesLow {
            text = "Vehicles (Low Intensity)";
            action = "['opfor', 'opfor_vehicles_low_intensity'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_Battlegroup {
            text = "Battlegroup Vehicles";
            action = "['opfor', 'opfor_battlegroup_vehicles'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_Choppers {
            text = "Helicopters";
            action = "['opfor', 'opfor_choppers'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_Air {
            text = "Fixed-wing Aircraft";
            action = "['opfor', 'opfor_air'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_OPFOR_StaticAA {
            text = "Static AA";
            action = "['opfor', 'opfor_static_aa'] call LBH_fnc_addSelectedObjects;";
        };

        // Resistance submenu
        class LBH_AddResistance {
            text = "Add to Resistance";
            picture = "\A3\ui_f\data\map\markers\nato\n_inf.paa";
            items[] = {
                "LBH_RES_Units",
                "LBH_RES_Vehicles"
            };
        };

        class LBH_RES_Units {
            text = "Guerrilla Units";
            action = "['resistance', 'KP_liberation_guerilla_units'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_RES_Vehicles {
            text = "Guerrilla Vehicles";
            action = "['resistance', 'KP_liberation_guerilla_vehicles'] call LBH_fnc_addSelectedObjects;";
        };

        // Civilians submenu
        class LBH_AddCivilians {
            text = "Add to Civilians";
            picture = "\A3\ui_f\data\map\markers\nato\c_car.paa";
            items[] = {
                "LBH_CIV_Units",
                "LBH_CIV_Vehicles"
            };
        };

        class LBH_CIV_Units {
            text = "Civilian Units";
            action = "['civilians', 'civilians'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_CIV_Vehicles {
            text = "Civilian Vehicles";
            action = "['civilians', 'civilian_vehicles'] call LBH_fnc_addSelectedObjects;";
        };

        // Arsenal submenu
        class LBH_AddArsenal {
            text = "Add to Arsenal";
            picture = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\cargotab_ca.paa";
            items[] = {
                "LBH_Arsenal_Weapons",
                "LBH_Arsenal_Magazines",
                "LBH_Arsenal_Items",
                "LBH_Arsenal_Backpacks"
            };
        };

        class LBH_Arsenal_Weapons {
            text = "Weapons";
            action = "['arsenal', 'GRLIB_arsenal_weapons'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_Arsenal_Magazines {
            text = "Magazines";
            action = "['arsenal', 'GRLIB_arsenal_magazines'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_Arsenal_Items {
            text = "Items";
            action = "['arsenal', 'GRLIB_arsenal_items'] call LBH_fnc_addSelectedObjects;";
        };
        class LBH_Arsenal_Backpacks {
            text = "Backpacks";
            action = "['arsenal', 'GRLIB_arsenal_backpacks'] call LBH_fnc_addSelectedObjects;";
        };

        // Separator
        class LBH_Separator1 {
            text = "";
            action = "";
            data = "separator";
        };

        // Direct actions
        class LBH_OpenPanel {
            text = "Open Management Panel";
            picture = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\icon_ca.paa";
            action = "call LBH_fnc_openPanel;";
        };

        class LBH_ExportAll {
            text = "Export All Presets";
            picture = "\A3\ui_f\data\gui\cfg\hints\icon_text\bexport_ca.paa";
            action = "call LBH_fnc_exportPreset;";
        };

        // Context menu items
        class LBH_Context_Menu {
            text = "Liberation Builder";
            picture = "";
            items[] = {
                "LBH_Context_AddAuto",
                "LBH_Context_SelectCategory"
            };
        };

        class LBH_Context_AddAuto {
            text = "Add (Auto-detect)";
            action = "[true] call LBH_fnc_addSelectedObjects;";
        };

        class LBH_Context_SelectCategory {
            text = "Add to Category...";
            action = "call LBH_fnc_openCategorySelect;";
        };
    };
};

// 3DEN Menu Bar and Context Menu
class ctrlMenuStrip;
class display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class Tools {
                    items[] += {"LBH_Menu"};
                };
            };
        };
    };
    class ContextMenu: ctrlMenuStrip {
        class Items {
            class Object {
                items[] += {"LBH_Context_Menu"};
            };
        };
    };
};

// Dialogs
#include "ui\dialogs.hpp"

// CBA Extended Event Handlers
class Extended_PreInit_EventHandlers {
    class LBH {
        init = "call compile preprocessFileLineNumbers 'x\lbh\addons\main\XEH_preInit.sqf';";
    };
};

class Extended_PostInit_EventHandlers {
    class LBH {
        init = "call compile preprocessFileLineNumbers 'x\lbh\addons\main\XEH_postInit.sqf';";
    };
};
