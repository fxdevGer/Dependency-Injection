/**
 * Copyright 22.08.2011 Christian Sobolewski
 * 
 * Usage : ProcessingUtils
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
package com.cs.di.core.xml.processing.impl {
	import flash.geom.Vector3D;
	/**
	 * @author Christian Sobolewski
	 */
	public class ProcessingUtils {
		
		public static function getVector3D(params : Array) : Vector3D {
			switch (params.length) {
				case 0:return new Vector3D(0, 0, 0);break;
				case 1:return new Vector3D(Number(params[0]), 0, 0);break;
				case 2:return new Vector3D(Number(params[0]), Number(params[1]), 0);break;
				case 3:return new Vector3D(Number(params[0]), Number(params[1]), Number(params[2]));break;
				default: throw new ArgumentError("Unsupported number of Vector3D : " + params.length);
			}
		}
		
	}
}
