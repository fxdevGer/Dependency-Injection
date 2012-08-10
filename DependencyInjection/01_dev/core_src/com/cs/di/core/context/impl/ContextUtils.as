/**
 * Copyright 16.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : Some utils for the Context. Most important method is getInstanceByName, 
 * 				 this returns the instance by Name. That method is called by Context.getObject(name);
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context.impl {
	import com.cs.di.core.csinject;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.getQualifiedClassName;
	
	use namespace csinject;
	
	/**
	 * @author Christian Sobolewski
	 */
	public class ContextUtils {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ContextUtils));
		protected static var _context : Vector.<ContextModel> = new Vector.<ContextModel>();

		/**
		 * 	returns an instance by the given name
		 * 	checks if only one instance of the object has been created
		 */
		csinject static function getInstanceByName(name : String, check : Boolean = false) : * {
			var model : ContextModel = getModelByName(name);
			
			if (model == null && !check) {
				throw new ConfigurationError("Instance > " + name + " < not found!");
			} else if (model == null && check) {
				return null;
			} else return model.instance;
			
			return null;
		}
		
		/**
		 * returns an instance by the given name
		 */
		csinject static function getContextModelByName(name : String) : ContextModel {
			return getModelByName(name);
		}
		
		private static function getModelByName(name : String) : ContextModel {
			var len : int = _context.length;
			var model : ContextModel = null;
			for (var i : int = 0; i < len; i++) {
				model = _context[i];
				if (model.id == name) {
					return model;
				}
			}
			return null;
		}
		
		/**
		 *	removes the instance by name 
		 */
		csinject static function removeInstanceModel(key : String) : void {
			var len : int = _context.length;
			var model : ContextModel;
			var item : int = -1;
			
			for (var i : int = 0; i < len;i++) {
				if (model.id == key) {
					item = i;
					break;
				}
			}
			
			log.warn("removed? " + key + " | " + model.id + " | " + item);
			
			if (item != -1) {
				model.dispose();		// TODO : model.dispose() needs some testing!
				_context.splice(item, 1);
			}
			
		}
		
		/**
		 * called if any <code>ContextModel</code> is created
		 */

		csinject static function addInstanceModel(m : ContextModel) : void {
			_context.push(m);
		}
		
		/**
		 * returns all Models
		 */
		
		csinject static function getModels() : Vector.<ContextModel> {
			return _context;
		}
		
	}
}
