/**
 * Copyright 09.09.2010 Christian Sobolewski
 * 
 * usage :  screens.utils
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.utils.FormularValidator
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.utils {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.utils.validator.FormValidator;
	import com.cs.utils.validator.types.FormBirthday;
	import com.cs.utils.validator.types.FormEmail;
	import com.cs.utils.validator.types.FormEmpty;
	import com.cs.utils.validator.types.FormStreetNr;
	import com.cs.utils.validator.types.FormZip;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;


	/**
	 * @author Christian Sobolewski
	 */
	public class FormularValidator extends FormValidator {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(FormularValidator));
		
		private var _hasContent : Boolean = false;
		
		public function FormularValidator() {
			super();
		}
		
		public function setContent(mc : MovieClip):void {
			var fEmpty : FormEmpty = new FormEmpty();
			fEmpty.textField = mc.salut;
			
			addForm(fEmpty);
			
			fEmpty = new FormEmpty();
			fEmpty.textField = mc.firstName;
			
			addForm(fEmpty);
			
			fEmpty = new FormEmpty();
			fEmpty.textField = mc.lastName;
			
			addForm(fEmpty);
			
			var fBirth : FormBirthday= new FormBirthday();
			fBirth.textField = mc.birthday;
			
			addForm(fBirth);
			
			var fMail : FormEmail = new FormEmail();
			fMail.textField = mc.email;
			
			addForm(fMail);
			
			fEmpty = new FormEmpty();
			fEmpty.textField = mc.street;
			
			addForm(fEmpty);
			
			var formStreetNr : FormStreetNr = new FormStreetNr();
			formStreetNr.textField = mc.streetNr;
			
			addForm(formStreetNr);
			
			var formZip : FormZip = new FormZip();
			formZip.textField = mc.zip;
			
			addForm(formZip);
			
			fEmpty = new FormEmpty();
			fEmpty.textField = mc.location;
			addForm(fEmpty);
						
			_hasContent = true;
			
		}
		
		public function get hasContent():Boolean {
			return _hasContent;
		}
		
	}
}
