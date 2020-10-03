if!(isServer) exitWith {};

params["_ship"];

private _fuelpump = "Land_FuelStation_01_pump_malevil_F" createVehicle [0,0,0];
_fuelpump attachTo [_ship, [9.63,40.13,10.15]];
_fuelpump setDir 90;
_ship setVariable ["GSRI_FREMM_heliFuelPump", _fuelpump];