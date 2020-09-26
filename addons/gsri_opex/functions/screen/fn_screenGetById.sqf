params[["_ship", objNull], ["_id",""]];

if(isNull _ship) exitWith { ["No such object"] call BIS_fnc_error };
if(_id == "") exitWith { ["No ID provided"] call BIS_fnc_error };

private _screen = objNull;
{
	if(_x getVariable "GSRI_display_id" == _id) exitWith { _screen = _x	};
} forEach (_ship getVariable ["GSRI_FREMM_screens",[]]);

_screen