//params["_target", "_player", "_params"];
params["_target"];
private _crrc = "B_Boat_Transport_01_F" createVehicle [0,0,0];
private _spawner = _target getVariable "GSRI_FREMM_associatedSpawner";
_crrc setDir (getDir _spawner + 180);
_crrc setPosWorld getPosWorld _spawner;
