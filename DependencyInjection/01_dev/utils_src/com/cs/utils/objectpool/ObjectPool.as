/**
 * Copyright 15:47:57 24.11.2011 Christian Sobolewski
 * 
 * Usage : CanPool
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
 * History :	-1.1 Refactored into Framework Utils
 * 	
 * 				-1.0 Initial Release
 */
package com.cs.utils.objectpool {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ObjectPool {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ObjectPool));
		private var _poolDic : Dictionary;
		private var _maxObjects : int;
		private var _factory : IPoolObjectFactory;

		public function ObjectPool() {
			_poolDic  = new Dictionary();
		}

		public function objectSleep(id : int) : void {
			if (_poolDic[id] == undefined) _poolDic.sleep();
			else throw new Error("IPoolObject " + id + " could not set to sleep");
		}

		public function getObject(id : String, ifNotExistCreate : Boolean = false, c : Class = null) : IPoolObject {
			
			if (ifNotExistCreate) {
				return createObject(id, c);
			} else {
				if (_poolDic[id] != undefined) {
					return _poolDic[id];
				}
			}
			return null;
		}

		public function createObject(id : String, c : Class = null) : IPoolObject {
			if (_poolDic[id] == undefined) {
				log.info("return and create new: " + c);
				if (factory != null && c != null){
					 _poolDic[id] = factory.createObject(c, id);
					_maxObjects++;
				} else throw new Error("No IPoolObjectFactory found!");
				return _poolDic[id];
			} else {
				log.info("return existing: " + _poolDic[id]);
				return _poolDic[id];
			}
			return null;
		}

		public function get maxObjects() : int {
			return (_maxObjects > 0) ? _maxObjects-1 : 0;
		}

		public function set maxObjects(maxObjects : int) : void {
			_maxObjects = maxObjects;
		}

		public function set factory(factory : IPoolObjectFactory) : void {
			_factory = factory;
		}

		public function get factory() : IPoolObjectFactory {
			return _factory;
		}
	}
}
