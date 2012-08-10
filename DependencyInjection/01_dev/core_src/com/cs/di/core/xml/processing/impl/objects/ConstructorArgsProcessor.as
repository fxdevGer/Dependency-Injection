/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.xml.processing.impl
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.xml.processing.impl.ConstructorArgsProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.objects {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.impl.ProcessingUtils;

	import flash.utils.getQualifiedClassName;


	/**
	 * @author Christian Sobolewski
	 */
	public class ConstructorArgsProcessor extends AbstractProcessor {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ConstructorArgsProcessor));

		public function ConstructorArgsProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.info("ConstructorArgsProcessor.proceedNode: " + children + " | " + attributes);

			var data : Array = [];
			var nodeLength : int = xmlNode.children().length();
			var node : XML;

			for (var i : int = 0; i < nodeLength; i++) {
				node = xmlNode.children()[i];
				data.push(getValue(node));
			}

			processedData = data;
		}

		private function getValue(node : XML) : * {
			switch(node.localName()) {
				case children[0]:	// boolean
					return (node.toString() == "false") ? false : true;
					break;
				case children[1]:	// number
					return Number(node);
					break;
				case children[2]:	// int
					return int(parseInt(node));
					break;
				case children[3]:	// uint
					return uint(parseInt(node));
					break;
				case children[4]:	// vector3D
					return ProcessingUtils.getVector3D(node.toString().split(","));
					break;
				case children[5]:	// string
					return node.toString();
					break;
				case children[6]:	// array (special)
					var arr : Array = [];
					for (var i : int = 0; i < node.children().length();i++) {
						arr.push(getValue(node.children()[i]));
					} 
					return arr;
					break;
				case children[7]:	// date
					var dateStr:String = node.toString();
    				dateStr = dateStr.replace(/-/g, "/");
    				dateStr = dateStr.replace("T", " ");
    				dateStr = dateStr.replace("Z", " GMT-0000");
   					return new Date(Date.parse(dateStr));
					break;
				case children[8]:	// id-ref
					try {
						var a : Array = node.toString().split(".");
						
						if (a.length > 1) return Context.getObject(a[0])[a[1]]; // FIXME : Hack if Object.property is defined Object.property is returned not the id-ref
						else return Context.getObject(a[0]);
						
//						return Context.getObject(node.toString());
					} catch (e : TypeError) {
						throw new ConfigurationError(node.toString() + " could not be injected via constructor-args");
						return null;
					}
					break;
			}
		}
		
	}
}
