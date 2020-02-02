params["_hangar"];

_list = (_hangar nearEntities [(_hangar getVariable "GSRI_FREMM_heli_list"), 10]);

// NOT necessarily the closest one if there is several heli
[(_list select 0), objNull] select (count _list == 0);