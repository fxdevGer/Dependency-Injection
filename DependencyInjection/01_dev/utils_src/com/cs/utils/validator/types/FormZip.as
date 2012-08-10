/**
 * Copyright 30.03.2010 Christian Sobolewski
 * 
 * Usage :	var formZip : FormZip = new FormZip();
 *			formZip.textField = mc.zip;
 *			formZip.regExpression = RegExp;
 *			FormValidator.addForm(formZip);
 * 
 * Parameters :	
 *
 * Description : The FormZip Class is used if you want to validate Zip Codes.
 * 				 Default Reg Expression is Germany. If you want to check other countries 
 * 				 just call Setter regExpression for your country specific Zip Code.
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
	 
	public class FormZip implements IFormValidate {
		
		protected var _tf : TextField;
		protected var _reg : RegExp;

		public function FormZip() {
			regExpression = /^[0-9]{5}$/;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function validate() : Boolean {
			return regExpression.test(textField.text);
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function highlightError() : void {
			textField.border = true;
			textField.borderColor = 0xE2001A;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function removeErrorHighlight() : void {
			textField.border = false;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get textField() : TextField {
			return _tf;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set textField(tf : TextField) : void {
			_tf = tf;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get checkBoxClip() : MovieClip {
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set checkBoxClip(clip : MovieClip) : void {
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get errorCallBack() : Function {
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set errorCallback(f : Function) : void {
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function get regExpression() : RegExp {
			return _reg;
		}
		
		/**
		 * @inheritDoc
		 */
		
		public function set regExpression(reg : RegExp) : void {
			_reg = reg;
		}
	}
}
