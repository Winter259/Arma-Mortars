#include <General_Macros.h>

MOR_Mortar_Delay = 1; // Delay in seconds between mortar spawns within one volley
MOR_Volley_Amount = 20; // Amount of mortars fired in one volley
MOR_Volley_Delay = 15; // Delay between volleys
MOR_WaitForHullSafety = true; // If true, will only start any loops AFTER hull safety is turned off.

// If using A2, make sure to change the mortar classname, example: "ARTY_Sh_82_HE", as the default is an A3 mortar classname.
MOR_Mortar_Classname = MORTARS_CLASSNAME_DEFAULT;
MOR_Mortar_Danger_Close_Range = MORTARS_DANGER_CLOSE_RADIUS;
MOR_Mortar_Spawn_Height = MORTARS_SPAWN_HEIGHT_DEFAULT;
MOR_Mortar_Drop_Speed = MORTARS_DROP_SPEED_DEFAULT; // a drop speed higher (negatively) than -10 is required for A2

MOR_Debug = true;