/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.ScreenController
 * @author Christian Sobolewski
 */
package cs.unit.test.screens {
	import cs.unit.test.screens.event.ScreenEvent;
	import cs.unit.test.screens.models.ScreenModel;

	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.mvc.FrontController;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ScreenController {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ScreenController));
		private var _screenModel : ScreenModel;

		public function ScreenController() {
		}
		
		public function onChangeScreenRequest(event : ScreenEvent) : void {
			
			var screenId : String = event.newScreenId;
			log.debug("execute: " + screenId);
			
			if (_screenModel.screenId != screenId) {
				//update model...
				_screenModel.screenId = screenId;
				
				//update the view
				FrontController.root().dispatchEvent(new ScreenEvent(ScreenEvent.PERFORM_CHANGE, _screenModel.screenId));
			}
		}
		
		public function onChangeLanguageRequest(event : ScreenEvent) : void {
			FrontController.root().dispatchEvent(new ScreenEvent(ScreenEvent.PERFORM_LANGUAGE_CHANGE, "", event.lang));
		}

		public function set screenModel(screenModel : ScreenModel) : void {
			_screenModel = screenModel;
		}
	}
}
