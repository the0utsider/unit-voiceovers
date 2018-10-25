/*
	goko unit voice-overs addon throw & put weapon function 
	author: gökmen
	website: https://github.com/the0utsider
	description: filters throw/put weapon types on fired EH, plays sound sample accordingly
*/
gokoVO_fnc_throwablesBlufor = 
{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if !(_weapon in ["Throw", "Put"]) exitWith{};
	
	_searchFriendly = _unit nearEntities [["SoldierWB"], 50];
	_searchFriendly deleteAt (_searchFriendly find _unit);
	/*	find out if there friendlies around */
	
	#include "throwable_type_definitions.sqf"
	#include "throwable_soundArraysBlufor.sqf"
	
	switch (true) do {
		case (_magazine in _expGrenTypes) : {[_unit, _fragGrenadeSample] call gokovo_fnc_globalSay3d; _projectile call gokoVO_blufor_thrown_frag};
		case (!(isnil {_searchFriendly #0}) && _magazine in _smkGrenTypes) : {[_unit, _smokeGrenadeSample] call gokovo_fnc_globalSay3d};
		case (!(isnil {_searchFriendly #0}) && _magazine in _stunGrenTypes) : {[_unit, _flashGrenadeSample] call gokovo_fnc_globalSay3d};
		case (!(isnil {_searchFriendly #0}) && _magazine in _incGrenTypes) : {[_unit, _incendieryGrenadeSample] call gokovo_fnc_globalSay3d};
		case (!(isnil {_searchFriendly #0}) && _magazine in _chargeMineTypes) : {[_unit, _explosivePutSample] call gokovo_fnc_globalSay3d};
	};
};

gokoVO_blufor_thrown_frag =
{
	params ["_thrownGrenade"];

	_thrownGrenade spawn {
		waitUntil {
			_zSpeed = velocity _this #2;
			sleep 0.2;
			if (abs(_zSpeed) < 0.1) exitWith {true};
		};
		_findEnemies = _this nearEntities [["soldiereb", "soldiergb"], 16];
		if (isnil {_findEnemies #0}) exitwith {};

		_findEnemies = _findEnemies apply {[_x distance _this, _x]};
		_findEnemies sort true;
		private _enemy = _findEnemies#0#1;
		
		if (_enemy iskindof "soldiergb") then 
		{
			_independentReactingGrenade = selectRandom [
				"Inspotnade01", "Inspotnade02", "Inspotnade03", "Inspotnade04", "Inspotnade05", 
				"Inspotnade06", "Inspotnade07", "Inspotnade08", "Inspotnade09", "Inspotnade10", 
				"Inspotnade11", "Inspotnade12", "Inspotnade13", "Inspotnade14", "Inspotnade15", 
				"Inspotnade16", "Inspotnade17", "Inspotnade18"
			];
			[_enemy, _independentReactingGrenade] call gokovo_fnc_globalSay3d;
		};
		
		if (_enemy iskindof "soldiereb") then 
		{
			_opforReactingGrenade = selectRandom [
				"ospotnade01", "ospotnade02", "ospotnade03", "ospotnade04", "ospotnade05", "ospotnade06", 
				"ospotnade07", "ospotnade08", "ospotnade09", "ospotnade10", "ospotnade11", "ospotnade12", 
				"ospotnade13", "ospotnade14", "ospotnade15", "ospotnade16", "ospotnade17", "ospotnade18", 
				"ospotnade19", "ospotnade20", "ospotnade21", "ospotnade22", "ospotnade23"
			];
			[_enemy, _opforReactingGrenade] call gokovo_fnc_globalSay3d;
		};
	};
};