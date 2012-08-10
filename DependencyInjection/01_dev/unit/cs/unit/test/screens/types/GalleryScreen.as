/**
 * Copyright 24.03.2010 Christian Sobolewski
 * 
 * usage :screens.types
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.types.Gallery
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.types {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.ContextParser;
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.utils.DisplayList;
	import com.cs.utils.references.GetMovieClip;
	import cs.unit.test.examples.ExampleLoaderGroup;
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.utils.ReflectionShader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;



	/**
	 * @author Christian Sobolewski
	 */
	public class GalleryScreen extends Screen {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(GalleryScreen));
		private var _model : ExampleLoaderGroup;
		private var _des : MovieClip;
		private var _tfId : Number;
		private var _tf : TextField;
		private var _small : Sprite = new Sprite();
		private var _bigSize : ReflectionShader;
		private var _bigSizeBg : Sprite;
		private var _bigSizeCont : Sprite;
		private var _contexts : Array;
		private var _modelString : String;

		public function GalleryScreen() {
			log.info("injected");
			_contexts = [];
		}

		public override function activate() : void {
			log.warn("activate");
			// _small.x = 1024 / 2 - _small.width / 2;
			// _small.y = 768 / 2 - _small.height / 2;
			// addChild(_small);

			if (_contexts.length > 0) {
				// create a new ContextParser Instance. Main entry Point
				var contextParser : ContextParser = new ContextParser();

				// add files to parse. logging.xml and context.xml is used here
				for each (var path : String in _contexts) {
					contextParser.addFile(path);
				}

				// add Events for listen. ErrorEvent.ERROR is an Error occurrs
				// Event.COMPLETE if all is ready to start
				contextParser.addEventListener(Event.COMPLETE, onComplete);
				contextParser.addEventListener(ErrorEvent.ERROR, onError);

				// start
				contextParser.start();
			}
		}

		private function onError(event : ErrorEvent) : void {
			log.fatal("error has occured : " + event.text);
		}

		private function onComplete(event : Event) : void {
			var contextParser : ContextParser = ContextParser(event.currentTarget);
			contextParser.removeEventListener(Event.COMPLETE, onComplete);

			_model = Context.getObject(_modelString);

			log.info('_model: ' + (_model));

			_small.x = 1024 / 2 - _small.width / 2;
			_small.y = 768 / 2 - _small.height / 2;
			addChild(_small);

			createGallery();

			log.warn("internally contextParser in Gallery ready");
		}

		private function createGallery() : void {
			var l : int = _model.images.length;
			var sh : ReflectionShader;
			var bit : BitmapData;
			var sBitmap : Bitmap;
			var w : Number = 150;
			var h : Number = 100;

			for (var i : Number = 0;i < l;i++) {
				bit = _model.images[i];
				sBitmap = new Bitmap(bit.clone());
				sBitmap.width = w;
				sBitmap.height = h;

				sh = new ReflectionShader(w, h + 30);
				sh.shader = _model.shader[1];
				sh.bitmap = sBitmap;
				sh.startShading();
				sh.name = String(i);

				sh.x = ((i % (l / 2)) * w) + i % (l / 2) * 20;
				sh.y = ((l / 3) % i) * h;

				sh.buttonMode = true;
				sh.addEventListener(MouseEvent.CLICK, handleMouseEvent);

				_small.addChild(sh);
			}

			_small.x = 1024 / 2 - _small.width / 2;
			_small.y = 768 / 2 - _small.height / 2;
			
			log.info("_small.numChildren: " + _small.numChildren);
		}

		public override function update() : void {
			if (_des != null) {
				_tf.styleSheet = Context.styleSheet;
				_tf.htmlText = "<.imageCopy>" + LocaleContext.getMessage(language, String("description." + _tfId)) + "</.imageCopy>";
				_tf.antiAliasType = AntiAliasType.ADVANCED;
				_tf.autoSize = TextFieldAutoSize.LEFT;
			}
		}

		public override function dispose() : void {
			_model.dispose();
			_model = null;
			
			var d: ReflectionShader;
			
			for (var i : int = 0; i < _small.numChildren;i++) {
				d = ReflectionShader(_small.getChildAt(i));
				if (d.hasEventListener(MouseEvent.CLICK)) {
					d.removeEventListener(MouseEvent.CLICK, handleMouseEvent);
				}
				d.dispose();
			}
			
			DisplayList.removeDeep(this);
			
			disposeBig();

			log.info("dispose children? " + this.numChildren);
		}

		public function set addContexts(context : String) : void {
			_contexts.push(context);
			log.warn('_contexts: ' + (_contexts));
		}

		private function disposeBig() : void {
			if (_bigSizeCont != null) {
				_bigSizeCont.removeEventListener(MouseEvent.CLICK, handleMouseEventBig);
				DisplayList.removeDeep(_bigSizeCont);
				_bigSizeCont = null;
			}
		}

		private function handleMouseEvent(event : MouseEvent) : void {
			_tfId = Number(event.currentTarget.name) + 1;

			_bigSizeCont = new Sprite();
			_bigSize = new ReflectionShader(800, 600);

			var bit : BitmapData = _model.images[_tfId - 1];
			var sBitmap : Bitmap = new Bitmap(bit.clone());
			sBitmap.height = 450;
			sBitmap.width = 800;

			_bigSize.shader = _model.shader[1];
			_bigSize.bitmap = sBitmap;
			_bigSize.startShading();
			_bigSize.x = 1024 / 2 - 400;
			_bigSize.y = 768 / 2 - 250;

			_des = GetMovieClip("Description");
			_tf = _des.tf;

			_tf.styleSheet = Context.styleSheet;

			_tf.htmlText = "<.imageCopy>" + LocaleContext.getMessage(language, String("description." + _tfId)) + "</.imageCopy>";
			_tf.antiAliasType = AntiAliasType.ADVANCED;
			_tf.autoSize = TextFieldAutoSize.LEFT;

			_des.x = Math.round(1024 / 2 - _des.width / 2);
			_des.y = 580;

			_bigSizeBg = new Sprite();
			_bigSizeBg.graphics.clear();
			_bigSizeBg.graphics.beginFill(0x000000, .8);
			_bigSizeBg.graphics.drawRect(0, 0, 1024, 768);
			_bigSizeBg.graphics.endFill();

			_bigSizeCont.addChild(_bigSizeBg);
			_bigSizeCont.addChild(_bigSize);
			_bigSizeCont.addChild(_des);

			_bigSizeCont.addEventListener(MouseEvent.CLICK, handleMouseEventBig);

			addChild(_bigSizeCont);
		}

		private function handleMouseEventBig(event : MouseEvent) : void {
			disposeBig();
		}

		public function set modelString(modelString : String) : void {
			_modelString = modelString;
		}
	}
}
