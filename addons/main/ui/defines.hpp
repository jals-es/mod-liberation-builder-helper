// Liberation Builder Helper - UI Defines

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO 0x800
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Colors
#define COLOR_BLACK       {0, 0, 0, 1}
#define COLOR_WHITE       {1, 1, 1, 1}
#define COLOR_GRAY        {0.5, 0.5, 0.5, 1}
#define COLOR_DARK_GRAY   {0.2, 0.2, 0.2, 1}
#define COLOR_LIGHT_GRAY  {0.8, 0.8, 0.8, 1}
#define COLOR_TRANSPARENT {0, 0, 0, 0}
#define COLOR_BLUE        {0.1, 0.3, 0.6, 1}
#define COLOR_GREEN       {0.1, 0.6, 0.3, 1}
#define COLOR_RED         {0.6, 0.1, 0.1, 1}
#define COLOR_ORANGE      {0.85, 0.55, 0, 1}

// Background colors
#define COLOR_BG_DARK     {0.1, 0.1, 0.1, 0.9}
#define COLOR_BG_PANEL    {0.15, 0.15, 0.15, 0.95}
#define COLOR_BG_ELEMENT  {0.2, 0.2, 0.2, 1}
#define COLOR_BG_ACTIVE   {0.25, 0.25, 0.3, 1}

// Button colors
#define COLOR_BTN_NORMAL  {0.3, 0.3, 0.35, 1}
#define COLOR_BTN_ACTIVE  {0.4, 0.4, 0.5, 1}
#define COLOR_BTN_DISABLED {0.2, 0.2, 0.2, 0.5}

// Font
#define GUI_FONT "RobotoCondensed"
#define GUI_FONT_BOLD "RobotoCondensedBold"

// Base sizes
#define GUI_GRID_W (0.025)
#define GUI_GRID_H (0.04)
#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY)

// Base control classes
class LBH_RscText {
    idc = -1;
    type = CT_STATIC;
    style = ST_LEFT;
    x = 0;
    y = 0;
    w = 0.3;
    h = 0.03;
    font = GUI_FONT;
    sizeEx = 0.03;
    colorBackground[] = COLOR_TRANSPARENT;
    colorText[] = COLOR_WHITE;
    text = "";
    shadow = 1;
};

class LBH_RscTitle : LBH_RscText {
    style = ST_CENTER;
    sizeEx = 0.04;
    colorBackground[] = COLOR_BLUE;
};

class LBH_RscButton {
    idc = -1;
    type = CT_BUTTON;
    style = ST_CENTER;
    x = 0;
    y = 0;
    w = 0.12;
    h = 0.04;
    font = GUI_FONT;
    sizeEx = 0.03;
    colorText[] = COLOR_WHITE;
    colorDisabled[] = {0.5, 0.5, 0.5, 1};
    colorBackground[] = COLOR_BTN_NORMAL;
    colorBackgroundActive[] = COLOR_BTN_ACTIVE;
    colorBackgroundDisabled[] = COLOR_BTN_DISABLED;
    colorFocused[] = COLOR_BTN_ACTIVE;
    colorShadow[] = {0, 0, 0, 0.5};
    colorBorder[] = {0, 0, 0, 1};
    soundEnter[] = {"", 0.1, 1};
    soundPush[] = {"", 0.1, 1};
    soundClick[] = {"", 0.1, 1};
    soundEscape[] = {"", 0.1, 1};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.001;
    offsetPressedY = 0.001;
    borderSize = 0;
    shadow = 0;
    text = "";
    action = "";
};

class LBH_RscEdit {
    idc = -1;
    type = CT_EDIT;
    style = ST_LEFT;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.03;
    font = GUI_FONT;
    sizeEx = 0.03;
    colorBackground[] = COLOR_BG_ELEMENT;
    colorText[] = COLOR_WHITE;
    colorSelection[] = COLOR_BLUE;
    colorDisabled[] = {0.5, 0.5, 0.5, 1};
    autocomplete = "";
    text = "";
    shadow = 0;
};

