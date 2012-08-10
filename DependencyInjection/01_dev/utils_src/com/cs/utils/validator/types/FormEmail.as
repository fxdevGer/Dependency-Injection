/**
 * Copyright 30.03.2010 Christian Sobolewski
 * 
 * Usage :	var formEmail : FormEmail = new FormEmail();
 *			formEmail.textField = mc.zip;
 *			formEmail.regExpression = RegExp;
 *			FormValidator.addForm(formEmail);
 * 
 * Parameters :	
 *
 * Description : The FormEmail Class is used if you want to validate Emails.
 * 				 Default Reg Expression is Germany. If you want to check other countries 
 * 				 just call Setter regExpression for your country specific Email Code.
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
	public class FormEmail implements IFormValidate {

		protected var _tf : TextField;		protected var _reg : RegExp;

		public function FormEmail() {
			regExpression = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
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
