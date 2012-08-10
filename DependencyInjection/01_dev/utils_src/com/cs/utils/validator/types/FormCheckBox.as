/**
 * Copyright 30.03.2010 Christian Sobolewski
 * 
 * Usage :	var formCheckBox : FormCheckBox = new FormCheckBox();
 *			formCheckBox.textField = mc.zip;
 *			FormValidator.addForm(formCheckBox);
 * 
 * Parameters :	
 *
 * Description : The FormCheckBox Class is used if you want to validate CheckBoxes.
 * 				 It just validates if checkBoxClip.currentFrame equals 1 
 * 				 If you need a different highlightError just extend this Class and override.
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
	public class FormCheckBox implements IFormValidate {
		
		protected var _clip : MovieClip;		protected var _errorCallBack : Function;
		
		/**
		 * @inheritDoc
		 */
		
		public function validate() : Boolean {
			return (checkBoxClip.currentFrame == 1) ? false : true;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function highlightError() : void {
			_errorCallBack();
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function removeErrorHighlight() : void {
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get textField() : TextField {
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set textField(tf : TextField) : void {
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get checkBoxClip() : MovieClip {
			return _clip;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set checkBoxClip(clip : MovieClip) : void {
			_clip = clip;
		}
		
		/**
		 * @inheritDoc
		 */

		public function get errorCallBack() : Function {
			return _errorCallBack;
		}
		
		/**
		 * @inheritDoc
		 */
				
		public function set errorCallback(f : Function) : void {
			_errorCallBack = f;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get regExpression() : RegExp {
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set regExpression(reg : RegExp) : void {
		}
	}
}
