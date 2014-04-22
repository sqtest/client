package field
{
	public class SQTemplates
	{
		public static var templates : Object = new Object;
		
		public static function addTemplates(xml: XMLList) : void
		{
			for (var i:int=0; i<xml.result.children().length(); i++){
				var node : XML = xml.result.children()[i];
				SQTemplates.templates[node.name()] = {
					price_coins : node.@price_coins,
					price_population : node.@price_population,
					price_power : node.@price_power,
					autotask: node.@autotask
				}
			}
		}
	}
}