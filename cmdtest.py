from typing import *
import sys
import json
from CmdParser import CmdParser

if __name__=="__main__":
	cmd:CmdParser
	try:
		cmd=CmdParser(["help","version"],["alpha","beta","gamma","alpaca"])
	except Exception as ex:
		print(f'{{"python":{{"{type(ex).__name__}":"{str(ex)}"}}}}')
		sys.exit()
	if cmd.isDefault:
		print('{"python":"デフォルトオプションで実行しています。"}')
		sys.exit()

	print('{"python":{"args":%s,"flgs":%s,"opts":%s}}'%(
		json.dumps(cmd.args,ensure_ascii=False,separators=(",",":")),
		json.dumps(cmd.flgs,ensure_ascii=False,separators=(",",":")),
		json.dumps(cmd.opts,ensure_ascii=False,separators=(",",":"))))
