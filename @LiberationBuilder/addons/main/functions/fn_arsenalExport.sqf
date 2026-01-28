/*
 * Function: LBH_fnc_arsenalExport
 * Description: Export current loadout items to Liberation Builder
 *
 * Arguments: None
 *
 * Return Value:
 *   NUMBER - Count of items exported
 *
 * Example:
 *   call LBH_fnc_arsenalExport;
 */

#include "..\script_component.hpp"

// Check if ACE Arsenal is active
if !(isClass (configFile >> "CfgPatches" >> "ace_arsenal")) exitWith {
    ["ACE Arsenal not loaded!", "PLAIN", 2] call LBH_fnc_showNotification;
    0
};

// Get current loadout
private _loadout = player call LBH_fnc_parseLoadout;

if (count _loadout == 0) exitWith {
    ["No items found in loadout!", "PLAIN", 2] call LBH_fnc_showNotification;
    0
};

_loadout params ["_weapons", "_magazines", "_items", "_backpacks"];

private _addedCount = 0;

// Add weapons
{
    if ([_preset, "GRLIB_arsenal_weapons", _x] call LBH_fnc_addClassname) then {
        _addedCount = _addedCount + 1;
    };
} forEach _weapons;

// Add magazines
{
    if (["arsenal", "GRLIB_arsenal_magazines", _x] call LBH_fnc_addClassname) then {
        _addedCount = _addedCount + 1;
    };
} forEach _magazines;

// Add items
{
    if (["arsenal", "GRLIB_arsenal_items", _x] call LBH_fnc_addClassname) then {
        _addedCount = _addedCount + 1;
    };
} forEach _items;

// Add backpacks
{
    if (["arsenal", "GRLIB_arsenal_backpacks", _x] call LBH_fnc_addClassname) then {
        _addedCount = _addedCount + 1;
    };
} forEach _backpacks;

[format ["Exported %1 items from loadout", _addedCount], "PLAIN DOWN", 2] call LBH_fnc_showNotification;

_addedCount
