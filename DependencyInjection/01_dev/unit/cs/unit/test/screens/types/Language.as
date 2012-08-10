/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens.types
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.types.Language
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.types {
	import com.cs.di.core.mvc.FrontController;
	import com.cs.utils.references.GetMovieClip;
	import cs.unit.test.screens.event.ScreenEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;



	/**
	 * @author Christian Sobolewski
	 */
	public class Language extends Sprite {
		private var _exportName : String;
		
		public function Language(exportName : String) {
			_exportName = exportName;
		}

		public function initLanguage():void {
			var clip : MovieClip = GetMovieClip(_exportName);
			addChild(clip);
			
			// 	cheap impl but works for test purposes 

			for (var i : Number = 0;i < 3;i++) {
				var d : DisplayObject = clip.getChildAt(i);
				Sprite(d).buttonMode = true;
				d.addEventListener(MouseEvent.CLICK, handleClick);
			}
		 	
			x = 10;
			y = 730;
		}
		
		private function handleClick(event : MouseEvent) : void {
			FrontController.root().dispatchEvent(new ScreenEvent(ScreenEvent.REQUEST_LANGUAGE_CHANGE, "", event.currentTarget.name));
		}
	}
}
