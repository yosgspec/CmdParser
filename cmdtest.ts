"use strict";
import {CmdParser} from "./CmdParser";

(function(){
	var cmd:CmdParser;
	try{
		cmd=new CmdParser(["help","version"],["alpha","beta","gamma","alpaca"]);
	}
	catch(ex){
		console.log(`{"nodejs":{"${ex.name}":"${ex.message}"}}`);
		return;
	}
	if(cmd.isDefault){
		console.log('{"nodejs":"デフォルトオプションで実行しています。"}');
		return;
	}
	console.log('{"nodejs":{"args":%s,"flgs":%s,"opts":%s}}',
		JSON.stringify(cmd.args),
		JSON.stringify(Object.fromEntries([...cmd.flgs])),
		JSON.stringify(Object.fromEntries([...cmd.opts])));
})();
