/**
 * Copyright 2008 Christian Sobolewski
 * 
 * usage : com.cs.di.core.utils.shader
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.utils.shader.AbstractShader.as
 * @author Christian Sobolewski
 */
package com.cs.utils.shader {
	import flash.display.AVM1Movie;
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.ColorCorrection;
	import flash.display.ColorCorrectionSupport;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.GraphicsShaderFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsTrianglePath;
	import flash.display.IBitmapDrawable;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsPath;
	import flash.display.IGraphicsStroke;
	import flash.display.InteractiveObject;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.SWFVersion;
	import flash.display.Scene;
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderInput;
	import flash.display.ShaderJob;
	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.display.ShaderPrecision;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display.TriangleCulling;

	/**
	 * @author Christian Sobolewski
	 */
	public class AbstractShader extends Sprite implements IShader {

		private var _shader : Shader;
		private var _shaderedBitmap : Bitmap;
		private var _isShading : Boolean;

		public function AbstractShader() {
			shading = false;
		}

		public function startShading() : void {
		}

		public function stopShading() : void {
		}

		public function dispose() : void {
		}
		
		public function setShaderImageSource() : void {
		}
		
		public function set shader(shader : Shader) : void {
			_shader = shader;
		}
		
		public function get shader() : Shader {
			return _shader;
		}

		public function get bitmap() : Bitmap {
			return _shaderedBitmap;
		}

		public function set bitmap(bitmap : Bitmap) : void {
			_shaderedBitmap = bitmap;
		}

		public function set shading(isShading : Boolean) : void {
			_isShading = isShading;
		}

		public function get shading() : Boolean {
			return _isShading;	
		}
	}
}
