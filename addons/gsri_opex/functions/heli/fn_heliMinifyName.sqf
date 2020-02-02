// Can be string (displayName or className) or object
params[["_entry", objNull, ["", objNull]]];

// If object, retrieve displayName
if(typeName _entry isEqualTo "OBJECT") then {
	if(isNull _entry) then {
		_entry = "dummy"
	} else {
		_entry = getText (configFile >> "CfgVehicles" >> typeOf _entry >> "displayName")
	};
};

// If monolithic string, try to determine if it's a vehicle's classname
if(isClass (configFile >> "CfgVehicles" >> _entry)) then {
	_entry = getText (configFile >> "CfgVehicles" >> _entry >> "displayName");
};

// If displayName, split and return first group (usually code name like MH6, AH64, etc)
(_entry splitString " ") select 0