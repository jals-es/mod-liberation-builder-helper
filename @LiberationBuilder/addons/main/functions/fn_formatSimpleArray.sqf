/*
 * Function: LBH_fnc_formatSimpleArray
 * Description: Format a simple string array as SQF code
 *
 * Arguments:
 *   0: ARRAY - Array of classname strings
 *   1: STRING - Variable name
 *   2: BOOLEAN - Inline format (optional, default false)
 *
 * Return Value:
 *   STRING - Formatted SQF code
 *
 * Example:
 *   [_items, "militia_squad"] call LBH_fnc_formatSimpleArray;
 */

#include "..\script_component.hpp"

params [
    ["_items", [], [[]]],
    ["_varName", "", [""]],
    ["_inline", false, [false]]
];

// Filter out empty strings
_items = _items select {_x != ""};

if (count _items == 0) exitWith {
    format ["%1 = [];", _varName]
};

// For very short arrays or inline mode, use single line
if (_inline || {count _items <= 3}) exitWith {
    private _itemsStr = _items apply {format ["""%1""", _x]};
    format ["%1 = [%2];", _varName, _itemsStr joinString ","]
};

// Multi-line format for longer arrays
private _lines = [];
_lines pushBack format ["%1 = [", _varName];

{
    private _classname = _x;
    private _entry = format ["    ""%1""", _classname];

    // Add comma if not last item
    if (_forEachIndex < (count _items - 1)) then {
        _entry = _entry + ",";
    };

    _lines pushBack _entry;
} forEach _items;

_lines pushBack "];";

_lines joinString endl