class LBH_RscCombo {
    idc = -1;
    type = CT_COMBO;
    style = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.03;
    font = GUI_FONT;
    sizeEx = 0.03;
    wholeHeight = 0.3;
    colorBackground[] = COLOR_BG_ELEMENT;
    colorText[] = COLOR_WHITE;
    colorSelect[] = COLOR_WHITE;
    colorSelectBackground[] = COLOR_BLUE;
    colorDisabled[] = {0.5, 0.5, 0.5, 1};
    colorScrollbar[] = {1, 1, 1, 1};
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    soundSelect[] = {"", 0.1, 1};
    soundExpand[] = {"", 0.1, 1};
    soundCollapse[] = {"", 0.1, 1};
    maxHistoryDelay = 1;
    class ComboScrollBar {
        color[] = {1, 1, 1, 1};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        shadow = 0;
    };
};

class LBH_RscListBox {
    idc = -1;
    type = CT_LISTBOX;
    style = 0;
    x = 0;
    y = 0;
    w = 0.3;
    h = 0.4;
    font = GUI_FONT;
    sizeEx = 0.028;
    rowHeight = 0.035;
    colorBackground[] = COLOR_BG_ELEMENT;
    colorText[] = COLOR_WHITE;
    colorSelect[] = COLOR_WHITE;
    colorSelect2[] = COLOR_WHITE;
    colorSelectBackground[] = COLOR_BLUE;
    colorSelectBackground2[] = COLOR_BLUE;
    colorScrollbar[] = {1, 1, 1, 1};
    colorDisabled[] = {0.5, 0.5, 0.5, 1};
    soundSelect[] = {"", 0.1, 1};
    period = 0;
    maxHistoryDelay = 1;
    class ListScrollBar {
        color[] = {1, 1, 1, 1};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        shadow = 0;
    };
};

class LBH_RscListNBox {
    idc = -1;
    type = CT_LISTNBOX;
    style = 0;
    x = 0;
    y = 0;
    w = 0.4;
    h = 0.4;
    font = GUI_FONT;
    sizeEx = 0.028;
    rowHeight = 0.035;
    columns[] = {0, 0.6, 0.75, 0.85};
    colorBackground[] = COLOR_BG_ELEMENT;
    colorText[] = COLOR_WHITE;
    colorSelect[] = COLOR_WHITE;
    colorSelect2[] = COLOR_WHITE;
    colorSelectBackground[] = COLOR_BLUE;
    colorSelectBackground2[] = COLOR_BLUE;
    colorScrollbar[] = {1, 1, 1, 1};
    colorDisabled[] = {0.5, 0.5, 0.5, 1};
    soundSelect[] = {"", 0.1, 1};
    period = 0;
    maxHistoryDelay = 1;
    drawSideArrows = 0;
    idcLeft = -1;
    idcRight = -1;
    class ListScrollBar {
        color[] = {1, 1, 1, 1};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        shadow = 0;
    };
};

class LBH_RscFrame {
    idc = -1;
    type = CT_STATIC;
    style = ST_FRAME;
    x = 0;
    y = 0;
    w = 0.3;
    h = 0.3;
    font = GUI_FONT;
    sizeEx = 0.03;
    colorBackground[] = COLOR_TRANSPARENT;
    colorText[] = COLOR_WHITE;
    text = "";
    shadow = 0;
};

class LBH_RscBackground {
    idc = -1;
    type = CT_STATIC;
    style = ST_BACKGROUND;
    x = 0;
    y = 0;
    w = 0.3;
    h = 0.3;
    colorBackground[] = COLOR_BG_PANEL;
    colorText[] = COLOR_WHITE;
    font = GUI_FONT;
    sizeEx = 0.03;
    text = "";
};

