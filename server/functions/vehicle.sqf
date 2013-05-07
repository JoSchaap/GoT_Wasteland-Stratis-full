_vehicle = _this select 0; //get vehicle's details
_respawntime = _this select 1; //get the init set respawn time
_facingofvehicle = getDir _vehicle; //get original facing
_positionofvehicle = getPosATL _vehicle; //get original position
_vehicletype = typeOf _vehicle; //get the vehicle type
_n = 1;

if(isServer) then{
	while{_n == 1} do{
		if((!alive _vehicle) || (!canMove _vehicle)) then { //true if vehicle is not alive or it cannot move
			sleep 240; //change this to what you like, longer will give you a bigger response delay between unit being killed and the vehicle being deleted
			deleteVehicle _vehicle; //clear up old vehicle
			sleep _respawntime; // respawn time between deletion and then respawn
			_vehicle = _vehicletype createVehicle _positionofvehicle; // create a new vehicle of same type at starting position
			_vehicle setPosATL _positionofvehicle; //set correct position
			_vehicle setDir _facingofvehicle; //set correct facing of the vehicle
			[[[_vehicle,_respawntime],"vehicle_respawn.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP; //replacement for the old setVehicleInit, this does the same and causes the new vehicle to have the respawn script when created
			_n = 0; // break out condition
		};
		sleep 120; // sleep for a bit in order to reduce processing calls (increase this to whatever you like, longer gives better performance but also increases response delay)
	};
};
