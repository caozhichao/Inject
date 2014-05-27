package game.view.base
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import game.view.base.util.SingleManager;

	/**
	 * 单例注入   此类必须实现ISingle接口
	 * 
	 * 格式说明
	 * [Inject]
	 * public var single:Single
	 * 
	 * 实例由SingleManager统一创建,不可手动new创建，在这里实际上是伪单例实现
	 * @author caozc
	 * @version 1.0.0
	 * 创建时间：2014-5-8 上午11:49:40
	 * 
	 */
	public class Inject
	{
		//缓存Object xml
		private static var _xmlDic:Dictionary = new Dictionary();
		public function Inject()
		{
			inject(this);
		}
		public function inject(target:Object):void
		{
			var className:String = getQualifiedClassName(target);
//			trace("解析:" + className);
			var xml:XML;
			xml = _xmlDic[className];
			if(xml == null)
			{
				xml = describeType(target);
				_xmlDic[className] = xml;
			}
			var variables : XMLList = xml.child("variable");
			var name:String;
			var type:String;
			var single:ISingle;
			for each(var item:XML in variables)
			{
				if(item && item != "")
				{//release 版 xml 信息为空
					name = item.@name;
					if(item.child("metadata")[0].@name == "Inject")
					{
						type = item.@type;
						single = SingleManager.getInstanceByQualifiedClassName(type);
						target[name] = single;
					}
				}
			}
		}
	}
}