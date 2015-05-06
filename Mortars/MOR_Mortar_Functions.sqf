#include <General_Macros.h>

MOR_FireMortarsHere =
{
  PARAM_2(_trigger,_mortar_ID);
  PVAR_5(_position,_i,_marker,_mortar,_danger_close);
  PVAR_VAL_1(_stop_loop) = false;
  if (isNil "_mortar_ID") exitWith
  {
    [["Mortars on trigger %1 not provided with a valid ID number! Mortars will NOT start!",_trigger]] call MOR_Log;
    [["Mortars on trigger %1 not provided with a valid ID number! Mortars will NOT start!",_trigger]] call MOR_Debug_LogHint;
  };
  _marker = [_trigger] call MOR_Debug_ShowMortarTrigger;
  WAIT(MOR_Mortars_Can_Start,2);
  [["Mortars starting at trigger: %1.",_trigger]] call MOR_Log;
  [["Mortars starting at trigger: %1.",_trigger]] call MOR_Debug_LogHint;
  while {!_stop_loop} do
  {
    for "_i" from 1 to MOR_Volley_Amount do
    {
      _position = [_trigger] call MOR_ReturnRandomPositionInTrigger; 
      _danger_close = [_position] call MOR_CheckForNearbyPlayers;
      if (!_danger_close) then
      {
        _mortar = [_position] call MOR_SpawnMortar;
        [_mortar,_position,_i] spawn MOR_Debug_ShowMarkerForMortar;
      };
      if (_danger_close) then
      {
        [["Mortar: %1 in volley NOT fired due to danger close players!",_i]] call MOR_Debug_LogHint;
        [["Mortar: %1 in volley NOT fired due to danger close players!",_i]] call MOR_Log;
      }
      else
      {
        [["Mortar: %1 in volley finished. Another firing in: %2 seconds.",_i,MOR_Mortar_Delay]] call MOR_Debug_LogHint;
      };
      sleep MOR_Mortar_Delay;
      _stop_loop = [_mortar_ID] call MOR_CheckForMortarStop;
      if (_stop_loop) exitWith
      {
        sleep 2;
        [["Mortars falling at trigger %1 were disabled!",_trigger]] call MOR_Debug_LogHint;
        [_marker] call MOR_Debug_DisableMortarTriggerMarker; // turns marker red 
      };
    };
    if (!_stop_loop) then
    {
      [["Mortar volley finished. Another starting in %2 second/s.",_trigger,MOR_Volley_Delay]] call MOR_Debug_LogHint;
      sleep MOR_Volley_Delay;
    };
  };
};

MOR_CheckForMortarStop =
{
  PARAM_1(_mortar_ID);
  PVAR_VAL_1(_stop) = false;
  if (_mortar_ID == MOR_Stop_Mortar_ID) then
  {
    [["Mortars on triggers with ID: %1 has been disabled.",_mortar_ID]] call MOR_Debug_LogHint;
    [["Mortars on triggers with ID: %1 has been disabled.",_mortar_ID]] call MOR_Log;
    _stop = true;
  };
  _stop;
};

MOR_SpawnMortar =
{
  PARAM_1(_position);
  _position set [2,MOR_Mortar_Spawn_Height]; // change z axis to mortar height.
  PVAR_VAL_1(_mortar) = createVehicle [MOR_Mortar_Classname,_position,[],0,"NONE"];
  WAIT((!isNull _mortar),1);
  _mortar setVelocity [0,0,MOR_Mortar_Drop_Speed];
  [["Mortar: %1 spawned at position: %2",_mortar,_position]] call MOR_Debug_LogHint;
  _mortar;
};