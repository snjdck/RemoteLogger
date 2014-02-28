package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	
	import snjdck.logger.DebuggerServer;
	
	[SWF(width=800, height=600)]
	public class RemoteLogger extends Sprite
	{
		private var connection:DebuggerServer;
		private var htmlView:HTMLLoader;
		
		private var isPageLoaded:Boolean;
		
		public function RemoteLogger()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			connection = new DebuggerServer("_jyzy");
			connection.regHandler("log", log);
			
			htmlView = new HTMLLoader();
			htmlView.addEventListener(Event.COMPLETE, __onLoad);
			addChild(htmlView);
			
			stage.addEventListener(Event.RESIZE, __onResize);
			__onResize(null);
			
			htmlView.load(new URLRequest("html/index.html"));
		}
		
		private function __onResize(evt:Event):void
		{
			htmlView.width = stage.stageWidth;
			htmlView.height = stage.stageHeight;
		}
		
		private function getElementById(id:String):Object
		{
			return htmlView.window.document.getElementById(id);
		}
		
		private function __onLoad(evt:Event):void
		{
			isPageLoaded = true;
			var btnCopy:Object = getElementById("btnCopy");
			btnCopy.onclick = onCopy;
		}
		
		private function log(...args):void
		{
			if(false == isPageLoaded){
				return;
			}
			var loggerId:String = args[0];
			var level:int = args[1];
			var section:String = args[2];
			var message:String = args[3];
			
			var output:String = "";
			output += loggerId ? ("[" + loggerId + "]") : "";
			output += "[" + section + "]";
			output += "[" + LoggerLevel.FromCode(level) + "]";
			output += message + "<br/>";
			
			htmlView.window.appendLog(loggerId, level.toString(), section, output);
		}
		
		private function onCopy(evt:Object):void
		{
			var panel:Object = getElementById("panel");
			System.setClipboard(panel.innerHTML);
		}
	}
}