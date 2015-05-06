// Add:
// null = [] execVM "Mortars\MOR_Compile.sqf";
// to the init.sqf

if (isServer || !isMultiplayer) then
{
  call compile preprocessFileLineNumbers "Mortars\MOR_Init.sqf";
  [] spawn MOR_Init;
};