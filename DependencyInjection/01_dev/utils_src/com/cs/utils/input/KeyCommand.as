/**
 * Copyright 08.08.2011 Christian Sobolewski
 * 
 * Usage :	
 * 			
 * Parameters:
 * 	
 * Description:
 * 
 * 			- Mapps Key Commands for use if Key was pressed.
 * 
 * Author:
 * 		 	Christian Sobolewski
 * 			12.08.2011
 *
 * Version: - 1.1 Moved into Dependency Injection utils package
 * 			
 *
 * History:
 * 			- 1.0
 */
package com.cs.utils.input {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Christian Sobolewski
	 */
	public class KeyCommand {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(KeyCommand));
		
		public static const KEY_C : String = "Camera";
		public static const KEY_W : String = "Forward";
		public static const KEY_A : String = "Left";
		public static const KEY_D : String = "Right";
		public static const KEY_S : String = "Backward";
		public static const KEY_R : String = "Reload";
		public static const KEY_SHIFT : String = "Shift";
		public static const KEY_SPACE : String = "Space";
		public static const KEY_0 : String = "Num_0";
		public static const KEY_9 : String = "Num_9";
		public static const KEY_ARROW_LEFT : String = "ArrowLeft";
		public static const KEY_ARROW_RIGHT : String = "ArrowRight";
		public static const KEY_ARROW_UP : String = "ArrowUp";
		public static const KEY_ARROW_DOWN : String = "ArrowDown";
		
		public static var ALL_COMMANDS : Dictionary = new Dictionary();
		ALL_COMMANDS[67] = KEY_C;
		ALL_COMMANDS[87] = KEY_W;
		ALL_COMMANDS[65] = KEY_A;
		ALL_COMMANDS[68] = KEY_D;
		ALL_COMMANDS[83] = KEY_S;
		ALL_COMMANDS[82] = KEY_R;
		ALL_COMMANDS[16] = KEY_SHIFT;
		ALL_COMMANDS[32] = KEY_SPACE;
		ALL_COMMANDS[48] = KEY_0;
		ALL_COMMANDS[57] = KEY_9;
		ALL_COMMANDS[37] = KEY_ARROW_LEFT;
		ALL_COMMANDS[39] = KEY_ARROW_RIGHT;
		ALL_COMMANDS[38] = KEY_ARROW_UP;
		ALL_COMMANDS[40] = KEY_ARROW_DOWN;
		
		public static var MOVEMENT_COMMANDS : Dictionary = new Dictionary();
		MOVEMENT_COMMANDS[87] = ALL_COMMANDS[87];
		MOVEMENT_COMMANDS[65] = ALL_COMMANDS[65];
		MOVEMENT_COMMANDS[68] = ALL_COMMANDS[68];
		MOVEMENT_COMMANDS[83] = ALL_COMMANDS[83];
		MOVEMENT_COMMANDS[16] = ALL_COMMANDS[16];
		MOVEMENT_COMMANDS[37] = ALL_COMMANDS[37];
		MOVEMENT_COMMANDS[39] = ALL_COMMANDS[39];
		MOVEMENT_COMMANDS[38] = ALL_COMMANDS[38];
		MOVEMENT_COMMANDS[40] = ALL_COMMANDS[40];
		
		public static var MAPPING_COMMANDS : Dictionary = new Dictionary();
		MAPPING_COMMANDS[KEY_C] = 67;
		MAPPING_COMMANDS[KEY_W] = 87;
		MAPPING_COMMANDS[KEY_A] = 65;
		MAPPING_COMMANDS[KEY_D] = 68;
		MAPPING_COMMANDS[KEY_S] = 83;
		MAPPING_COMMANDS[KEY_R] = 82;
		MAPPING_COMMANDS[KEY_SHIFT] = 16;
		MAPPING_COMMANDS[KEY_SPACE] = 32;
		MAPPING_COMMANDS[KEY_0] = 48;
		MAPPING_COMMANDS[KEY_9] = 57;
		MAPPING_COMMANDS[KEY_ARROW_LEFT] = 37;
		MAPPING_COMMANDS[KEY_ARROW_RIGHT] = 39;
		MAPPING_COMMANDS[KEY_ARROW_UP] = 38;
		MAPPING_COMMANDS[KEY_ARROW_DOWN] = 40;
		
		public static function getKeyByString(key : String) : int {
			return MAPPING_COMMANDS[key];
		}
		
		
	}
}
