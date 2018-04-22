if(!hasInterface) exitWith {};
	
	[] spawn
	{
		waitUntil {!isnull Player && !isNull (findDisplay 46)};
		
		if (!isNil "cba_keybinding") then
		{
			_targetCallouts = ["Goko Unit VO's", "enemy_callout", "Revealed Enemies Direction",
			{
				_pSide = side player;
				_activefaction = lelz;
				switch (true) do 
				{ 
					case (_pSide == WEST ) : {_activefaction = goko_fnc_bCallDir }; 
					case (_pSide == Independent ) : {_activefaction = goko_fnc_indeCallDir }; 
					case (_pSide == EAST ) : {_activefaction = goko_fnc_opfCallDir }; 
				}; 
				player call _activefaction;
		
			}, {}, [0x14, [false, false, false]],false] call CBA_fnc_addkeybind;
			
			goko_bcallout_keydown = false;
			
			goko_bcallout_key = (findDisplay 46) displayAddEventHandler ["KeyDown", 
			{
				params ["_display","_dikKey","_shift","_ctrl","_alt"];
				
				if (_dikKey in (actionkeys "RevealTarget")) then
				{
					if (goko_bcallout_keydown) exitwith {};
					
					goko_bcallout_keydown = true;
					_targetCallouts = (["Goko Unit VO's", "enemy_callout"] call CBA_fnc_getKeybind) select 5;
					if ((_targetCallouts select 0) in (actionkeys "RevealTarget")) exitwith{};
				};
			}];
			
			goko_bcallout_keyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", 
			{
				params ["_display","_dikKey","_shift","_ctrl","_alt"];
				if (_dikKey in (actionkeys "RevealTarget")) then
				{
					goko_bcallout_keydown = false;
				};
			}];
			
			
		} else
		{

			goko_bcallout_key = (findDisplay 46) displayAddEventHandler ["KeyDown", 
			{
				params ["_display","_dikKey","_shift","_ctrl","_alt"];
				
				if (_dikKey in (actionkeys "RevealTarget")) then
				{
					if(goko_bcallout_keydown) exitwith {};
					
					goko_bcallout_keydown = true;
					if (!_ctrl && !_shift && !_alt) then
					{
						_pSide = side player;
						_activefaction = lelz;
						switch (true) do 
						{ 
							case (_pSide == WEST ) : {_activefaction = goko_fnc_bCallDir }; 
							case (_pSide == Independent ) : {_activefaction = goko_fnc_indeCallDir }; 
							case (_pSide == EAST ) : {_activefaction = goko_fnc_opfCallDir }; 
						}; 
						player call _activefaction;
					};
				};
			}];
			goko_bcallout_keyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", 
			{
				params ["_display","_dikKey","_shift","_ctrl","_alt"];
				if (_dikKey in (actionkeys "RevealTarget")) then
				{
					goko_bcallout_keydown = false;
				};
			}];
				
		};
	};