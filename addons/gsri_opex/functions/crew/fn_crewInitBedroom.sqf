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

if!(isDedicated) then {
    private _inBedAction = {
        params["_target", "_player", "_index"];
        _player moveInCargo [_target, _index];
    };
    private _inBedCondition = {
        params["_target", "_player", "_index"];
        private _bed = (fullCrew [_target, "cargo", true]) select _index;
        if!(isNull (_bed select 0)) exitWith { false };
        true
    };

    {
        private _inBedX = [
            format["inBed%1", _forEachIndex],
            "Dodo",
            "",
            _inBedAction,
            _inBedCondition,
            {},
            _forEachIndex,
            _x
        ] call ACE_interact_menu_fnc_createAction;
        [_bedroom, 0, [], _inBedX] call ACE_interact_menu_fnc_addActionToObject;
    } forEach [[0.8,2.9,-0.3],[-0.8,2.9,-0.3],[-0.8,2.9,-1.3],[0.8,2.9,-1.3]];
};
