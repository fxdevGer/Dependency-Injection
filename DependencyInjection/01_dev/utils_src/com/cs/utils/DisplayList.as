/**
 * package: com.cs.di.core.utils.DisplayList
 *
 * usage:	DisplayList.removeAll(container);
 * 			DisplayList.getChildById(container,id);
 * 			DisplayList.getChildByName(container,name);
 * 			DisplayList.removeChildById(container,id);
 * 			DisplayList.removeChildByName(container,name);
 *
 * Parameters:
 *			container:DisplayObjectContainer	- The embedding DisplayObject
 * 			id:Number							- Index Number 
 *			name:String							- DisplayObject Name
 *
 * Description:
 * 			
 * 			- returns or removes DisplayObject by id or name
 * 
 * Author:
 * 		 	Christian Sobolewski
 * 			12.07.2007
 *
 * Version: - 1.5 Moved into Dependency Injection utils package
 * 			
 *
 * History:
 * 			- 1.4 Moved into package com.flashdeveloping.display
 * 			- 1.3 Added Recursive Method removingAll
 * 			- 1.2 Fixed removeAll Bug, now it works
 * 			- 1.1 Added Method removeAll
 * 			- 1.0
 */
package com.cs.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class DisplayList {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(DisplayList));
		private static var singleton : DisplayList;

		public function DisplayList(singletonEnforcer : SingletonEnforcer) {
		}
		
		/**
		 * 	removeDeep removes als children from cont and its children
		 */
		
		public static function removeDeep(cont : DisplayObjectContainer) : void {
			DisplayList.getInstance()._removeDeep(cont);
		}

		private function _removeDeep(cont : DisplayObjectContainer) : void {
			var i : int = cont.numChildren - 1;
			for (i; i >= 0 ; i--) {
				if (cont.getChildAt(i) is DisplayObjectContainer) {
					_removeAll(DisplayObjectContainer(cont.getChildAt(i)));
				}
				cont.removeChildAt(i);
			}
		}

		/**
		 *	removeAll removes all children from param cont
		 */
		public static function removeAll(cont : DisplayObjectContainer) : void {
			DisplayList.getInstance()._removeAll(cont);
		}

		private function _removeAll(cont : DisplayObjectContainer) : void {
			var i : int = cont.numChildren - 1;
			for (i; i >= 0 ; i--) {
				cont.removeChildAt(i);
			}
		}

		/**
		 * 	removeChildByName
		 */
		static public function removeChildByName(cont : DisplayObjectContainer, name : String) : void {
			DisplayList.getInstance()._removeChildByName(cont, name);
		}

		private function _removeChildByName(cont : DisplayObjectContainer, name : String) : void {
			var i : Number = 0;
			var child : DisplayObject;
			while (i < cont.numChildren) {
				child = cont.getChildAt(i);
				if (cont.name == name) {
					cont.removeChild(child);
					break;
				}
				i++;
			}
		}

		/**
		 * 	removeChildById
		 */
		static public function removeChildById(cont : DisplayObjectContainer, id : int) : void {
			DisplayList.getInstance()._removeChildById(cont, id);
		}

		private function _removeChildById(cont : DisplayObjectContainer, id : int) : void {
			var i : Number = 0;
			while (i < cont.numChildren) {
				if (i == id) {
					cont.removeChildAt(i);
					break;
				}
				i++;
			}
		}

		/**
		 * 	getChildByName
		 */
		static public function getChildByName(cont : DisplayObjectContainer, name : String) : DisplayObject {
			return DisplayList.getInstance()._getChildByName(cont, name);
		}

		private function _getChildByName(cont : DisplayObjectContainer, name : String) : DisplayObject {
			var i : Number = 0;
			var child : DisplayObject;
			while (i < cont.numChildren) {
				child = cont.getChildAt(i);
				if (child.name == name) {
					break;
				}
				i++;
			}
			return child;
		}

		/**
		 * 	getChildById
		 */
		static public function getChildById(cont : DisplayObjectContainer, id : int) : DisplayObject {
			return DisplayList.getInstance()._getChildById(cont, id);
		}

		private function _getChildById(cont : DisplayObjectContainer, id : int) : DisplayObject {
			var i : Number = 0;
			var child : DisplayObject;
			while (i < cont.numChildren) {
				if (i == id) {
					child = cont.getChildAt(i);
					break;
				}
				i++;
			}
			return child;
		}

		/**
		 * 	Singleton
		 */
		static private function getInstance() : DisplayList {
			if (DisplayList.singleton == null) {
				DisplayList.singleton = new DisplayList(new SingletonEnforcer());
			}
			return DisplayList.singleton;
		}
	}
}
class SingletonEnforcer {
}