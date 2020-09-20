// Add usable screens on Liberty-class ships
// by [GSRI] Cheitan
// serverside only

if!(isServer) exitWith {};

params["_ship"];
private ["_screenData", "_screenList", "_drivingScreens", "_meteoScreens"];

// Editable screens all over the ship
_screenData = [
	["SCMS_Small_screen",[-9.81152,34.2251,12.4915],[0.000790648,1,-0.000468702],[0.156811,0.000338923,0.987629],"Display_11"],
	["SCMS_Small_screen",[8.64453,33.8545,12.9025],[-0.000759117,-1,0.000184258],[-0.519295,0.000551671,0.854595],"Display_12"],
	["SCMS_Small_screen",[8.65137,37.6348,12.9026],[-0.000759117,-1,0.000184258],[-0.519295,0.000551671,0.854595],"Display_13"],
	["SCMS_Large_screen",[1.73926,27.4673,10.6425],[-0.00872645,-0.999962,0],[0,0,1],"Display_14"],

	["SCMS_Small_screen",[-2.51465,14.3547,9.82775],[0.0693154,0.997594,-0.000827764],[0.519969,-0.0354206,0.853451],"Display_21"],
	["SCMS_Small_screen",[-1.60791,3.2915,9.95117],[0.452047,0.891991,0.00234991],[0.462519,-0.236648,0.854444],"Display_22"],
	["SCMS_Small_screen",[1.82178,-11.4988,9.94559],[-0.0190543,-0.999802,-0.00567423],[-0.518946,0.00503888,0.854792],"Display_23"],
	["SCMS_Small_screen",[2.22461,-16.2424,9.202],[0.00141636,-0.999997,0.00211963],[-0.0304679,0.00207549,0.999534],"Display_24"],

	["SCMS_Small_screen",[0.239258,-28.4563,13.0112],[0.996067,0.0883529,0.00672783],[0.0399443,-0.5155,0.855958],"Display_31"],
	["SCMS_Small_screen",[7.22119,-39.7256,12.904],[0.0672956,-0.997733,0.000252854],[-0.517336,-0.0346769,0.855079],"Display_32"],
	["SCMS_Small_screen",[-5.32471,-39.311,12.895],[0.0635723,-0.997975,-0.00200963],[-0.517336,-0.0346769,0.855079],"Display_33"],

	["SCMS_Small_screen",[5.68799,-30.5166,21.1405],[0.234759,-0.972051,0.00246766],[-0.507815,-0.120476,0.853],"Display_09"],
	["SCMS_Small_screen",[3.81934,-39.5286,21.5373],[-0.00116014,-0.999999,0.000448126],[-0.515865,0.000982367,0.856669],"Display_01"],
	["SCMS_Small_screen",[3.41504,-40.8472,21.5233],[-0.566493,-0.824051,-0.00507607],[-0.427393,0.288533,0.856787],"Display_02"],
	["SCMS_Small_screen",[2.14697,-41.5691,21.5332],[-0.999999,0.00116276,-5.01424e-006],[0.000588797,0.510091,0.86012],"Display_03"],
	["SCMS_Small_screen",[0.728027,-41.5525,21.5499],[-0.999999,0.00144494,0.000467002],[0.0011458,0.516154,0.856495],"Display_04"],
	["SCMS_Small_screen",[-0.805176,-41.5554,21.5528],[-0.999999,0.00116276,-5.01424e-006],[0.000588797,0.510091,0.86012],"Display_05"],
	["SCMS_Small_screen",[-2.33105,-41.5596,21.554],[-0.999998,0.00165558,0.000814468],[0.00155731,0.520617,0.853789],"Display_06"],
	["SCMS_Small_screen",[-3.81152,-40.6567,21.5489],[-0.576136,0.817324,-0.00691386],[0.434226,0.313233,0.84459],"Display_07"],
	["SCMS_Small_screen",[-4.21289,-39.3291,21.5346],[0.00115854,0.999999,-2.15322e-006],[0.510096,-0.00058911,0.860117],"Display_08"]
];
_screenList = [];
{
	private _screen = (_x select 0) createVehicle getPos _ship;
	_screen attachTo [_ship, (_x select 1)];
	_screen setVectorDirAndUp [(_x select 2), (_x select 3)];
	_screen setVariable ["GSRI_display_id", _x select 4, true];
	_screenList pushBack _screen;
} forEach _screenData;
_ship setVariable ["GSRI_FREMM_screens", _screenList, true];

// "Uneditable" screens on the ship's driving console
_drivingScreens = [
	["SCMS_Deck_screen",[2.975,-39.873,20.325],[0,-1,0],[0.615634,-0.000288824,0.788032],"Driving_01"],
	["SCMS_Deck_screen",[1.77002,-41.13,20.325],[-1,0,0],[0,-0.615661,0.788011],"Driving_02"],
	["SCMS_Deck_screen",[0.908203,-41.13,20.325],[-1,0,0],[0,-0.615661,0.788011],"Driving_03"],
	["SCMS_Deck_screen",[-0.911621,-41.13,20.325],[-1,0,0],[0,-0.615661,0.788011],"Driving_04"],
	["SCMS_Deck_screen",[-1.7749,-41.13,20.325],[-1,0,0],[0,-0.615661,0.788011],"Driving_05"],
	["SCMS_Deck_screen",[-2.975,-39.874,20.325],[0,1,0],[-0.615634,0.000288829,0.788032],"Driving_06"]
];
{
	private _screen = (_x select 0) createVehicle getPos _ship;
	_screen attachTo [_ship, (_x select 1)];
	_screen setVectorDirAndUp [(_x select 2), (_x select 3)];
	_screen setObjectTextureGlobal[0, format["destroyer_habs\data\ecrans\ecran_pont_0%1.paa", _forEachIndex + 1]];
} forEach _drivingScreens;

// Add some textures and maps to bridge's screens, still making them overridable by mission editor
_meteoScreens = ([_ship, "BRIDGE"] call GSRI_fnc_screenGetBySector);
{
	_x setObjectTextureGlobal[0, format["destroyer_habs\data\ecrans\ecran_meteo_%1.paa", _forEachIndex + 1]];
} forEach (_meteoScreens select [0,8]);

// Add team members texture to the screen above lockers
([_ship, "Display_21"] call GSRI_fnc_screenGetById) setObjectTextureGlobal [0,"destroyer_habs\data\ecrans\ecran_effectifs_co.paa"];