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
 * screens.ScreenView
 * @author Christian Sobolewski
 */
package cs.unit.test.screens {
	import cs.unit.test.screens.event.ScreenEvent;
	import cs.unit.test.screens.models.ScreenModel;

	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ScreenView extends Sprite {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ScreenView));
		private var currentScreen : Screen;
		private var _screenModel : ScreenModel;
		
		public function ScreenView() {
		}
		
		public function onChangeScreen(event : ScreenEvent) : void {
			var screenId : String = event.newScreenId;
			log.debug("execute: " + screenId);			
			if (_screenModel.getScreenByName(screenId) == null) {
				log.error("could not find screen: " + screenId);
				return;
			}
			
			if (currentScreen != null) {
				currentScreen.dispose();
				removeChild(currentScreen);
			}
			
			currentScreen = _screenModel.getScreenByName(screenId);
			currentScreen.activate();
			addChild(currentScreen);
		}
		
		public function onChangeLanguage(event : ScreenEvent) : void {
			for each (var screen : Screen in _screenModel.screen) {
				screen.language = event.lang;
				screen.update();
			}
		}
		
		public function set screenModel(screenModel : ScreenModel) : void {
			_screenModel = screenModel;
		}
	}
}
