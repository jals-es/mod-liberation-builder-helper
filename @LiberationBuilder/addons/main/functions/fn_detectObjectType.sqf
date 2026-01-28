/*
 * Function: LBH_fnc_detectObjectType
 * Description: Detect the type of an object based on its config inheritance
 *
 * Arguments:
 *   0: STRING - Classname to check
 *
 * Return Value:
 *   ARRAY - [preset, category, format] or [] if not detected
 *
 * Example:
 *   "B_Soldier_F" call LBH_fnc_detectObjectType;
 *   // Returns: ["blufor", "infantry_units", "cost"]
 */

#include "..\script_component.hpp"

params [["_classname", "", [""]]];

if (_classname isEqualTo "") exitWith {[]};

private _config = configFile >> "CfgVehicles" >> _classname;

// If not in CfgVehicles, check CfgWeapons
if (!isClass _config) then {
    _config = configFile >> "CfgWeapons" >> _classname;
    if (isClass _config) exitWith {
        ["arsenal", "GRLIB_arsenal_weapons", "simple"]
    };

    // Check CfgMagazines
    _config = configFile >> "CfgMagazines" >> _classname;
    if (isClass _config) exitWith {
        ["arsenal", "GRLIB_arsenal_magazines", "simple"]
    };

    // Check CfgGlasses (goggles, facewear)
    _config = configFile >> "CfgGlasses" >> _classname;
    if (isClass _config) exitWith {
        ["arsenal", "GRLIB_arsenal_items", "simple"]
    };

    []
};

if (!isClass _config) exitWith {[]};

// Check for vehicles first
private _simulation = getText (_config >> "simulation");
private _vehicleClass = getText (_config >> "vehicleClass");

// Infantry units
if (_classname isKindOf "Man") exitWith {
    private _side = getNumber (_config >> "side");
    switch (_side) do {
        case 1: { ["blufor", "infantry_units", "cost"] };
        case 0: { ["opfor", "militia_squad", "simple"] };
        case 2: { ["resistance", "KP_liberation_guerilla_units", "simple"] };
        case 3: { ["civilians", "civilians", "simple"] };
        default { ["blufor", "infantry_units", "cost"] };
    };
};

// Static weapons
if (_classname isKindOf "StaticWeapon") exitWith {
    ["blufor", "static_vehicles", "cost"]
};

// Tanks and heavy armor
if (_classname isKindOf "Tank") exitWith {
    ["blufor", "heavy_vehicles", "cost"]
};

// Helicopters
if (_classname isKindOf "Helicopter") exitWith {
    ["blufor", "air_vehicles", "cost"]
};

// Planes
if (_classname isKindOf "Plane") exitWith {
    ["blufor", "air_vehicles", "cost"]
};

// Ships/Boats
if (_classname isKindOf "Ship") exitWith {
    ["blufor", "light_vehicles", "cost"]
};

// APCs and IFVs
if (_classname isKindOf "APC_Wheeled_01_base_F" || {_classname isKindOf "APC_Wheeled_02_base_F"} || {_classname isKindOf "APC_Tracked_01_base_F"}) exitWith {
    ["blufor", "heavy_vehicles", "cost"]
};

// Cars and light vehicles
if (_classname isKindOf "Car") exitWith {
    ["blufor", "light_vehicles", "cost"]
};

// Trucks
if (_classname isKindOf "Truck_F") exitWith {
    ["blufor", "light_vehicles", "cost"]
};

// Buildings/Structures
if (_classname isKindOf "Building" || {_classname isKindOf "House"} || {_simulation isEqualTo "house"}) exitWith {
    ["blufor", "buildings", "cost"]
};

// Static objects that can be built
if (_simulation isEqualTo "thing" || {_vehicleClass isEqualTo "Structures"}) exitWith {
    ["blufor", "buildings", "cost"]
};

// Default - try to determine from side
private _side = getNumber (_config >> "side");
switch (_side) do {
    case 1: { ["blufor", "light_vehicles", "cost"] };
    case 0: { ["opfor", "opfor_vehicles", "simple"] };
    case 2: { ["resistance", "KP_liberation_guerilla_vehicles", "simple"] };
    case 3: { ["civilians", "civilian_vehicles", "simple"] };
    default { [] };
};
