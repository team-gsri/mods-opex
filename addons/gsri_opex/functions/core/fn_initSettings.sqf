private ["_templates", "_settings"];

// Retrieve all preconfigured templates
_templates = ((configFile >> "GSRI_FREMM_Templates") call BIS_fnc_getCfgSubClasses);

// Retrieve all properties to consider, based on the only "absolute" template
_settings = (configProperties [configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "Properties"]) apply {configName _x};

// Automatic creation of needed server-forced settings for
{
	private _template = _x;
	{
		private _settingType = ["CHECKBOX","EDITBOX"] select (isText (configFile >> "GSRI_FREMM_Templates" >> _template >> "Properties" >> _x));
		private _defaultValue = switch (_settingType) do {
			case "CHECKBOX": { [false,true] select ((configFile >> "GSRI_FREMM_Templates" >> _template >> "Properties" >> _x) call BIS_fnc_getCfgData) };
			default { (configFile >> "GSRI_FREMM_Templates" >> _template >> "Properties" >> _x) call BIS_fnc_getCfgData };
		};
		[
			format["%1_%2", _template, _x],
			_settingType,
			[localize format["STR_GSRI_FREMM_%1", _x], localize format["STR_GSRI_FREMM_%1_tooltip", _x]],
			["GSRI FREMM Templates", _template],
			_defaultValue,
			1,
			{},
			true
		] call CBA_fnc_addSetting;
	} forEach _settings;
} forEach _templates;

// Custom template based on Normandie that can be edited as a mission setting instead of serverside
{
	private _settingType = ["CHECKBOX","EDITBOX"] select (isText (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "Properties" >> _x));
	private _defaultValue = switch (_settingType) do {
		case "CHECKBOX": { [false,true] select ((configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "Properties" >> _x) call BIS_fnc_getCfgData) };
		default { (configFile >> "GSRI_FREMM_Templates" >> "GSRI_Normandie" >> "Properties" >> _x) call BIS_fnc_getCfgData };
	};
	[
		format["GSRI_CustomFremm_%1", _x],
		_settingType,
		[localize format["STR_GSRI_FREMM_%1", _x], localize format["STR_GSRI_FREMM_%1_tooltip", _x]],
		["GSRI FREMM Templates", "Custom"],
		_defaultValue,
		1,
		{},
		true
	] call CBA_fnc_addSetting;
} forEach _settings;