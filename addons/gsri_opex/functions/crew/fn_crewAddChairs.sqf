[
	"ace_stoodUp",
	{params["_player", "_seat", "_seatPos"];
	if(_seat getVariable ["isRestRoom", false]) then { _player setPosWorld (_seat modelToWorldWorld [-0.5,0,-0.4]) };
}] call CBA_fnc_addEventHandler;

if!(isServer) exitWith {};

params["_room"];

private _chairs_data = [
	[[2.8877,-4.85596,-0.4],180],
	[[2.85791,-4.16797,-0.4],180],
	[[2.85596,-3.50488,-0.4],180],
	[[1.82275,-4.91699,-0.4],0],
	[[1.8208,-4.25391,-0.4],0],
	[[1.79102,-3.56592,-0.4],0],
	[[0.605957,-4.8728,-0.4],180],
	[[0.574707,-4.18481,-0.4],180],
	[[0.572754,-3.52197,-0.4],180],
	[[-0.571289,-4.87378,-0.4],0],
	[[-0.562988,-4.21094,-0.4],0],
	[[-0.561035,-3.52295,-0.4],0],
	[[-1.70313,-4.85278,-0.4],180],
	[[-1.68994,-4.16479,-0.4],180],
	[[-1.69238,-3.50195,-0.4],180],
	[[-2.82129,-4.88281,-0.4],0],
	[[-2.82324,-4.21997,-0.4],0],
	[[-2.85303,-3.53198,-0.4],0]
];

{
	private _chair = "SCMS_Chaise" createVehicle getPos _room;
	_chair attachTo [_room, (_x select 0)];
	_chair setDir (_x select 1);
	_chair setVariable ["isRestRoom", true, true];
} forEach _chairs_data;
