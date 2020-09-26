//params["_target", "_player", "_params"];
params["_target"];

private _boat = nearestObject [getPosASL _target, "Rubber_duck_base_F"];

if(! isNull _boat && _target distance _boat < 10) then {
	deleteVehicle (_boat getVariable "nameOfShovel");
	deleteVehicle _boat;
};