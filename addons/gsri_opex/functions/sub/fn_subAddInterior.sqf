params["_sub"];

if(isServer) then {
	private _shipIndex = _sub getVariable "GSRI_FREMM_shipIndex";
	private _inside = createVehicle ["Land_Carrier_01_island_02_F", ASLToATL [75, (_shipIndex*50), 10]];
	_inside setVectorUp [0,0,1];
	_sub setVariable ["GSRI_FREMM_sub_interior", _inside, true];

	private _props = [
		["Land_PierLadder_F",[4.85046,-4.08545,-1.61897],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01392,2.91797,0.0657654],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01392,2.87744,0.387205],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41675,2.87305,0.388365],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43054,-3.22852,0.108538],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01392,2.91846,0.713285],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41675,2.91553,0.710718],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47205,-3.22803,-0.220612],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.0144,2.87646,-0.263384],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01489,2.87646,-0.585655],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41675,2.91504,0.0631981],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47766,-3.82422,-1.19231],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47327,-3.22705,-1.19347],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43176,-3.22754,-0.864323],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43469,-3.82471,-0.86689],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.48059,-4.42139,-1.19019],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41724,2.87207,-0.262224],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47668,-3.82471,-0.541723],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47229,-3.22754,-0.542883],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47937,-4.42236,-0.217329],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47644,-3.8252,-0.219452],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47961,-4.42188,-0.539598],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41772,2.87158,-0.584496],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43347,-3.82568,0.10597],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41772,2.91357,-0.909662],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47839,-4.42285,0.433262],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47546,-3.82568,0.431137],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.47107,-3.22852,0.429977],[1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.42993,-3.22852,0.756058],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43286,-3.82568,0.75349],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43677,-4.42383,0.751976],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[4.41821,2.87061,-1.23508],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01538,2.87549,-1.23624],[0,-1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[5.01489,2.91699,-0.907095],[0,1,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.43738,-4.42383,0.104454],[-1,0,0],[0,0,1]],
		["Land_PortableServer_01_black_F",[3.4386,-4.42285,-0.868406],[-1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-2.37256,0.667238],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.0946,-2.88281,0.667969],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-3.3916,0.667568],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-2.88281,-0.948124],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09448,-2.37256,-0.948601],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-3.39209,-0.948599],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-3.39209,-0.140753],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09448,-2.37256,-0.140755],[1,0,0],[0,0,1]],
		["Land_PortableCabinet_01_4drawers_black_F",[6.09436,-2.88281,-0.140278],[1,0,0],[0,0,1]],
		["Land_SewerCover_02_F",[4.85742,-4.23633,0.934311],[0,-1,0],[0,-0,-1]],
		["plp_cts_HighSecContGreyNoDollyO",[4.8634,-4.61865,3.86745],[0,0,-1],[0,1,0]]
	];

	{
		private _prop = createVehicle [_x select 0, getPos _inside];
		_prop attachTo [_inside, _x select 1];
		_prop setVectorDirAndUp [_x select 2, _x select 3];
	} forEach _props;

	private _insideDoors = [
		["Land_Battery_F", "Trapdoor", [4.85742,-4.23633,0.934311], [4.8999,-4.08594,-1.36511]]
	];
	_inside setVariable ["GSRI_FREMM_moddedDoors", _insideDoors, true];
};

if!(isDedicated) then {
	private _corridors = [ [[_sub getVariable "GSRI_FREMM_sub_interior", "Trapdoor"],[_sub, "Trapdoor"]] ];
	{ [_x] call GSRI_fnc_doorConnect } forEach _corridors;
};