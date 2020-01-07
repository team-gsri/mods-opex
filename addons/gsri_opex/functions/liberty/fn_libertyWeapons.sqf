// Script de création et mise en place de l'armement du navire
// by [LM] Cheitan

if!(isServer) exitWith {};

// Récupération de la référence du navire
params["_navire"];

// Mk45 Hammer
_hammer = createVehicle ["B_Ship_Gun_01_F", [0,0,0], [], 0, "NONE"];
_hammer allowDamage false;
_hammer setDir (getDir _navire + 180);
_hammer setPosASL (_navire modelToWorldWorld [0,-79.08,12.1]);
createVehicleCrew _hammer;
_navire setVariable ["LM_hammer", _hammer, true];
_hammer allowDamage true;
_hammer disableAI "TARGET";
_hammer disableAI "AUTOTARGET";

// Système VLS
_vls = createVehicle ["B_Ship_MRLS_01_F", [0,0,0], [], 0, "NONE"];
_vls allowDamage false;
_vls setDir (getDir _navire + 180);
_vls setPosASL (_navire modelToWorldWorld [0,-62.4229,10.7]);
createVehicleCrew _vls;
_navire setVariable ["LM_vls", _vls, true];
_vls allowDamage true;
_vls disableAI "TARGET";
_vls disableAI "AUTOTARGET";

// Praetorian-1C avant
_aa1 = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
_aa1 allowDamage false;
_aa1 setDir (getDir _navire + 180);
_aa1 setPosASL (_navire modelToWorldWorld [0,-48.106,15.1]);
createVehicleCrew _aa1;
_navire setVariable ["LM_aa1", _aa1, true];
_aa1 allowDamage true;
_aa1 disableAI "TARGET";
_aa1 disableAI "AUTOTARGET";

// Praetorian-1C arrière
_aa2 = createVehicle ["B_AAA_System_01_F", [0,0,0], [], 0, "NONE"];
_aa2 allowDamage false;
_aa2 setDir (getDir _navire);
_aa2 setPosASL (_navire modelToWorldWorld [0,36.3765,19.3]);
createVehicleCrew _aa2;
_navire setVariable ["LM_aa2", _aa2, true];
_aa2 allowDamage true;
_aa2 disableAI "TARGET";
_aa2 disableAI "AUTOTARGET";

// Mk49 Spartan
_spartan = createVehicle ["B_SAM_System_01_F", [0,0,0], [], 0, "NONE"];
_spartan allowDamage false;
_spartan setDir (getDir _navire);
_spartan setPosASL (_navire modelToWorldWorld [0,50.6011,15.8]);
createVehicleCrew _spartan;
_navire setVariable ["LM_spartan", _spartan, true];
_spartan allowDamage true;
_spartan disableAI "TARGET";
_spartan disableAI "AUTOTARGET";