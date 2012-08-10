/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens.navigation
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.navigation.Navigation
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.navigation {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.mvc.FrontController;
	import com.cs.utils.references.GetMovieClip;
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.event.ScreenEvent;
	import cs.unit.test.screens.models.ScreenModel;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;



	/**
	 * @author Christian Sobolewski
	 */
	public class Navigation extends Screen {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(Navigation));
		private var _clip : MovieClip;
		private var _screenModel : ScreenModel;
		private var _max : int;

		public function Navigation(max : int = -1) {
			_max = max;
		}

		public function onChangeLanguage(event : ScreenEvent) : void {
			language = event.lang;
			update();
		}

		public override function update() : void {
			setContent(false);
		}

		public function initNavigation() : void {
			_clip = GetMovieClip("Navigation");
			_clip.x = 1024 / 2 - _clip.width / 2;
			_clip.y = 20;

			setContent(true);

			addChild(_clip);
		}

		private function setContent(addToDisplayList : Boolean) : void {
			var mc : MovieClip;
			var tf : TextField;
			var l : int = _max;
			var stXPos : Number = 200;
			var clip : MovieClip;

			for (var i : int = 0;i < l;i++) {
				clip = (addToDisplayList) ? GetMovieClip("Nav") : getChildAt(i) as MovieClip;
				
				tf = TextField(clip.tf);
				mc = MovieClip(clip.btn);
				if (!tf.styleSheet) tf.styleSheet = Context.styleSheet;
				tf.embedFonts = true;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				tf.gridFitType = GridFitType.PIXEL;
				tf.condenseWhite = true;
				tf.autoSize = TextFieldAutoSize.LEFT;

				tf.htmlText = LocaleContext.getMessage(language, "navigation." + String(i + 1));
				mc.id = i;
				mc.width = tf.width;
				mc.height = tf.height;
				mc.alpha = 0;

				if (!mc.buttonMode) {
					mc.buttonMode = true;
					mc.addEventListener(MouseEvent.CLICK, handleMouseEvent);
				}

				clip.x = (i > 0) ? (getChildAt(i - 1).width + getChildAt(i - 1).x) + 20 : stXPos  ;

				if (addToDisplayList) addChild(clip);
			}
		}

		private function handleMouseEvent(event : MouseEvent) : void {
			var id : Number = event.currentTarget.id;

			FrontController.root().dispatchEvent(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, _screenModel.screen[id].id, language));
			
		}

		public function set screenModel(screenModel : ScreenModel) : void {
			_screenModel = screenModel;
		}
	}
}
