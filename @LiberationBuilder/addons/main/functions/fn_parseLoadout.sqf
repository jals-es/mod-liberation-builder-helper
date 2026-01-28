/*
 * Function: LBH_fnc_parseLoadout
 * Description: Parse a unit's loadout and extract all items by category
 *
 * Arguments:
 *   0: OBJECT - Unit to parse loadout from (default: player)
 *
 * Return Value:
 *   ARRAY - [weapons, magazines, items, backpacks]
 *
 * Example:
 *   player call LBH_fnc_parseLoadout;
 */

#include "..\script_component.hpp"

params [["_unit", player, [objNull]]];

if (isNull _unit) exitWith {[[], [], [], []]};

private _weapons = [];
private _magazines = [];
private _items = [];
private _backpacks = [];

// Get loadout in standard format
private _loadout = getUnitLoadout _unit;

// Loadout format:
// [primary, secondary, handgun, uniform, vest, backpack, helmet, facewear, binoculars, linkedItems]
// Each weapon: [weaponClass, muzzle, flashlight, optics, primaryMag, secondaryMag, bipod]
// Each container: [containerClass, items]

// Primary weapon (index 0)
private _primary = _loadout select 0;
if (count _primary > 0) then {
    private _weaponClass = _primary select 0;
    if (_weaponClass != "") then {
        _weapons pushBackUnique _weaponClass;
    };

    // Attachments
    for "_i" from 1 to 3 do {
        private _attachment = _primary select _i;
        if (_attachment != "") then {
            _items pushBackUnique _attachment;
        };
    };

    // Magazines
    private _primaryMag = _primary select 4;
    if (count _primaryMag > 0) then {
        _magazines pushBackUnique (_primaryMag select 0);
    };
    private _secondaryMag = _primary select 5;
    if (count _secondaryMag > 0) then {
        _magazines pushBackUnique (_secondaryMag select 0);
    };

    // Bipod
    if (count _primary > 6) then {
        private _bipod = _primary select 6;
        if (_bipod != "") then {
            _items pushBackUnique _bipod;
        };
    };
};

// Secondary weapon (launcher, index 1)
private _secondary = _loadout select 1;
if (count _secondary > 0) then {
    private _weaponClass = _secondary select 0;
    if (_weaponClass != "") then {
        _weapons pushBackUnique _weaponClass;
    };

    // Attachments
    for "_i" from 1 to 3 do {
        private _attachment = _secondary select _i;
        if (_attachment != "") then {
            _items pushBackUnique _attachment;
        };
    };

    // Magazines
    private _primaryMag = _secondary select 4;
    if (count _primaryMag > 0) then {
        _magazines pushBackUnique (_primaryMag select 0);
    };
};

// Handgun (index 2)
private _handgun = _loadout select 2;
if (count _handgun > 0) then {
    private _weaponClass = _handgun select 0;
    if (_weaponClass != "") then {
        _weapons pushBackUnique _weaponClass;
    };

    // Attachments
    for "_i" from 1 to 3 do {
        private _attachment = _handgun select _i;
        if (_attachment != "") then {
            _items pushBackUnique _attachment;
        };
    };

    // Magazine
    private _mag = _handgun select 4;
    if (count _mag > 0) then {
        _magazines pushBackUnique (_mag select 0);
    };
};

// Uniform (index 3)
private _uniform = _loadout select 3;
if (count _uniform > 0) then {
    private _uniformClass = _uniform select 0;
    if (_uniformClass != "") then {
        _items pushBackUnique _uniformClass;
    };

    // Items inside uniform
    private _uniformItems = _uniform select 1;
    {
        _x params ["_itemClass", "_count"];
        if (isClass (configFile >> "CfgMagazines" >> _itemClass)) then {
            _magazines pushBackUnique _itemClass;
        } else {
            _items pushBackUnique _itemClass;
        };
    } forEach _uniformItems;
};

// Vest (index 4)
private _vest = _loadout select 4;
if (count _vest > 0) then {
    private _vestClass = _vest select 0;
    if (_vestClass != "") then {
        _items pushBackUnique _vestClass;
    };

    // Items inside vest
    private _vestItems = _vest select 1;
    {
        _x params ["_itemClass", "_count"];
        if (isClass (configFile >> "CfgMagazines" >> _itemClass)) then {
            _magazines pushBackUnique _itemClass;
        } else {
            _items pushBackUnique _itemClass;
        };
    } forEach _vestItems;
};

// Backpack (index 5)
private _backpack = _loadout select 5;
if (count _backpack > 0) then {
    private _backpackClass = _backpack select 0;
    if (_backpackClass != "") then {
        _backpacks pushBackUnique _backpackClass;
    };

    // Items inside backpack
    private _backpackItems = _backpack select 1;
    {
        _x params ["_itemClass", "_count"];
        if (isClass (configFile >> "CfgMagazines" >> _itemClass)) then {
            _magazines pushBackUnique _itemClass;
        } else if (isClass (configFile >> "CfgVehicles" >> _itemClass)) then {
            // Could be a sub-backpack
            _backpacks pushBackUnique _itemClass;
        } else {
            _items pushBackUnique _itemClass;
        };
    } forEach _backpackItems;
};

// Headgear (index 6)
private _headgear = _loadout select 6;
if (_headgear != "") then {
    _items pushBackUnique _headgear;
};

// Facewear (index 7)
private _facewear = _loadout select 7;
if (_facewear != "") then {
    _items pushBackUnique _facewear;
};

// Binoculars (index 8)
private _binoculars = _loadout select 8;
if (count _binoculars > 0) then {
    private _binoClass = _binoculars select 0;
    if (_binoClass != "") then {
        _weapons pushBackUnique _binoClass;
    };
};

// Linked items (index 9): [map, gps, radio, compass, watch, nvg]
private _linkedItems = _loadout select 9;
{
    if (_x != "") then {
        _items pushBackUnique _x;
    };
} forEach _linkedItems;

diag_log format ["[LBH] Parsed loadout: %1 weapons, %2 magazines, %3 items, %4 backpacks",
    count _weapons, count _magazines, count _items, count _backpacks];

[_weapons, _magazines, _items, _backpacks]
