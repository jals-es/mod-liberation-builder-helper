/*
 * Function: LBH_fnc_getCategories
 * Description: Get the list of categories for a preset
 *
 * Arguments:
 *   0: STRING - Preset name (blufor, opfor, etc.)
 *
 * Return Value:
 *   ARRAY - Array of [categoryKey, displayName, formatType]
 *
 * Example:
 *   "blufor" call LBH_fnc_getCategories;
 */

#include "..\script_component.hpp"

params [["_preset", "", [""]]];

if (_preset isEqualTo "") exitWith {[]};

LBH_categories getOrDefault [_preset, []]
