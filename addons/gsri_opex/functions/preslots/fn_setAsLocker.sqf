// Add Arsenal actions to given object (_locker)
// BI and ACE arsenal, GSRI preslots, ACE medical skills
// by [GSRI] Cheitan

// No serverside task
if(isDedicated) exitWith {};

// Direct type of target object must be Object
params[["_locker", objNull, [ objNull ]]];

// If target object not defined, abort
if(isNull _locker) exitWith {};

private [
	"_actionLockerMain",
	"_actionArsenalMain",
	"_arsenalActions",
	"_actionPreslotMain",
	"_preslotsActions",
	"_actionMedicalMain",
	"_medicalActions"
];

_actionLockerMain = ["actionLockerMain",localize "STR_GSRI_FREMM_lockerMain","",{},{true}] call ace_interact_menu_fnc_createAction;

// Arsenal actions
_actionArsenalMain = ["actionArsenalMain",localize "STR_GSRI_FREMM_arsenalMain","",{},{true}] call ace_interact_menu_fnc_createAction;
_arsenalActions pushBack (["actionArsenalACE",localize "STR_GSRI_FREMM_openArsenalACE","",{params ["_target", "_player"];[_target,_player,true] call ace_arsenal_fnc_openBox},{true}] call ace_interact_menu_fnc_createAction);
_arsenalActions pushBack (["actionArsenalBI",localize "STR_GSRI_FREMM_openArsenalBI","",{["Open",true] spawn bis_fnc_arsenal},{true}] call ace_interact_menu_fnc_createAction);

// Preslot actions
_actionPreslotMain = ["actionPreslotMain",localize "STR_GSRI_FREMM_preslotMain","",{},{true}] call ace_interact_menu_fnc_createAction;
_preslotsActions pushBack (["actionRifleman",localize "STR_GSRI_FREMM_gearAsRifleman","",{call GSRI_fnc_getSoldier},{true}] call ace_interact_menu_fnc_createAction);
_preslotsActions pushBack (["actionGunner",localize "STR_GSRI_FREMM_gearAsGunner","",{call GSRI_fnc_getGunner},{true}] call ace_interact_menu_fnc_createAction);
_preslotsActions pushBack (["actionGrenadier",localize "STR_GSRI_FREMM_gearAsGrenadier","",{call GSRI_fnc_getGrenadier},{true}] call ace_interact_menu_fnc_createAction);
_preslotsActions pushBack (["actionMedic",localize "STR_GSRI_FREMM_gearAsMedic","",{call GSRI_fnc_getMedic},{true}] call ace_interact_menu_fnc_createAction);
_preslotsActions pushBack (["actionDiver",localize "STR_GSRI_FREMM_gearAsDiver","",{call GSRI_fnc_getDiver},{true}] call ace_interact_menu_fnc_createAction);
_preslotsActions pushBack (["actionEmpty",localize "STR_GSRI_FREMM_gearAsEmpty","",{call GSRI_fnc_getEmpty},{true}] call ace_interact_menu_fnc_createAction);

// Medical skills actions
_actionMedicalMain = ["actionMedicalMain",localize "STR_GSRI_FREMM_medicalMain","",{},{true}] call ace_interact_menu_fnc_createAction;
_medicalActions pushBack (["actionNoMed",localize "STR_GSRI_FREMM_medicalNoMed","",{player setVariable ["ace_medical_medicclass", 0]},{true}] call ace_interact_menu_fnc_createAction);
_medicalActions pushBack (["actionMedic",localize "STR_GSRI_FREMM_medicalMedic","",{player setVariable ["ace_medical_medicclass", 1]},{true}] call ace_interact_menu_fnc_createAction);
_medicalActions pushBack (["actionDoctor",localize "STR_GSRI_FREMM_medicalDoctor","",{player setVariable ["ace_medical_medicclass", 2]},{true}] call ace_interact_menu_fnc_createAction);

// Adding tree
[_locker, 0, [], _actionLockerMain] call ace_interact_menu_fnc_addActionToObject;
{ [_locker, 0, ["actionLockerMain"], _x] call ace_interact_menu_fnc_addActionToObject } forEach [_actionArsenalMain,_actionPreslotMain,_actionMedicalMain];
{ [_locker, 0, ["actionLockerMain", "actionArsenalMain"], _x] call ace_interact_menu_fnc_addActionToObject } forEach _arsenalActions;
{ [_locker, 0, ["actionLockerMain", "actionPreslotMain"], _x] call ace_interact_menu_fnc_addActionToObject } forEach _preslotsActions;
{ [_locker, 0, ["actionLockerMain", "actionMedicalMain"], _x] call ace_interact_menu_fnc_addActionToObject } forEach _medicalActions;