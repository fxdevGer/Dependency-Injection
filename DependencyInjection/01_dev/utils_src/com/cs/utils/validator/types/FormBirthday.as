/**
 * Copyright 30.03.2010 Christian Sobolewski
 * 
 * Usage :	var formBday : FormBirthday = new FormBirthday();
 *			formBday.textField = mc.zip;
 *			FormValidator.addForm(formBday);
 * 
 * Parameters :	
 *
 * Description : The FormBirthday Class is used if you want to validate birthdays.
 * 				 Default Reg Expression is Germany. If you want to check other countries 
 * 				 just call Setter regExpression for your country specific birthday Code.
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
	 
	public class FormBirthday implements IFormValidate {
		
		protected var _tf : TextField;		protected var _reg : RegExp;

		public function FormBirthday() {
			regExpression = /^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$/;
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
