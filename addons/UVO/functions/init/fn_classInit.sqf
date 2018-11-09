/*--------------------------------------------------------
Authors: Gokmen, Sceptre
Class based init event handler script

Parameters:
0: The spawned unit <OBJECT>
1: Default nationality applied to unit <STRING>

Return Value:
Nothing
----------------------------------------------------------*/
params ["_unit","_defaultNationality"];

// UVO is handled where unit is local
if (local _unit) then {
	// Set unit nationality
	if (!isNil "UVO_customNationalities") then {
		private _customNationality = UVO_customNationalities select {(_x # 0) == faction _unit};
		
		if !(_customNationality isEqualTo []) then {
			_unit setVariable ["UVO_unitNationality",(_customNationality # 0 # 1),true];
		} else {
			_unit setVariable ["UVO_unitNationality",_defaultNationality,true];
		};
	} else {
		_unit setVariable ["UVO_unitNationality",_defaultNationality,true];
	};
	
	// Make it so unit can talk with UVO_fnc_globalSay3D
	_unit setVariable ["UVO_unitRandomLip",false];

	// Add necessary Event Handlers
	private _hitEHID = _unit addEventHandler ["Hit",{_this call UVO_fnc_hitEH}];
	private _firedEHID = _unit addeventhandler ["Fired",{_this call UVO_fnc_firedEH}];
	private _killedEHID = _unit addEventhandler ["Killed",{_this call UVO_fnc_killedEH}];
	private _reloadedEHID = _unit addEventhandler ["Reloaded",{_this call UVO_fnc_reloadedEH}];
	private _localEHID = _unit addEventhandler ["Local",{_this call UVO_fnc_localEH}];

	_unit setVariable ["UVO_unitEHIDs",[_hitEHID,_firedEHID,_killedEHID,_reloadedEHID,_localEHID]];
};
