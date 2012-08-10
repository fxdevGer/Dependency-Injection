/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.loader.core.types
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.loader.core.types.LoaderData.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.loader.core.types {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shader;
	import flash.media.Sound;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	import flash.xml.XMLDocument;

	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderData {
		protected var _xml : XMLDocument;
		protected var _loader : Loader;
		protected var _bitmapData : BitmapData;
		protected var _styles : StyleSheet;
		protected var _shader : Shader;
		protected var _bytes : ByteArray;
		protected var _bytesPlain : String;
		protected var _sound : Sound;
		protected var _fileName : String;

		public function LoaderData() {
		}

		public function get xml() : XMLDocument {
			return _xml;
		}

		public function set xml(xml : XMLDocument) : void {
			_xml = xml;
		}

		public function get loader() : Loader {
			return _loader;
		}

		public function set loader(loader : Loader) : void {
			_loader = loader;
		}

		public function get bitmapData() : BitmapData {
			return _bitmapData;
		}

		public function set bitmapData(bitmapData : BitmapData) : void {
			_bitmapData = bitmapData;
		}

		public function get styles() : StyleSheet {
			return _styles;
		}

		public function set styles(styles : StyleSheet) : void {
			_styles = styles;
		}

		public function get shader() : Shader {
			return _shader;
		}

		public function set shader(shader : Shader) : void {
			_shader = shader;
		}

		public function get bytes() : ByteArray {
			return _bytes;
		}

		public function set bytes(bytes : ByteArray) : void {
			_bytes = bytes;
		}

		public function get bytesPlain() : String {
			return _bytesPlain;
		}

		public function set bytesPlain(bytesPlain : String) : void {
			_bytesPlain = bytesPlain;
		}

		public function get sound() : Sound {
			return _sound;
		}

		public function set sound(sound : Sound) : void {
			_sound = sound;
		}

		public function get fileName() : String {
			return _fileName;
		}

		public function set fileName(fileName : String) : void {
			_fileName = fileName;
		}

		public function dispose() : void {
			if (xml) xml = null;
			if (loader) loader = null;
			if (bitmapData) {
				bitmapData.dispose();
				bitmapData = null;
			}
			if (styles) styles = null;
			if (shader) {
				shader.data = null;
				shader = null;
			}
			if (bytes) {
				bytes.clear();
				bytes = null;
			}
			if (bytesPlain) bytesPlain = null;
			if (sound) sound = null;
			if (fileName) fileName = null;

			delete this;
		}
	}
}
