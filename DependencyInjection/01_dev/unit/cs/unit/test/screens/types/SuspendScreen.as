/**
 * Copyright 13.07.2011 Christian Sobolewski
 * 
 * Usage : LoadSuspend
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
 * History :
 * 
 */
package cs.unit.test.screens.types {
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.models.SuspendModel;

	import com.cs.di.core.context.Context;
	import com.cs.di.core.csinject;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class SuspendScreen extends Screen {
		
		use namespace csinject;
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(SuspendScreen));
		
		private var _model : SuspendModel;
		private var _imageCont : Sprite;
		
		public function SuspendScreen() {
			super();
			_imageCont = new Sprite();
			addChild(_imageCont);
		}
		
		public override function activate():void {
			/**
			 * FileLoaderContext.factory.fileLoader.addEventListener(Event.COMPLETE, handleLoadingComplete)
			 * is necessary here cause if you load a Group by Name you have to add that Event.COMPLETE 
			 * to know when the LoaderGroup has been loaded
			 */
			Context.fileLoader.addEventListener(Event.COMPLETE, handleLoadingComplete);
			Context.fileLoader.loadByGroupName("suspendModel");
		}

		private function handleLoadingComplete(event : Event) : void {
			var sBitmap : Bitmap;
			var xPos : Number = 10;
			var yPos : Number = 300;
			var i : int = 0;
			
			for each (var bit : BitmapData in suspendModel.images) {
				sBitmap = new Bitmap(bit.clone());
				sBitmap.width = 150;
				sBitmap.height = 150;
				sBitmap.x = (xPos + sBitmap.width) * (i++);
				sBitmap.y = yPos;
				
				_imageCont.addChild(sBitmap);
			}
			
		}
		
		public override function update() : void {
		}
		
		public override function dispose() : void {
//			for each (var bit : Bitmap in _imageCont) {
//				_imageCont.removeChild(bit);
//			}
//			
//			suspendModel.dispose();
			
		}
		
		public function get suspendModel() : SuspendModel {
			return _model;
		}

		public function set suspendModel(model : SuspendModel) : void {
			_model = model;
		}
		
	}
}
