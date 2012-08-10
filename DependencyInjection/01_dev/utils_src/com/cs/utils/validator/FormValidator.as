/**
 * Copyright 29.03.2010 Christian Sobolewski
 * 
 * Usage :	_formValidator = new FormValidator();
 * 			_formValidator.addForm(IFormValidate);
 * 			_formValidator.validate();
 * 
 * Parameters :	
 *
 * Description : The FormValidator is the Base Class for validating Forms.
 * 				 If you want to have Form Validation create an instance and
 * 				 call addForm for adding IFormValidate.
 * 				 To create more types implement IFormValidator Interface.
 * 				 If you wanna check just call validate();
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.validator {
	import com.cs.utils.validator.types.IFormValidate;

	/**
	 * @author Christian Sobolewski
	 */
	 
	public class FormValidator {

		private var _fields : Array = [];

		public function FormValidator() {}
		
		/**
		 * 	adds a <code>IFormValidate</code> for validation
		 */
		
		public function addForm(iForm:IFormValidate) : void {
			_fields.push(iForm);
		}
		
		/**
		 * 	validates each <code>IFormValidate</code>.
		 * 	Highlighte error or removes if validation is correct
		 */
		
		public function validate() : Boolean {
			var bool : Boolean = true;
			for each (var form : IFormValidate in _fields) {
				if (!form.validate()) {
					form.highlightError();
					bool = false;
				} else {
					form.removeErrorHighlight();
				}
			}
			return bool;
		}
	}
}
