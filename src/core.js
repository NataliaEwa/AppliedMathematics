!function(e){var t={};function n(o){if(t[o])return t[o].exports;var s=t[o]={i:o,l:!1,exports:{}};return e[o].call(s.exports,s,s.exports,n),s.l=!0,s.exports}n.m=e,n.c=t,n.d=function(e,t,o){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:o})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var o=Object.create(null);if(n.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var s in e)n.d(o,s,function(t){return e[t]}.bind(null,s));return o},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="",n(n.s=0)}([function(e,t,n){e.exports=n(1)},function(e,t,n){"use strict";function o(e){return(o="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e})(e)}function s(e,t){for(var n=0;n<t.length;n++){var o=t[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(e,o.key,o)}}n.r(t);var r=function(){function e(){!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,e),this._hostObject=null,this._hostMessageHandlerFn=null}var t,n,r;return t=e,(n=[{key:"initialize",value:function(e){e&&"object"==o(e)&&(e.hostObject&&"object"==o(e.hostObject)&&(this._hostObject=e.hostObject),e.hostMessageHandlerFn&&"function"==typeof e.hostMessageHandlerFn&&(this._hostMessageHandlerFn=e.hostMessageHandlerFn))}},{key:"handleMessage",value:function(e){}},{key:"finalize",value:function(e){}},{key:"sendMessage",value:function(e){return this._hostObject&&this._hostObject.handleMessage&&"function"==typeof this._hostObject.handleMessage?this._hostObject.handleMessage(e):this._hostMessageHandlerFn?this._hostMessageHandlerFn(e):void 0}},{key:"sendMessageToJSCore",value:function(e,t){return this.sendMessage({targetType:"JSCore",message:e,data:t||{}})}},{key:"sendMessageToParent",value:function(e,t){return this.sendMessage({targetType:"Parent",message:e,data:t||{}})}},{key:"sendMessageToHost",value:function(e,t){return this.sendMessage({targetType:"Host",message:e,data:t||{}})}},{key:"sendMessageToContainer",value:function(e,t){return this.sendMessage({targetType:"Container",message:e,data:t||{}})}},{key:"sendMessageToApplet",value:function(e,t,n,o,s){return this.sendMessage({targetType:"Applet",targetID:n||"",targetVersion:o||"",targetInstanceID:s||"",message:e,data:t||{}})}}])&&s(t.prototype,n),r&&s(t,r),e}();function a(e,t){for(var n=0;n<t.length;n++){var o=t[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(e,o.key,o)}}var i=new(function(){function e(){!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,e)}var t,n,o;return t=e,(n=[{key:"_preprocess",value:function(e){for(var t=0;t<e.length;++t)"string"==typeof e[t]&&e[t].length>10512&&(e[t]=e[t].substring(0,10512)+".....<Truncated>")}},{key:"getStringFromArgs",value:function(e){for(var t="",n=0;n<e.length;n++)"string"==typeof e[n]?t+=e[n]:e[n]&&(t+=JSON.stringify(e[n]));return t}},{key:"error",value:function(){if(!window.logLevel||0!==window.logLevel){var e=Array.prototype.slice.call(arguments);console.error.apply(console,e);try{window.JSObject?window.JSObject.logError(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["ERROR",this.getStringFromArgs(e)])}catch(e){}}}},{key:"warn",value:function(){if(window.logLevel&&window.logLevel>=2){var e=Array.prototype.slice.call(arguments);console.warn.apply(console,e);try{window.JSObject?window.JSObject.logWarn(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["WARN",this.getStringFromArgs(e)])}catch(e){}}}},{key:"log",value:function(){if(window.logLevel&&window.logLevel>=3){var e=Array.prototype.slice.call(arguments);this._preprocess(e),console.trace&&console.trace.apply(console,e);try{window.JSObject?window.JSObject.logInfo(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["LOG",this.getStringFromArgs(e)])}catch(e){}}}},{key:"info",value:function(){if(window.logLevel&&window.logLevel>=3){var e=Array.prototype.slice.call(arguments);this._preprocess(e),console.trace&&console.trace.apply(console,e);try{window.JSObject?window.JSObject.logInfo(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["INFO",this.getStringFromArgs(e)])}catch(e){}}}},{key:"debug",value:function(){if(window.logLevel&&window.logLevel>=4){var e=Array.prototype.slice.call(arguments);this._preprocess(e),console.trace&&console.trace.apply(console,e);try{window.JSObject?window.JSObject.logDebug(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["DEBUG",this.getStringFromArgs(e)])}catch(e){}}}},{key:"trace",value:function(){if(window.logLevel&&window.logLevel>=5){var e=Array.prototype.slice.call(arguments);this._preprocess(e),console.trace&&console.trace.apply(console,e);try{window.JSObject?window.JSObject.logTrace(this.getStringFromArgs(e)):window.app&&window.app.logMessage&&window.app.logMessage(["TRACE",this.getStringFromArgs(e)])}catch(e){}}}}])&&a(t.prototype,n),o&&a(t,o),e}());function l(e){return(l="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e})(e)}function u(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function c(e,t){for(var n=0;n<t.length;n++){var o=t[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(e,o.key,o)}}function d(e,t,n){return t&&c(e.prototype,t),n&&c(e,n),e}var h=function(){function e(t,n){u(this,e),this._originalCoreObj=n,this._moduleObj=t}return d(e,[{key:"initialize",value:function(e){this._originalCoreObj(e)}},{key:"handleMessage",value:function(e){return e.sourceID||(e.sourceID=this._moduleObj._id),e.sourceVersion||(e.sourceVersion=this._moduleObj._version),e.sourceInstanceID||(e.sourceInstanceID=this._moduleObj._instanceID),e.isAsync=null==e.isAsync||e.isAsync,e.enableLog=null==e.enableLog||e.enableLog,e.sendViaMainThread=null!=e.sendViaMainThread&&e.sendViaMainThread,this._originalCoreObj.handleMessage(e)}},{key:"finalize",value:function(e){this._originalCoreObj.finalize(e)}}]),e}(),g=function(){function e(t,n,o,s,r){u(this,e),this._type=t.type,this._id=t.id,this._version=t.version,this._instanceID=t.instanceID,this._path=t.path,this._csspath=t.cssPath,this._role=t.role,this._dictionaryPath=t.dictionaryPath,this._parentID=n||"",this._parentVersion=o||"",this._parentInstanceID=s||"",this._instanceID||(this._instanceID=this._parentInstanceID),this._object=null,this._isLoaded=!1,this._coreObj=new h(this,r),this._originalCoreObj=r}return d(e,[{key:"getParent",value:function(){return this._parentID}},{key:"register",value:function(e,t){var n=arguments.length>2&&void 0!==arguments[2]?arguments[2]:null;if(i.debug("CoreModule: Successfully loaded Module '",this._id,"'"),!(e&&"object"==l(e)&&e.initialize&&"function"==typeof e.initialize&&e.handleMessage&&"function"==typeof e.handleMessage&&e.finalize&&"function"==typeof e.finalize))return!1;this._object=e,this._isLoaded=!0;var o={hostObject:this._coreObj,type:this._type,id:this._id,version:this._version,instanceID:this._instanceID,path:this._path,initJSON:t.initData,dictionary:n};return!1!==this._object.initialize(o)}},{key:"loadResources",value:function(e,t){for(var n=[],o=0;o<e.length;++o)n.push(JSON.parse(JSON.stringify(e[o]))),n[o].status=void 0,n[o].response=void 0;for(var s=function(){for(var e=!0,o=!0,s=0;s<n.length;++s)e=e&&void 0!==n[s].status,o=o&&(!n[s].isMandatory||!0===n[s].status);e&&t(o,n)},r=function(t){if("js"==e[t].type){var o=document.createElement("script");o.type="text/javascript",o.src=e[t].path+"?t="+(new Date).getTime(),o.onload=function(e){n[t].status=!0,n[t].response=e,s()},o.onerror=function(e){n[t].status=!1,n[t].response=e,s()},document.head.appendChild(o)}else if("css"==e[t].type){var r=document.createElement("link");r.setAttribute("rel","stylesheet"),r.setAttribute("type","text/css"),r.href=e[t].path+"?t="+(new Date).getTime(),r.onload=function(e){n[t].status=!0,n[t].response=e,s()},r.onerror=function(e){n[t].status=!1,n[t].response=e,s()},document.head.appendChild(r)}else if("json"==e[t].type){var a=new XMLHttpRequest;a.open("GET",e[t].path+"?t="+(new Date).getTime()),a.onload=function(){"number"==typeof a.status&&a.status<400?(n[t].status=!0,n[t].response=JSON.parse(a.response)):(n[t].status=!1,i.error("Non-success code: "+a.status+" in loading json: "+e[t].path)),s()},a.onerror=function(){n[t].status=!1,s()},a.send()}},a=0;a<e.length;++a)r(a)}},{key:"load",value:function(e,t){var n=this;if("OldApplet"!=this._type){var o=null,s=null,r=[];return this._path&&r.push({path:this._path,type:"js",isMandatory:!0}),this._csspath&&r.push({path:this._csspath,type:"css",isMandatory:!0}),this._dictionaryPath&&r.push({path:this._dictionaryPath+"/"+e.locale+".json",type:"json",isMandatory:!1}),this.loadResources(r,function(r,a){if(r)try{o=window[n._id](),s=n._dictionaryPath&&a[2].status?a[2].response:null,n.register(o,e,s)?(i.info("Core: Module loaded: ",n._id),t({status:!0})):(i.error("Core: Module register messageData: ",e),t({status:!1,response:{errorType:"register",errorReason:"undefined"}}))}catch(n){i.error("Core: Module register exception: ",n,", messageData: ",e),t({status:!1,response:{errorType:"register",errorReason:"exception"}})}else i.error("Core: Module load error: ",a,", messageData: ",e),t({status:!1,response:{errorType:"load",errorReason:"undefined",errorResourceList:a}})}),!0}this.loadOld(e,t)}},{key:"getEntity",value:function(){var e=new(window.Backbone.Model.extend({defaults:{id:this.oldAppletId,parentId:"",filePath:this._path,header:{targetID:this._id,targetVersion:"1.0",targetInstanceID:"1",sourceID:this._id.replace("_UI","_BL"),sourceVersion:"1.0",sourceInstanceID:"1"},order:0,isVisible:!1,isLoaded:!1,type:"panel",localizedName:"",children:[],needsAttention:!1,showBadge:!1,panelTab:null},setTab:function(e){e&&this.set("panelTab",e)}}));return e.on("change:localizedName",function(){this.moduleObj._originalCoreObj.handleMessage({targetType:"Applet",targetID:"JSContainer_UI",targetVersion:"1.0",message:"UpdatePanelDisplayName",data:{panelName:this.moduleObj._id,displayName:this.entity.attributes.localizedName}})},{entity:e,moduleObj:this}),e}},{key:"loadOld",value:function(e,t){this.oldAppletId=e.initData.divId;var n=this.getEntity();window.require([this._path],function(o){var s=this,r=o.getResourceList();this.loadResources(r,function(r,a){r?(i.info("JSCore: Old module loaded: ",s._id),o.registerMe(n),n.set("isLoaded",!0),t({status:!0})):(i.error("Core: Old Module load error: ",a,", messageData: ",e),t({status:!1,response:{errorType:"load",errorReason:"undefined",errorResourceList:a}}))})}.bind(this),function(e){i.error("JSCore: Old module load failed: ",e," entity: ",n);var o=[];if(e.requireModules&&Array.isArray(e.requireModules))for(var s=0;s<e.requireModules.length;++s)o.push({status:!1,path:e.requireModules[s]});t({status:!1,response:{errorType:"load",errorReason:"undefined",errorResourceList:o}})}.bind(this))}},{key:"handleMessage",value:function(e){if("OldApplet"==this._type){var t=this.oldAppletId;return window.require(["interface/events"],function(n){var o=e;e.dataInXmlData?(o.xmlData={},o.xmlData.data=o.data):o.xmlData=o.data,delete e.dataInXmlData;try{n.trigger(t,{msg:o,type:e.message})}catch(e){i.error("JSCore: Exception in old Applet message trigger: ",e)}}),!0}return!(!this._object||!this._object.handleMessage||"function"!=typeof this._object.handleMessage)&&this._object.handleMessage(e)}}]),e}();function p(e,t){return function(e){if(Array.isArray(e))return e}(e)||function(e,t){var n=[],o=!0,s=!1,r=void 0;try{for(var a,i=e[Symbol.iterator]();!(o=(a=i.next()).done)&&(n.push(a.value),!t||n.length!==t);o=!0);}catch(e){s=!0,r=e}finally{try{o||null==i.return||i.return()}finally{if(s)throw r}}return n}(e,t)||function(){throw new TypeError("Invalid attempt to destructure non-iterable instance")}()}function f(e,t){for(var n=0;n<t.length;n++){var o=t[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(e,o.key,o)}}var y=function(){function e(t){!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,e),this._ccxCoreObj=t,this._loadingModules=new Map,this._loadedModules=new Map,this._loadedCoreExtensions=new Map,this._moduleRoleMap=new Map,this._loadStatusMap=new Map,this._loadStatusCallback=null}var t,n,o;return t=e,(n=[{key:"statusCallback",value:function(e,t){this._loadStatusMap.set(e,t);var n=!0,o=[],s=!0,r=!1,a=void 0;try{for(var i,l=this._loadStatusMap[Symbol.iterator]();!(s=(i=l.next()).done);s=!0){var u=p(i.value,2),c=(u[0],u[1]);c?c.status||o.push(c):n=!1}}catch(e){r=!0,a=e}finally{try{s||null==l.return||l.return()}finally{if(r)throw a}}n&&(0==o.length?this._loadStatusCallback({status:!0}):this._loadStatusCallback({status:!1,errorStatusList:o}))}},{key:"initialize",value:function(e){if(e.coreExtensionList){this._loadStatusCallback=e.statusCallback;var t=!0,n=!1,o=void 0;try{for(var s,r=e.coreExtensionList[Symbol.iterator]();!(t=(s=r.next()).done);t=!0){var a=s.value;this._loadStatusMap.set(a.id,{status:"undefined"}),this.loadCoreExtension(a)}}catch(e){n=!0,o=e}finally{try{t||null==r.return||r.return()}finally{if(n)throw o}}}}},{key:"handleMessage",value:function(e){var t=this;if("JSCore"==e.targetType)return this.handleMessageForJSCore(e);if("Host"==e.targetType)return this.sendMessageToHost(e);if("Parent"==e.targetType)return this.sendMessageToAppletParent(e);if("*"==e.targetID)this.broadcastMessage(e);else{if("CoreExt"==e.targetType)return this.sendMessageToCoreExt(e);if("Applet"==e.targetType)return this.sendMessageToApplet(e);if(this._moduleRoleMap.has(e.targetType)){if(null!=e.isAsync&&!e.isAsync)return this._moduleRoleMap.get(e.targetType).handleMessage(e);setTimeout(function(){t._moduleRoleMap.get(e.targetType).handleMessage(e)},0)}else this.sendMessageToHost(e)}return!0}},{key:"handleMessageForJSCore",value:function(e){var t=e.message;if("LoadModule"==t){var n=new g(e.data,e.sourceID,e.sourceVersion,e.sourceInstanceID,this._ccxCoreObj);return this.loadModule(n,e.data),!0}if("RegisterModule"==t){var o=new g(e.data,e.sourceID,e.sourceVersion,e.sourceInstanceID,this._ccxCoreObj);return e.data.dictionary=e.data.dictionary?e.data.dictionary:null,!!o.register(e.data.moduleObject,e.data,e.data.dictionary)&&(this._loadedModules.set(o._id,o),o._role&&this._moduleRoleMap.set(o._role,o),this._registerModuleWithNativeCore(o),!0)}if("UnloadModule"==t||"UnregisterModule"==t)return!this._loadedModules.has(e.data.id)||this._loadedModules.delete(e.data.id)}},{key:"loadModule",value:function(e,t){this._loadingModules.set(e._id,e),e.load(t,function(n){if(this._loadingModules.delete(e._id),n.status&&(this._loadedModules.set(e._id,e),e._role&&this._moduleRoleMap.set(e._role,e),this._registerModuleWithNativeCore(e)),t.statusCallback){if("function"==typeof t.statusCallback)try{t.statusCallback(n)}catch(e){i.error("CoreMessageManager: Exception in onLoad callback: ",e)}else if("string"==typeof t.statusCallback)try{this.sendMessageToHost({targetType:"Host",message:t.statusCallback,data:n})}catch(e){i.error("CoreMessageManager: Exception in onLoad callback: ",e)}}else i.warn("CoreMessageManager: onLoad callback not present.")}.bind(this))}},{key:"loadCoreExtension",value:function(e){var t=new g(e,"","","",this._ccxCoreObj);this._loadingModules.set(t._id,t),t.load({},function(e){this._loadingModules.delete(t._id),e.status&&this._loadedCoreExtensions.set(t._id,t),this.statusCallback(t._id,e)}.bind(this))}},{key:"_registerModuleWithNativeCore",value:function(e){this._ccxCoreObj._hostMessageHandlerFn({targetType:"Core",message:"RegisterApplet",data:{type:e._type,id:e._id,version:e._version,instanceID:e._instanceID,path:e._path}})}},{key:"sendMessageToHost",value:function(e){var t=this;return null!=e.isInterCoreMsg&&e.isInterCoreMsg?i.warn("CoreMessageManager: Not sending interCoreMsg back to host. Message: ",e):(e.isInterCoreMsg=!0,setTimeout(function(){t._ccxCoreObj._hostMessageHandlerFn(e)},0)),!0}},{key:"sendMessageToAppletParent",value:function(e){var t=this,n=this._loadedModules.get(e.sourceID).getParent();if(n){if(this._loadedModules.has(n)){if(null!=e.isAsync&&!e.isAsync)return this._loadedModules.get(n).handleMessage(e);setTimeout(function(){t._loadedModules.get(n).handleMessage(e)},0)}}else this.sendMessageToHost(e);return!0}},{key:"broadcastMessage",value:function(e){if("CoreExt"==e.targetType||"*"==e.targetType||"**"==e.targetType){var t=!0,n=!1,o=void 0;try{for(var s,r=function(){var t=p(s.value,2),n=t[0],o=t[1];n!==e.sourceID&&setTimeout(function(){o.handleMessage(e)},0)},a=this._loadedCoreExtensions[Symbol.iterator]();!(t=(s=a.next()).done);t=!0)r()}catch(e){n=!0,o=e}finally{try{t||null==a.return||a.return()}finally{if(n)throw o}}}if("Applet"==e.targetType||"*"==e.targetType||"**"==e.targetType){var i=!0,l=!1,u=void 0;try{for(var c,d=function(){var t=p(c.value,2),n=t[0],o=t[1];n!==e.sourceID&&setTimeout(function(){o.handleMessage(e)},0)},h=this._loadedModules[Symbol.iterator]();!(i=(c=h.next()).done);i=!0)d()}catch(e){l=!0,u=e}finally{try{i||null==h.return||h.return()}finally{if(l)throw u}}}"Remote"!=e.targetType&&"**"!=e.targetType||this.sendMessageToHost(e)}},{key:"sendMessageToCoreExt",value:function(e){var t=this;if(this._loadedCoreExtensions.has(e.targetID)){if(null!=e.isAsync&&!e.isAsync)return this._loadedCoreExtensions.get(e.targetID).handleMessage(e);setTimeout(function(){t._loadedCoreExtensions.get(e.targetID).handleMessage(e)},0)}else this._loadingModules.has(e.targetID)?i.error("CoreMessageManager: Cannot send message to CoreExt during loading state. Message: ",e):this.sendMessageToHost(e);return!0}},{key:"sendMessageToApplet",value:function(e){var t=this;if(this._loadedModules.has(e.targetID)){if(null!=e.isAsync&&!e.isAsync)return this._loadedModules.get(e.targetID).handleMessage(e);setTimeout(function(){t._loadedModules.get(e.targetID).handleMessage(e)},0)}else this._loadingModules.has(e.targetID)?i.error("CoreMessageManager: Cannot send message to Applet during loading state. Message: ",e):this.sendMessageToHost(e);return!0}}])&&f(t.prototype,n),o&&f(t,o),e}();function M(e){return(M="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e})(e)}function b(e,t){for(var n=0;n<t.length;n++){var o=t[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(e,o.key,o)}}function v(e,t,n){return(v="undefined"!=typeof Reflect&&Reflect.get?Reflect.get:function(e,t,n){var o=function(e,t){for(;!Object.prototype.hasOwnProperty.call(e,t)&&null!==(e=_(e)););return e}(e,t);if(o){var s=Object.getOwnPropertyDescriptor(o,t);return s.get?s.get.call(n):s.value}})(e,t,n||e)}function _(e){return(_=Object.setPrototypeOf?Object.getPrototypeOf:function(e){return e.__proto__||Object.getPrototypeOf(e)})(e)}function w(e,t){return(w=Object.setPrototypeOf||function(e,t){return e.__proto__=t,e})(e,t)}function m(e){if(void 0===e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return e}n.d(t,"default",function(){return O});var O=function(e){function t(){var e,n,o;return function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,t),n=this,e=!(o=_(t).call(this))||"object"!==M(o)&&"function"!=typeof o?m(n):o,i.info("JS Module load: Core: version: 1.0.47"),e._coreMessageManager=new y(m(m(e))),e._hostMessageHandlerFn=function(e){i.warn("Core: Host message handler found missing while sending message: ",e)},e}var n,o,s;return function(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function");e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,writable:!0,configurable:!0}}),t&&w(e,t)}(t,r),n=t,(o=[{key:"initialize",value:function(e){return v(_(t.prototype),"initialize",this).call(this,e),this._coreMessageManager.initialize(e)}},{key:"handleMessage",value:function(e){return this._coreMessageManager.handleMessage(e)}},{key:"finalize",value:function(e){v(_(t.prototype),"finalize",this).call(this,dataJSON)}}])&&b(n.prototype,o),s&&b(n,s),t}();window.CCXCore=function(){return new O}}]);