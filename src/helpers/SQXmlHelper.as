package helpers {

	import flash.xml.XMLDocument;
	
	public class SQXmlHelper
	{
		public static function isSimpleType(obj:Object):Boolean
		{
			return (obj is String) ||
				(obj is int) ||
				(obj is uint) ||
				(obj is Number) ||
				(obj is Boolean);
		}
		
		public static function objectToXML(sourceObject:Object, rootNode:String = "root"):XML
		{
			var result:XML = <{rootNode}></{rootNode}>
			
			for (var field:String in sourceObject)
			{
				var value:* = sourceObject[field];
				var node:XML;
				if (isSimpleType(value))
				{
					node = <{field}>{value}</{field}>;
					result.appendChild(node);
				}
				else
				{
					node = objectToXML(value, field);
					result.appendChild(node);
				}
			}
			
			return result;
		}
	}
}

