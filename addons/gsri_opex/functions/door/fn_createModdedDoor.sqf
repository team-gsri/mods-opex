/*
 * Author: [-GSRI-] Cheitan
 * Create objects and actions representing a door that will not open, but traversable anyway by teleporting the player.
 *
 * Arguments:
 * _doorData: array
 ** _refObject : object the handle will be attached to.
 ** _handlePos : the object's model reference position of the handle.
 ** _egressPos : the object's model reference position of exit.
 ** _egressDir : the object's model reference direction of exit.
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myShip, [2, 2, -1], [3, 1, 0.6], 90] call gsri_fnc_createModdedDoor;
 *
 * Public: No
 */

params [
    ["_refObject", objNull],
    ["_handlePos", [0,0,0]],
    ["_egressPos", [0,0,0]],
    ["_egressDir", 0]
];

if(isNull _refObject) exitWith {};

private _goThroughDoor = [
    "goThroughDoor",
    localize "STR_GSRI_FREMM_crewCrossDoor",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa",
    {
        params["_target", "_player", "_params"];
        private _destination = _target getVariable "gsri_moddedDoor_destination";
        private _refObject = (attachedTo _target);
        _player setPosWorld (_refObject modelToWorldWorld (_destination get "position"));
        _player setDir (getDir _refObject + (_destination get "direction"));
    },
    {true},
    {},
    [],
    [0,0,0],
    1
] call ACE_interact_menu_fnc_createAction;

private _handle = "Sign_Sphere10cm_F" createVehicleLocal getPos _refObject;
_handle attachTo [_refObject, _handlePos];
_handle setVariable ["gsri_moddedDoor_destination", createHashMapFromArray [["position",_egressPos],["direction",_egressDir]]];
_handle setObjectTexture[0, ""];
[_handle, 0, [], _goThroughDoor] call ACE_interact_menu_fnc_addActionToObject;
