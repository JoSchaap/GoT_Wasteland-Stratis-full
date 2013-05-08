
//	@file Version: 1.1
//	@file Name: vehicleCreation.sqf
//	@file Author: [404] Deadbeat, modded by AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args: markerPos [, carType]

if(!X_Server) exitWith {};

private ["_markerPos","_pos","_type","_num","_cartype","_car"];

_markerPos = _this select 0;
_pos = [_markerPos, 0, 30, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
_type = 0;
_cartype = "";

if (count _this > 1) then
{
	_cartype = _this select 1;
	
	if (_cartype in civilianVehicles) then { _type = 0 };
	if (_cartype in militaryVehicles) then { _type = 1 };
	if (_cartype in armedMilitaryVehicles) then { _type = 2 };
}
else
{
	_num = floor (random 100);
	if (_num < 100) then {_type = 0 };
	if (_num < 35) then {_type = 1 };
	if (_num < 10) then {_type = 2 };
};

//Create Civilian Vehicle
if (_type == 0) then
{
	//Car Initialization, Pick Car Type.
	if (_cartype == "") then {
		_cartype = civilianVehicles call BIS_fnc_selectRandom;
	};
    _car = createVehicle [_cartype,_pos,[], 0,"None"];
	[_car, 1800, 3600, 0, false, _markerPos] execVM "server\functions\vehicle.sqf";
    
	//Clear Cars Inventory
    clearMagazineCargoGlobal _car;
    clearWeaponCargoGlobal _car;
	
	//Set Cars Attributes
    _car setFuel (0.50);
    _car setDamage (random 0.50);
    _car setDir (random 360);
	_car disableTIEquipment true;
    [_car] call randomWeapons;

	//Set original posistion then add to vehicle array
	_car setVariable["newVehicle",1,true];
    _car setPosATL [getpos _car select 0,getpos _car select 1,1];
	_car setVelocity [0,0,0];
};

//Create Military Vehicle
if (_type == 1) then
{
	//Car Initialization, Pick Car Type.
	if (_cartype == "") then {
		_cartype = militaryVehicles call BIS_fnc_selectRandom;
	};
    _car = createVehicle [_cartype,_pos, [], 0, "None"];
	[_car, 1800, 3600, 0, false, _markerPos] execVM "server\functions\vehicle.sqf";
    
	//Clear Cars Inventory
    clearMagazineCargoGlobal _car;
    clearWeaponCargoGlobal _car;

	//Set Cars Attributes
    _car setFuel (0.50);
    _car setDamage (random 0.50);
    _car setDir (random 360);
	_car disableTIEquipment true;
    [_car] call randomWeapons;

	//Set authenticity
	_car setVariable["newVehicle",1,true];
    _car setPosATL [getpos _car select 0,getpos _car select 1,1];
	_car setVelocity [0,0,0];
};

//Create Armed Military Vehicle
if (_type == 2) then
{
	//Car Initialization, Pick Car Type.
	if (_cartype == "") then {
		_cartype = armedMilitaryVehicles call BIS_fnc_selectRandom;
	};
    _car = createVehicle [_cartype,_pos, [], 0, "None"];
	[_car, 1800, 3600, 0, false, _markerPos] execVM "server\functions\vehicle.sqf";

	//Clear Cars Inventory
    clearMagazineCargoGlobal _car;
    clearWeaponCargoGlobal _car;

	//Set Cars Attributes
    _car setFuel (0.50);
    _car setDamage (random 0.50);
    _car setDir (random 360);
    _car setVehicleAmmo (random 0.90);
	_car disableTIEquipment true;
    [_car] call randomWeapons;

	//Set original posistion then add to vehicle array
	_car setVariable["newVehicle",1,true];
    _car setPosATL [getpos _car select 0,getpos _car select 1,1];
	_car setVelocity [0,0,0];
};
