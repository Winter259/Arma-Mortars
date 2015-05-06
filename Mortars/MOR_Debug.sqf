#include <General_Macros.h>

MOR_Debug_ShowMarkerForMortar =
{
  if (!MOR_Debug) exitWith {};
  PARAM_3(_mortar,_position,_index);
  PVAR_VAL_1(_marker) = [_position,0,[1,1],"hd_dot"] call MOR_Debug_CreateIconMarker;
  _marker setMarkerTextLocal ("Mortar " + str(_index));
  WAIT((isNull _mortar),2);
  _marker setMarkerColorLocal "ColorRed";
  sleep 2;
  deleteMarkerLocal _marker;
};

MOR_Debug_ShowMortarTrigger =
{
  if (!MOR_Debug) exitWith {};
  PARAM_1(_trigger);
  PVAR_1(_marker);
  PVAR_VAL_1(_trigger_area) = triggerArea _trigger;
  if ([_trigger] call MOR_TriggerIsRectangle) then // true for rectanglular triggers
  {
    _marker = [(getposATL _trigger),(_trigger_area select 2),[(_trigger_area select 0),(_trigger_area select 1)]] call MOR_Debug_CreateRectangleMarker;
  }
  else
  {
    _marker = [(getposATL _trigger),(_trigger_area select 2),[(_trigger_area select 0),(_trigger_area select 1)]] call MOR_Debug_CreateEllipseMarker;
  };
  _marker;
};

MOR_Debug_DisableMortarTriggerMarker =
{
  if (!MOR_Debug) exitWith {};
  PARAM_1(_marker);
  _marker setMarkerColorLocal "ColorRed";
};

MOR_Debug_CreateMarker =
{
  if (!MOR_Debug) exitWith {};
  PARAM_4(_position,_direction,_shape,_size);
  PVAR_VAL_1(_marker) = createMarkerLocal ["Mortars_Marker" + str(random 1000),_position];
  _marker setMarkerColorLocal MORTARS_DEBUG_MARKER_COLOUR;
  _marker setMarkerShapeLocal _shape;
  _marker setMarkerSizeLocal _size;
  _marker setMarkerDirLocal _direction;
  [["Marker: %1 created at position: %2 with shape: %3 and size: %4",_marker,_position,_shape,_size]] call MOR_Debug_LogHint;
  _marker;
};

MOR_Debug_CreateIconMarker =
{
  if (!MOR_Debug) exitWith {};
  PARAM_4(_position,_direction,_size,_type);
  PVAR_VAL_1(_marker) = [_position,_direction,"ICON",_size,_type] call MOR_Debug_CreateMarker;
  _marker setMarkerTypeLocal _type;
  _marker;
};

MOR_Debug_CreateEllipseMarker =
{
  if (!MOR_Debug) exitWith {};
  PARAM_3(_position,_direction,_size);
  PVAR_VAL_1(_marker) = [_position,_direction,"ELLIPSE",_size] call MOR_Debug_CreateMarker;
  _marker setMarkerBrushLocal MORTARS_DEBUG_MARKER_BRUSH;
  _marker;
};

MOR_Debug_CreateRectangleMarker =
{
  if (!MOR_Debug) exitWith {};
  PARAM_3(_position,_direction,_size);
  PVAR_VAL_1(_marker) = [_position,_direction,"RECTANGLE",_size] call MOR_Debug_CreateMarker;
  _marker setMarkerBrushLocal MORTARS_DEBUG_MARKER_BRUSH;
  _marker;
};

MOR_Debug_TestRandomPositionInTrigger =
{
  if (!MOR_Debug) exitWith {};
  PARAM_1(_trigger);
  PVAR_4(_i,_position,_marker,_debug_markers);
  [_trigger] call MOR_Debug_ShowMortarTrigger;
  while {true} do
  {
    _debug_markers = [];
    for "_i" from 0 to 100 do
    {
      _position = [_trigger] call MOR_ReturnRandomPositionInTrigger;
      _marker = [_position,0,[1,1],"hd_dot"] call MOR_Debug_CreateIconMarker;
      _debug_markers set [(count _debug_markers),_marker];
      sleep 0.01;
    };
    {
      deleteMarkerLocal _x;
      [["Deleting Marker: %1",_x]] call MOR_Debug_LogHint;
      sleep 0.01;
    } forEach _debug_markers;
    sleep 1;
  };
};

MOR_Debug_LogHint =
{
  if (!MOR_Debug) exitWith {};
  PARAM_1(_message);
  diag_log format ["%1%2%3",time,MORTARS_LOG_HEADER,(format _message)];
  hint format ["%1%2%3",time,MORTARS_LOG_HEADER,(format _message)];
};