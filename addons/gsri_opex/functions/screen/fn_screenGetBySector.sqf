params[["_ship", objNull], ["_sector",""]];

if(isNull _ship) exitWith { ["No such object"] call BIS_fnc_error };

private _ids = switch (_sector) do {
	case "HANGAR": { ["11","12","13","14"] };
	case "MAIN_DECK": { ["21","22","23","24"] };
	case "FORWARD_DECK": { ["31","32","33"] };
	case "BRIDGE": { ["01","02","03","04","05","06","07","08","09"] };
	default { [] };
};

if(count _ids == 0) exitWith { ["Unknown sector %1",_sector] call BIS_fnc_error };

private _screens = [];
{ _screens pushBack ([_ship, format["Display_%1", _x]] call GSRI_fnc_screenGetById)	} forEach _ids;

_screens
