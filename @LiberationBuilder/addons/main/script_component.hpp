// Liberation Builder Helper - Component Macros
#define COMPONENT main
#define COMPONENT_BEAUTIFIED Liberation Builder Helper

#define PREFIX LBH
#define MAJOR 1
#define MINOR 0
#define PATCH 0
#define BUILD 0

#define VERSION MAJOR.MINOR.PATCH.BUILD
#define VERSION_STR "1.0.0.0"
#define VERSION_AR MAJOR,MINOR,PATCH,BUILD

// Macro for function name
#define FUNC(var1) PREFIX##_fnc_##var1
#define QFUNC(var1) QUOTE(FUNC(var1))

// Quote macro
#define QUOTE(var1) #var1
#define DOUBLES(var1,var2) var1##_##var2

// Dialog IDDs
#define IDD_MAIN_PANEL 58001
#define IDD_COST_DIALOG 58002
#define IDD_CATEGORY_SELECT 58003

// Control IDCs
#define IDC_PRESET_COMBO 1001
#define IDC_CATEGORY_COMBO 1002
#define IDC_CLASSNAME_LIST 1003
#define IDC_SEARCH_EDIT 1004
#define IDC_BTN_ADD 1005
#define IDC_BTN_REMOVE 1006
#define IDC_BTN_EXPORT 1007
#define IDC_BTN_CLEAR 1008
#define IDC_BTN_CLOSE 1009
#define IDC_STATUS_TEXT 1010

// Cost dialog controls
#define IDC_COST_SUPPLIES 2001
#define IDC_COST_AMMO 2002
#define IDC_COST_FUEL 2003
#define IDC_COST_OK 2004
#define IDC_COST_CANCEL 2005
#define IDC_COST_CLASSNAME 2006

// Category select controls
#define IDC_CATSEL_LIST 3001
#define IDC_CATSEL_OK 3002
#define IDC_CATSEL_CANCEL 3003
