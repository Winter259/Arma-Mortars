#include <General_Macros.h>

MOR_Init = 
{
  [["Mortar scirpt version %1, starting init.",MORTARS_VERSION_STR]] call MOR_Log;
  MOR_Initialised = false;
  [] call MOR_InitVariables;
  [] call MOR_DetermineArmaVersion; // figures out if A2 or A3
  [] call MOR_Precompile_Functions;
  MOR_Initialised = true;
  publicVariable "MOR_Initialised";
  [["Mortar script has finished initialisation."]] call MOR_Log;
  [["Mortar script has finished initialisation."]] call MOR_Debug_LogHint;
  [] call MOR_AllowMortars;
};

MOR_InitVariables =
{
  MOR_Mortars_Can_Start = false;
  MOR_Stop_Mortar_ID = 0;
  if (isMultiplayer) then
  {
    MOR_Debug = false; // suppress debug info in multiplayer environments.
  };
};

MOR_Precompile_Functions =
{
  PRECOMPILE("Mortars\MOR_Settings.sqf");
  PRECOMPILE("Mortars\MOR_Debug.sqf");
  PRECOMPILE("Mortars\MOR_Trigger_Functions.sqf");
  PRECOMPILE("Mortars\MOR_Mortar_Functions.sqf");
};

MOR_DetermineArmaVersion =
{
  MOR_Arma = 0;
  if (isNil {call compile "blufor"}) then
	{
		MOR_Arma = 2;
	}
	else
	{
		MOR_Arma = 3;
	};
  [["Mortar script running in Arma Version: %1.",MOR_Arma]] call MOR_Log;
  publicVariable "MOR_Arma";
};

MOR_AllowMortars =
{
  if (MOR_WaitForHullSafety) then
  {
    [] call MOR_WaitForHullSafetyOff;
    MOR_Mortars_Can_Start = true;
  }
  else
  {
    MOR_Mortars_Can_Start = true;
  };
};

MOR_WaitForHullSafetyOff =
{
  if (MOR_Arma == 2) then
  {
    WAIT(([] call hull_mission_fnc_hasSafetyTimerEnded),3);
  }
  else
  {
    WAIT(([] call hull3_mission_fnc_hasSafetyTimerEnded),3);
  };
};

MOR_Log =
{
  PARAM_1(_message);
  diag_log format ["%1%2%3",time,MORTARS_LOG_HEADER,(format _message)];
};