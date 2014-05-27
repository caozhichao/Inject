package game.view.base.util
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import game.view.base.ISingle;

	/**
	 * 
	 * @author caozc
	 * 
	 */	
	public class SingleManager
	{
		private var _dic:Dictionary;
		private static var _instance:SingleManager = new SingleManager();
		
		public function SingleManager()
		{
			if(_instance)
			{
				throw new Error("无法实例化...");
			}
			_dic = new Dictionary();
		}
		
		private function getSingleInstanceByClass(cla:Class):ISingle
		{
			var single:ISingle = _dic[cla];
			if(single == null)
			{
				single = new cla();
				_dic[cla] = single;
			}
			return single;
		}
		
		private function removeInstanceByClass(cla:Class):void
		{
			delete _dic[cla];
		}
		
		/**
		 * 获取单例对象 
		 * @param cla
		 * @return 
		 * 
		 */		
		public static function getInstanceByClass(cla:Class):ISingle
		{
			return _instance.getSingleInstanceByClass(cla);
		}
		
		/**
		 * 获取一个单例对象根据该类的完全限定类名字非常 
		 * @param className
		 * @return 
		 * 
		 */		
		public static function getInstanceByQualifiedClassName(className:String):ISingle
		{
			var cla:Class = getDefinitionByName(className) as Class;
			return getInstanceByClass(cla);
		}
		
		
		/**
		 * 删除单例对象 
		 * @param cla
		 * 
		 */		
		public static function removeInstanceByClass(cla:Class):void
		{
			_instance.removeInstanceByClass(cla);
		}
	}
}
