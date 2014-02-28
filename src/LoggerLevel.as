package
{
	public class LoggerLevel
	{
		static public function FromCode(code:int):LoggerLevel
		{
			switch(code)
			{
				case INFO.code:
					return INFO;
				case WARNING.code:
					return WARNING;
				case ERROR.code:
					return ERROR;
				case FATAL.code:
					return FATAL;
			}
			return null;
		}
		
		public static const FATAL	:LoggerLevel = new LoggerLevel(1, "致命", 0xFF0000);
		public static const ERROR	:LoggerLevel = new LoggerLevel(2, "错误", 0x880000);
		public static const WARNING	:LoggerLevel = new LoggerLevel(3, "警告", 0x888800);
		public static const INFO	:LoggerLevel = new LoggerLevel(4, "信息", 0x000000);
		
		private var code:int;
		private var desc:String;
		private var color:uint;
		
		public function LoggerLevel(code:int, desc:String, color:uint)
		{
			this.code = code;
			this.desc = desc;
			this.color = color;
		}
		
		public function toString():String
		{
			return "<font color='#" + color.toString(16) + "'>" + desc + "</font>";
		}
	}
}