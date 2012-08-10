/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : MethodProcessor
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
package com.cs.di.core.xml.processing.impl.objects {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.csinject;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class MethodProcessor extends AbstractProcessor {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MethodProcessor));
		
		use namespace csinject;
		
		public function MethodProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.warn("proceedNode: " + objectId + " | attributes : " + attributes + " | childsInjection: " + childsInjection + " | " + objectId);

			var name : String = getAttributeFromNode(xmlNode, attributes[0]);
			var value : String = getAttributeFromNode(xmlNode, attributes[1]);
			var idRef : String = getAttributeFromNode(xmlNode, attributes[2], " ");
			var valueRef : String = getAttributeFromNode(xmlNode, attributes[3], " ");
			var arguments : String = getAttributeFromNode(xmlNode, attributes[4], " ");
			var idRefSplit : Array = idRef.split(",");
			var valueRefSplit : Array = valueRef.split(",");
			var argumentsSplit : Array = arguments.split(",");
			var idObject : Array = [], valueObject : Array = [];

			var i : int = 0, j : int = 0;

			// if childsInjection is true set all Properties to objectId
			if (!childsInjection) {
				try {
					switch(true) {
						case idRef == "":
							try {
								switch(true) {
									case value == "":
//										log.fatal('argumentsSplit.length: ' + (argumentsSplit.length));
										switch(argumentsSplit.length) {
											case 1:
												Context.getObject(objectId)[name]();
												// if value not defined and idRef not defined only Method name is called
											break;
											
											default:
//												log.fatal("value " + value + " | " + argumentsSplit);
												callMethod(argumentsSplit, name);
											break;
										}
										break;
									case value != "":
										Context.getObject(objectId)[name](value);
										// if value is defined Method name with value is called
										break;
								}
							} catch(e : Error) {
								throw new ConfigurationError(objectId + "." + name + "(" + value + ") could not be called.");
							}
							break;
						case idRef != "":
							try {
								switch(true) {
									case valueRef != "":
										// if arguments unshift each Object in Context.getObject(idRef)[valueRef] into argumentsSplit
										if (arguments != "") {
											argumentsSplit.unshift(Context.getObject(idRef)[valueRef]);
											callMethod(argumentsSplit, name);
										} else if (value != "") {
											// if idRef is defined
											// and if valueRef is defined, each valueRef is called from idRef Object and injecected into objectId
											// and if value is defined

											// set each Object found in idRefSplit in idObject
											for (i = 0; i < idRefSplit.length; i++) {
												idObject[i] = Context.getObject(idRefSplit[i]);

												for (j = 0; j < valueRefSplit.length; j++) {
													valueObject[j] = idObject[i][valueRefSplit[j]];
													valueObject[i][name](value);
												}
											}
										} else {
											// if idRef is defined
											// and if valueRef is defined, each valueRef is called from idRef Object and injecected into objectId

											// set each Object found in idRefSplit in idObject
											for (i = 0; i < idRefSplit.length; i++) {
												idObject[i] = Context.getObject(idRefSplit[i]);
											}

											// for each found Object in idObject set the Values found in ValueObject
											for (i = 0; i < idRefSplit.length; i++) {
												for (j = 0; j < valueRefSplit.length; j++) {
													valueObject[j] = idObject[i][valueRefSplit[j]];
												}
												// just call Method for executing the Method give by name
												callMethod(valueObject, name);
											}
										}
										break;
									case valueRef == "":
										// valueRef is not defined so each id-ref Object injected with Method name in ObjectId
										// set each Object found in idRefSplit in idObject
										for (i = 0; i < idRefSplit.length; i++) {
											idObject[i] = Context.getObject(idRefSplit[i]);
										}
										// if arguments unshift each Object in idObject into argumentsSplit
										if (arguments != "") {
											for each (var o : Object in idObject) {
												argumentsSplit.unshift(o);
											}
											callMethod(argumentsSplit, name);
										} else {
											// just call Method for executing the Method give by name
											callMethod(idObject, name);
										}
										break;
								}
							} catch(e : Error) {
								throw new ConfigurationError(idRef + " or " + idObject + " could not be injected into " + objectId + "." + name + "(" + arguments + ")");
							}
					}
				} catch (e : TypeError) {
					throw new ConfigurationError(name + " Method for " + objectId + " not found!");
				}

				dispose();
			} else {
				// If childsInjection false, push all Processors into ContextModel.
				Context.getContextModel(objectId).processors.push(this);
			}

			// log.debug("-------------------------------------------------------------------------------------------------------------------------");
		}

		private function callMethod(params : Array, method : String) : void {
			switch (params.length) {
				case 0:Context.getObject(objectId)[method]();break;
				case 1:Context.getObject(objectId)[method](params[0]);break;
				case 2:Context.getObject(objectId)[method](params[0], params[1]);break;
				case 3:Context.getObject(objectId)[method](params[0], params[1], params[2]);break;
				case 4:Context.getObject(objectId)[method](params[0], params[1], params[2], params[3]);break;
				case 5:Context.getObject(objectId)[method](params[0], params[1], params[2], params[3], params[4]);break;
				case 6:Context.getObject(objectId)[method](params[0], params[1], params[2], params[3], params[4], params[5]);break;
				case 7:Context.getObject(objectId)[method](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);break;
				case 8:Context.getObject(objectId)[method](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);break;
				default: throw new ArgumentError("Unsupported number of Method args: " + params.length);
			}
		}
	}
}
