/*
 * Function: LBH_fnc_formatCostArray
 * Description: Format an array of cost items as SQF code
 *
 * Arguments:
 *   0: ARRAY - Array of items [[classname, supplies, ammo, fuel], ...]
 *   1: STRING - Variable name
 *
 * Return Value:
 *   STRING - Formatted SQF code
 *
 * Example:
 *   [_items, "infantry_units"] call LBH_fnc_formatCostArray;
 */

#include "..\script_component.hpp"

params [
    ["_items", [], [[]]],
    ["_varName", "", [""]]
];

if (count _items == 0) exitWith {
    format ["%1 = [];", _varName]
};

private _lines = [];
_lines pushBack format ["%1 = [", _varName];

{
    _x params ["_classname", "_supplies", "_ammo", "_fuel"];

    // Get display name from config
    private _displayName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
    if (_displayName isEqualTo "") then {
        _displayName = getText (configFile >> "CfgWeapons" >> _classname >> "displayName");
    };
    if (_displayName isEqualTo "") then {
        _displayName = getText (configFile >> "CfgMagazines" >> _classname >> "displayName");
    };

    // Format each entry with comment
    private _entry = format ["    [""%1"",%2,%3,%4]", _classname, _supplies, _ammo, _fuel];

    // Add comma if not last item
    if (_forEachIndex < (count _items - 1)) then {
        _entry = _entry + ",";
    };

    // Add display name as comment
    if (_displayName != "") then {
        _entry = _entry + format [" // %1", _displayName];
    };

    _lines pushBack _entry;
} forEach _items;

_lines pushBack "];";

_lines joinString endl
