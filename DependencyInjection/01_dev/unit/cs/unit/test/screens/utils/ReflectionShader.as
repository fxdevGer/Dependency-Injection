/**
 * Copyright 08.09.2010 Christian Sobolewski
 * 
 * usage : screens.utils
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.utils.ReflectionShader
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.utils {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.utils.DisplayList;
	import com.cs.utils.shader.AbstractShader;
	import flash.filters.ShaderFilter;
	import flash.utils.getQualifiedClassName;


	/**
	 * @author Christian Sobolewski
	 */
	public class ReflectionShader extends AbstractShader {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ReflectionShader));

		public function ReflectionShader(w : Number, h : Number) {
			super();
			graphics.beginFill(0x00ff00);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}

		public override function startShading() : void {
			try {
				if (bitmap != null && !contains(bitmap)) {
					addChild(bitmap);
				}
				bitmap.x = 0;
				bitmap.y = 0;

				var pos : Number = bitmap.y + bitmap.height;

				shading = true;

				var filter : ShaderFilter = new ShaderFilter(shader);

				shader.data.bgcol.value = [0.0, 1.0, 0.0, 1.0];
				// background color
				shader.data.reflectpos.value = [pos];
				filters = [filter];

				// addEventListener(Event.ENTER_FRAME, renderShader);
			} catch (error : Error) {
				log.error("error startShading: " + error.message);
			}
		}

		public override function dispose() : void {
			shader = null;
			bitmap.bitmapData.dispose();
			shading = undefined;
			DisplayList.removeDeep(this);
		}
	}
}
