/**
 * Copyright 14.10.2010 Christian Sobolewski
 * 
 * usage : screens
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.IScreen
 * @author Christian Sobolewski
 */
package cs.unit.test.screens {

	/**
	 * @author Christian Sobolewski
	 */
	public interface IScreen {

		function activate() : void;

		function update() : void;

		function dispose() : void;

		function get id() : String;
		
		function set id(id : String) : void;
		
		function get language() : String;
		
		function set language(language : String) : void;
	}
}
