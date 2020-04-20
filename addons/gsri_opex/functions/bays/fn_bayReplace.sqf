params ["_target", "_player", "_params"];
private ["_type", "_bay", "_cargo"];
_type = (_params select 0);
_bay = (_target getVariable "GSRI_FREMM_associatedBay");
_cargo = (getVehicleCargo _bay) select 0;

// If bay is full, need to empty it first
if!(isNil "_cargo") then
{
	if (typeOf _cargo isEqualTo "B_Boat_Transport_01_F") then { deleteVehicle (_cargo getVariable "nameOfShovel") }; // Shovel bug on CRRC
	deleteVehicle _cargo;
};

if!(_type isEqualTo "") then {
	waitUntil { count (getVehicleCargo _bay) == 0 }; // Previous deletion might take a few frames
	_cargo = createVehicle [_type, [0,0,0], [], 0, "NONE"];
	_bay setVehicleCargo _cargo;
};
