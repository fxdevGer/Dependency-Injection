/**
 * Copyright 29.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : IFormValidate for each Form Validator Type
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.validator.types {
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author Christian Sobolewski
	 */
	public interface IFormValidate {
		
		/**
		 * 	returns if valid or not
		 */
		function validate():Boolean;
		
		/**
		 * 	highlights Error if validation fails
		 */
		
		function highlightError():void;
		
		/**
		 * 	removes Error Highlight if validation success
		 */
		
		function removeErrorHighlight():void;
		
		/**
		 * 	sets the InputTextField for validation
		 */
		
		function set textField(tf:TextField):void;		
		/**
		 * 	returns the InputTextField for validation
		 */
		
		function get textField():TextField;
		
		/**
		 * 	sets the CheckBoxClip as MovieClip for validation
		 */
		
		function set checkBoxClip(clip:MovieClip):void;
		
		/**
		 * 	returns the CheckBoxClip as MovieClip for validation
		 */
		
		function get checkBoxClip():MovieClip;
		
		/**
		 * 	sets the errorCallback if a differnt error Highlight is needed
		 */
		
		function set errorCallback(f:Function):void;
		
		/**
		 * 	returns the errorCallback 
		 */
		
		function get errorCallBack():Function;
		
		/**
		 * 	sets the RegExp for each <code>IFormValidate</code>. That RegExp is checked if true or false.
		 */
		
		function set regExpression(reg:RegExp):void;
		
		/**
		 * 	gets the RegExp for each <code>IFormValidate</code>
		 */
		
		function get regExpression():RegExp;
	}
}
