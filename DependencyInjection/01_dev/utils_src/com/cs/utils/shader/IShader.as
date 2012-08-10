/**
 * Copyright 01.01.2008 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : IShader Interface for each Shader. Implemented by AbstractShader
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
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
	public interface IShader {
		
		/**
		 * 	start Shading
		 */
		
		function startShading() : void;
		
		/**
		 * 	stop Shading
		 */
		
		function stopShading() : void;
		
		/**
		 * 	frees memory and removes all listener
		 */
		
		function dispose() : void;
		
		/**
		 * 	sets some properties from used bitmap to the shader
		 */
		
		function setShaderImageSource() : void;
		
		/**
		 * 	sets the Shader Source
		 */
		
		function set shader(shader : Shader) : void;
		
		/**
		 * 	gets the Shader Source
		 */
		
		function get shader() : Shader;
		
		/**
		 * 	sets the Bitmap Source for the Shader
		 */
		
		function set bitmap(bitmap : Bitmap) : void;
		
		/**
		 * 	gets the Bitmap Source for the Shader
		 */
		
		function get bitmap() : Bitmap;
		
		/**
		 * 	sets Shading Status true or false
		 */
		
		function set shading(isShading : Boolean) : void;
		
		/**
		 * 	gets Shading Status true or false
		 */
		
		function get shading() : Boolean
	}
}
