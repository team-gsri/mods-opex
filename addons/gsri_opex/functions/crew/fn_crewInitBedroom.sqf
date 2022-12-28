/*
 * Author: [-GSRI-] Cheitan
 * Add client-side actions to given object, supposed to be a bedroom, especially :
 ** "Get in bed" actions
 *
 * Arguments:
 * _bedroom : object
 *
 * Return Value:
 * None
 *
 * Example:
 * [myBedroom] call gsri_fnc_crewInitBedroom
 *
 * Public: No
 */

params ["_bedroom"];

if(isDedicated) exitWith {};
if(typeOf _bedroom != "SCMS_bedroom") exitWith {};

// The passed object is the bedroom itself, in case future functions would be added to cabins.
// For the sleeping actions, we need to extract the (firstly found) attached beds.
private _attachedObjects = attachedObjects _bedroom;
private _actualBeds = objNull;
{
    if(typeOf _x == "SCMS_Beds") exitWith { _actualBeds = _x };
} forEach _attachedObjects;

if!(isDedicated) then {
    // Actions to lay down in beds
    if!(isNull _actualBeds) then {
        private _inBedAction = {
            params["_target", "_player", "_index"];
            _player moveInCargo [_target, _index];
        };
        private _inBedCondition = {
            params["_target", "_player", "_index"];
            private _bedSlot = (fullCrew [_target, "cargo", true]) select _index;
            if!(isNull (_bedSlot select 0)) exitWith { false };
            true
        };

        {
            private _inBedX = [
                format["inBed%1", _forEachIndex],
                localize "STR_GSRI_FREMM_crewLieDown",
                "\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa",
                _inBedAction,
                _inBedCondition,
                {},
                _forEachIndex,
                _x
            ] call ACE_interact_menu_fnc_createAction;
            [_actualBeds, 0, [], _inBedX] call ACE_interact_menu_fnc_addActionToObject;
        } forEach [[0.8,2.9,-0.3],[-0.8,2.9,-0.3],[-0.8,2.9,-1.3],[0.8,2.9,-1.3]];
    };
};