// Dialog IDD constants (must match script_component.hpp)
#define IDD_MAIN_PANEL      58001
#define IDD_COST_DIALOG     58002
#define IDD_CATEGORY_SELECT 58003
#define IDD_EXPORT_WIZARD   58004

// Main Panel IDCs (must match script_component.hpp)
#define IDC_PRESET_COMBO    1001
#define IDC_CATEGORY_COMBO  1002
#define IDC_CLASSNAME_LIST  1003
#define IDC_SEARCH_EDIT     1004
#define IDC_BTN_ADD         1005
#define IDC_BTN_REMOVE      1006
#define IDC_BTN_EXPORT      1007
#define IDC_BTN_CLEAR       1008
#define IDC_BTN_CLOSE       1009
#define IDC_STATUS_TEXT     1010
#define IDC_BTN_EDIT        1011

// Cost Dialog IDCs (must match script_component.hpp)
#define IDC_COST_SUPPLIES   2001
#define IDC_COST_AMMO       2002
#define IDC_COST_FUEL       2003
#define IDC_COST_OK         2004
#define IDC_COST_CANCEL     2005
#define IDC_COST_CLASSNAME  2006

// Category Select Dialog IDCs (must match script_component.hpp)
#define IDC_CATSEL_LIST     3001
#define IDC_CATSEL_OK       3002
#define IDC_CATSEL_CANCEL   3003

// Export Wizard Dialog IDCs
#define IDC_WIZARD_PATH         5801
#define IDC_WIZARD_BROWSE       5802
#define IDC_WIZARD_RECENT       5803
#define IDC_WIZARD_STATUS       5804
#define IDC_WIZARD_CLOSE        5805

// Export Wizard - Copy buttons per preset
#define IDC_WIZARD_COPY_BLUFOR      5810
#define IDC_WIZARD_COPY_OPFOR       5811
#define IDC_WIZARD_COPY_RESISTANCE  5812
#define IDC_WIZARD_COPY_CIVILIANS   5813
#define IDC_WIZARD_COPY_ARSENAL     5814

// Export Wizard - Open folder buttons per preset
#define IDC_WIZARD_OPEN_BLUFOR      5820
#define IDC_WIZARD_OPEN_OPFOR       5821
#define IDC_WIZARD_OPEN_RESISTANCE  5822
#define IDC_WIZARD_OPEN_CIVILIANS   5823
#define IDC_WIZARD_OPEN_ARSENAL     5824

// Export Wizard - Item count labels per preset
#define IDC_WIZARD_COUNT_BLUFOR     5830
#define IDC_WIZARD_COUNT_OPFOR      5831
#define IDC_WIZARD_COUNT_RESISTANCE 5832
#define IDC_WIZARD_COUNT_CIVILIANS  5833
#define IDC_WIZARD_COUNT_ARSENAL    5834

// Text Input Dialog
#define IDD_TEXT_INPUT          58005
#define IDC_TEXT_INPUT_LABEL    6001
#define IDC_TEXT_INPUT_EDIT     6002
#define IDC_TEXT_INPUT_OK       6003
#define IDC_TEXT_INPUT_CANCEL   6004

// Import Wizard Dialog
#define IDD_IMPORT_WIZARD           58007
#define IDC_IMPORT_COUNT_BLUFOR     8001
#define IDC_IMPORT_COUNT_OPFOR      8002
#define IDC_IMPORT_COUNT_RESISTANCE 8003
#define IDC_IMPORT_COUNT_CIVILIANS  8004
#define IDC_IMPORT_COUNT_ARSENAL    8005
#define IDC_IMPORT_CLOSE            8006

// Import Text Area Dialog
#define IDD_IMPORT_TEXTAREA         58008
#define IDC_IMPORT_TEXT             8101
#define IDC_IMPORT_BTN_MERGE       8102
#define IDC_IMPORT_BTN_REPLACE     8103
#define IDC_IMPORT_SAVE            8104
#define IDC_IMPORT_CANCEL          8105
#define IDC_IMPORT_TA_STATUS       8106
