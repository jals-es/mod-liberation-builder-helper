// Liberation Builder Helper - CBA Post-Init
// Executed after mission init

#include "script_component.hpp"

// Initialize ACE Arsenal integration if ACE is loaded
if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    call LBH_fnc_arsenalInit;
    diag_log "[LBH] ACE Arsenal integration initialized";
};

// Mark as fully initialized
LBH_initialized = true;

diag_log "[LBH] PostInit completed - Liberation Builder Helper ready";

// Keybind registration is now handled in XEH_preInit.sqf
