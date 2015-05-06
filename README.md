# Arma-Mortars
Simple ArmA scripts for mortars.

Features:
* Adjustable delays between mortars/mortar volleys.
* Adjustable mortar drop speed.
* Adjustable mortar classname.
* Compatible with both ArmA2 OA and ArmA3.
* Easy to set up.
* Can be set to avoid spawning mortars directly over players with an adjustable "danger close" distance.
* Debug system with markers to indicate mortar trigger position & mortar landing locations.

Instructions:
* Place the Mortars folder in your mission folder.
* Add the following line to your init.sqf: null = [] execVM "Mortars\MOR_Compile.sqf";
* Adjust the settings as required in Mortars\MOR_Settings.sqf
* Place a trigger in the editor and include the following:

PLACEHOLDER FOR IMAGE1

This is the trigger where the mortars will fall, a random position is selected per mortar within the trigger.
Condition:

  MOR_Mortars_Can_Start

You can add any number of other conditions via &&
  
On ACT:

  null = [thisTrigger,MORTARID] spawn MOR_FireMortarsHere;
  
The MORTARID is a custom integer (not neccesarily 1 like the example) set by the mission maker to designate the trigger for disabling the mortars later on (still required even if the trigger will not be disabled). Any number of triggers can have the same number, so the mission maker can put mortars in different locations but disable them all at once.

* If you want to disable the trigger mortars after they start, place a trigger with the following:

PLACEHOLDER FOR IMAGE2

Syntax:

  MOR_Stop_Mortar_ID = REQUIREDID;

REQUIREDID is the integer assigned to the trigger which you wish to be disabled.

Settings:

* MOR_Mortar_Delay: Delay in seconds between mortar spawns within a volley. Default: 1
* MOR_Volley_Amount: amount of mortar spawns that form a volley. The scripts do not compensate for mortars not fired due to danger close players. Default: 20
* MOR_Volley_Delay: Delay in seconds between volleys. Default: 15
* MOR_WaitForHullSafety: If not being used with the hull or hull3 framework, set this to false, otherwise it will wait until Hull safety is turned off. Default: true
* MOR_Mortar_Classname: Ammo classname of the mortar being shot. Currently only supports one classname for all mortars. Default: "Sh_82mm_AMOS" (Note that this is an A3 mortar!)
* MOR_Mortar_Danger_Close_Range: Range a player has to be within for a mortar to NOT spawn. Default: 75
* MOR_Mortar_Spawn_Height: Height at which a mortar is spawned. Default: 1000