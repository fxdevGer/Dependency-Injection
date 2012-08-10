/**
 * Copyright 08.11.2010 Christian Sobolewski
 * 
 * usage : cs.framework.cases
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * cs.framework.cases.ContextFinalV1
 * @author Christian Sobolewski
 */
package cs.unit.test {
	import cs.unit.test.screens.ScreenView;
	import cs.unit.test.screens.event.ScreenEvent;
	import cs.unit.test.screens.navigation.Navigation;
	import cs.unit.test.screens.types.Language;

	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.ContextParser;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.LogLevel;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.mvc.FrontController;
	import com.cs.utils.fps.FPS;
	import com.cs.utils.input.Input;

	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class Unit extends Sprite {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(Unit));
		private var _fileTf : TextField;
		private var _perTf : TextField;
		private var _lTf : TextField;
		private var _tTf : TextField;
		private var _contextParser : ContextParser;

		public function Unit() {
			addPreloaderTxt();

			// classLinking is used to import classes who will be used by DI
			// its necessary cause DI wont find those classes

			var $classLinking : ClassLinking;

			LogContext.factory.setRootLogLevel(LogLevel.TRACE);

			// create a new ContextParser Instance. Main entry Point
			_contextParser = new ContextParser();

			// add files to parse. logging.xml and context.xml is used here
			_contextParser.addFile("config/logging_dev.xml");
			_contextParser.addFile("config/topics/context_loadergroup.xml");
			// _contextParser.addFile("config/topics/context_constructor_args.xml");
			// _contextParser.addFile("config/topics/context_properties.xml");
//			 _contextParser.addFile("config/topics/context_methods.xml");
//			 _contextParser.addFile("config/topics/context_input.xml");
//			_contextParser.addFile("config/context_dev.xml");

			// add Events for listen. ErrorEvent.ERROR is an Error occurrs
			// Event.COMPLETE if all is ready to start
			_contextParser.addEventListener(Event.COMPLETE, onComplete);
			_contextParser.addEventListener(ErrorEvent.ERROR, onError);

			// start
			_contextParser.start();

			// just for preloading view
			addEventListener(Event.ENTER_FRAME, handlePreload);
		}

		/**
		 * 	onComplete : is called if all object were parsed and injected
		 * 				 and if all objects were load!!!	
		 */
		private function onComplete(event : Event) : void {
			removeEventListener(Event.ENTER_FRAME, handlePreload);
			_contextParser.removeEventListener(Event.COMPLETE, onComplete);

			if (_fileTf != null) removeChild(_fileTf);
			if (_perTf != null) removeChild(_perTf);
			if (_lTf != null) removeChild(_lTf);
			if (_tTf != null) removeChild(_tTf);
			try {
				// screenView needs to be added manually cause every screen is handled in ScreenView
				var view : ScreenView = ScreenView(Context.getObject("screenView"));
				addChild(view);

				// navigation needs to be added manually
				var nav : Navigation = Navigation(Context.getObject("navigation"));
				addChild(nav);

				// language needs to be added manually
				var lang : Language = Language(Context.getObject("language"));
				addChild(lang);

				// Fire ScreenEvent at first Time so the first page is always shown
				FrontController.root().dispatchEvent(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, "videoScreen", ""));
			} catch (e : Error) {
			}

			// fps just for testing purposes
			addChild(new FPS());

			// stage.frameRate = 200;

			try {
				var inputControl : Input = Context.getObject("inputControl");
				inputControl.stage = stage;
				inputControl.configureListener();
			} catch(e : Error) {
			}
		}

		/**
		 * 	onError : is called if an error occurs in Dependency Injection
		 */
		private function onError(event : ErrorEvent) : void {
			log.fatal("error has occured : " + event.text);
		}

		private function addPreloaderTxt() : void {
			_fileTf = new TextField();
			_fileTf.border = true;

			_perTf = new TextField();
			_perTf.border = true;

			_lTf = new TextField();
			_lTf.border = true;

			_tTf = new TextField();
			_tTf.border = true;

			addChild(_fileTf);
			addChild(_perTf);
			addChild(_lTf);
			addChild(_tTf);
		}

		/**
		 * handlePreload is called ENTER_FRAME to show the preloading Process
		 */
		private function handlePreload(event : Event) : void {
			if (Context.progressData) {
				_fileTf.text = "File to load : " + Context.progressData.fileName;
				_fileTf.autoSize = TextFieldAutoSize.LEFT;
				_fileTf.x = this.stage.stageWidth / 2 - 100;
				_fileTf.y = this.stage.stageHeight / 2;

				_lTf.text = "Bytes loaded  : " + Context.progressData.loadedBytes;
				_lTf.autoSize = TextFieldAutoSize.LEFT;
				_lTf.x = _fileTf.x;
				_lTf.y = _fileTf.y + 30;

				_tTf.text = "Bytes Total : " + Context.progressData.totalBytes;
				_tTf.autoSize = TextFieldAutoSize.LEFT;
				_tTf.x = _lTf.x;
				_tTf.y = _lTf.y + 30;

				_perTf.text = "progress : " + Context.progressData.progress + " %";
				_perTf.autoSize = TextFieldAutoSize.LEFT;
				_perTf.x = _tTf.x;
				_perTf.y = _tTf.y + 30;
			}
		}
	}
}
