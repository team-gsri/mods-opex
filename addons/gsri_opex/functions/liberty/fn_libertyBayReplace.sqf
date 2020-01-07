params ["_target", "_player", "_params"];
_type = (_params select 0);
_baie = (_target getVariable "baie");
_cargo = (getVehicleCargo _baie) select 0;

// Si il y a déjà un véhicule on le supprime
if!(isNil "_cargo") then
{
	if (typeOf _cargo isEqualTo "B_Boat_Transport_01_F") then { deleteVehicle (_cargo getVariable "nameOfShovel") }; // Suppression de la pelle
	deleteVehicle _cargo; // Suppression du cargo
};

if!(_type isEqualTo "") then {
	// Vérif vide et chargement du nouveau cargo
	waitUntil { count (getVehicleCargo _baie) == 0 };
	_cargo = createVehicle [_type, [0,0,0], [], 0, "NONE"];
	_baie setVehicleCargo _cargo;
};