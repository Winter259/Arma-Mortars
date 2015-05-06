#include <General_Macros.h>

MOR_CheckForNearbyPlayers =
{
  PARAM_1(_position);
  PVAR_VAL_1(_nearby_players) = _position nearEntities ["Man",MOR_Mortar_Danger_Close_Range];
  PVAR_VAL_1(_player_nearby) = false;
  if ((count _nearby_players) > 0) then
  {
    {
      if (isPlayer _x) exitWith
      {
        _player_nearby = true;
      };
    } forEach _nearby_players;
  };
  [["At position %1 there are nearby entities %2, of which at least one is a player: %3",_position,_nearby_players,_player_nearby]] call MOR_Debug_LogHint;
  _player_nearby;
};

MOR_ReturnRandomPositionInTrigger =
{
  PARAM_1(_trigger);
  PVAR_1(_position);
  _position = if ([_trigger] call MOR_TriggerIsRectangle) then
  {
    [_trigger] call MOR_ReturnRandomPositionInRectangle;
  }
  else
  {
    [_trigger] call MOR_ReturnRandomPositionInEllipse;
  };
  [["Returned random position: %1 from trigger: %2",_position,_trigger]] call MOR_Debug_LogHint;
  _position;
};

MOR_ReturnRandomPositionInEllipse =
{
  PARAM_1(_trigger);
  PVAR_VAL_1(_trigger_position) = getposATL _trigger;
  PVAR_VAL_1(_trigger_size_x) = (triggerArea _trigger) select 0;
  PVAR_VAL_1(_trigger_size_y) = (triggerArea _trigger) select 1;
  PVAR_VAL_1(_phi) = random (2 * pi * 57.3); // 1 radian =~ 57.3 degrees
  PVAR_VAL_1(_rho) = random 1;
  PVAR_VAL_1(_x) = sqrt(_rho) * cos(_phi);
  PVAR_VAL_1(_y) = sqrt(_rho) * sin(_phi);
  PVAR_VAL_1(_pos_x) = (_trigger_position select 0) + (_x * (_trigger_size_x));
  PVAR_VAL_1(_pos_y) = (_trigger_position select 1) + (_y * (_trigger_size_y));
  [_pos_x,_pos_y,0];
};

MOR_ReturnRandomPositionInRectangle =
{
  PARAM_1(_trigger);
  PVAR_VAL_1(_trigger_size_x) = (triggerArea _trigger) select 0;
  PVAR_VAL_1(_trigger_size_y) = (triggerArea _trigger) select 1;
  PVAR_VAL_1(_trigger_position) = getposATL _trigger;
  PVAR_VAL_1(_trigger_bottom_left_corner) = [((_trigger_position select 0) - (_trigger_size_x)),((_trigger_position select 1) - (_trigger_size_y))];
  PVAR_VAL_1(_x) = (_trigger_bottom_left_corner select 0) + ((random _trigger_size_x) * 2);
  PVAR_VAL_1(_y) = (_trigger_bottom_left_corner select 1) + ((random _trigger_size_y) * 2);
  [_x,_y,0];
};

MOR_TriggerIsRectangle =
{
  PARAM_1(_trigger);
  PVAR_VAL_1(_rectangle) = false;
  if ((triggerArea _trigger) select 3) then
  {
    _rectangle = true;
  };
  _rectangle;
};