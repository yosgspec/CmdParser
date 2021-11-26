//CmdParserのテスト
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Text.Encodings.Web;
using System.Text.Unicode;
using CmdParsers;

class Program{
	static void Main(){
		CmdParser cmd;
		try{
			cmd=new CmdParser(new[]{"help","version"},new[]{"alpha","beta","gamma","alpaca"});
		}
		catch(Exception ex){
			Console.WriteLine($@"{{""csharp"":{{""{ex.GetType()}"":""{ex.Message}""}}}}");
			return;
		}
		if(cmd.isDefault){
			Console.WriteLine(@"{""csharp"":""デフォルトオプションで実行しています。""}");
			return;
		}
		var jso=new JsonSerializerOptions{
			Encoder=JavaScriptEncoder.Create(UnicodeRanges.All)
		};
		Console.WriteLine(@"{{""csharp"":{{""args"":{0},""flgs"":{1},""opts"":{2}}}}}",
			JsonSerializer.Serialize(cmd.args,jso).Replace(@"\u3000","　"),
			JsonSerializer.Serialize(cmd.flgs,jso).Replace(@"\u3000","　"),
			JsonSerializer.Serialize(cmd.opts,jso).Replace(@"\u3000","　"));
	}
}
