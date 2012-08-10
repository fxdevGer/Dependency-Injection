/**
 * Copyright 09.09.2010 Christian Sobolewski
 * 
 * usage : screens.types
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.types.Form
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.types {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.utils.references.GetMovieClip;
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.utils.FormularValidator;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;



	/**
	 * @author Christian Sobolewski
	 */
	public class FormScreen extends Screen {

		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(FormScreen));

		private var _formString : String;
		private var _phpUrl : String;
		private var _form : MovieClip;
		private var _formVali : FormularValidator;

		private var _context : Array;

		public function FormScreen(form : String, phpUrl : String) {
			log.info("injected form: " + form + " | phpUrl? " + phpUrl);
			_formString = form;			_phpUrl = phpUrl;
			_context = [];
		}
		
		public function test():void {
			log.fatal("test called:D");
		}
		
		public override function activate() : void {
			log.info("activate");
			openForm();
		}

		public override function update() : void {
			log.info("update");
			setTxt();
		}

		public override function dispose() : void {
			log.info("dispose");
			if (_form != null) {
				_form.validateBtn.removeEventListener(MouseEvent.CLICK, validate);
				removeChild(_form);
				_form = null;
			}
		}
		
		public function set addContexts(p : String) : void{
			_context.push(p);
//			log.info('_context: ' + (_context));
		}
		
		public function initForm() : void {
			_formVali = new FormularValidator();
		}

		private function openForm() : void {
			_form = GetMovieClip(_formString);
			_form.bg.width = 1024;
			_form.bg.height = 768;
					
			_form.validateBtn.buttonMode = true;
			_form.validateBtn.addEventListener(MouseEvent.CLICK, validate);
			
			_formVali.setContent(_form);
			
			setTxt();
			
			addChild(_form);
		}

		private function validate(event : MouseEvent) : void {
			_formVali.validate();
		}

		private function setTxt() : void {
			if (_form != null) {
				var l : Number = 10;
				var tf : TextField;
			
				for (var i : Number = 1;i < l;i++) {
					if (_form.getChildByName("l" + i) != null) {
						tf = _form.getChildByName("l" + i) as TextField;
						tf.styleSheet = Context.styleSheet;
						tf.htmlText = LocaleContext.getMessage(language, "form." + i);
						tf.antiAliasType = AntiAliasType.ADVANCED;
						tf.autoSize = TextFieldAutoSize.RIGHT;
					}
				}
			
				_form.validateBtn.width = _form.l9.width;
				_form.validateBtn.height = _form.l9.height;
				_form.validateBtn.x = _form.l9.x;
				_form.validateBtn.y = _form.l9.y;
			}
		}
	}
}
