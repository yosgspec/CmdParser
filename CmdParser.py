#--------------------------------------------------
# 【コマンドラインパーサ】CmdParser
#                                   by.YOS G-spec
#--------------------------------------------------

"""非常にシンプルなコマンドラインパーサ
	* CmdParserクラス
"""

from typing import *
import sys

class CmdParser:
	"""非常にシンプルなコマンドラインパーサ
	
	コマンドライン引数の分割・解析を行います。
	
	引数flgKeys, optKeysにはオプションとして設定したい文字列を含む配列を与えます。
	
	オプションの種類は2種類あり、フラグオプションの物と引数付きオプションの2種類が選択できます。
	
	フラグオプション : オプションが含まれるだけで効力を持つ
	例: hsp.exe --help
	
	引数付きオプション : オプションと値を与える必要がある
	例: hsp.exe --lang ja
	
	コマンドラインで使用できるオプションの形式はロングオプション(--○○○○)とショートオプション(-○)の2タイプがあります。
	
	ロングオプションはflgKeysとoptKeysの文字列配列により設定されます。
	キーの重複があった場合はフラグオプションが優先されます。
	
	ショートオプションはロングオプションの頭文字を取り自動で設定されます。
	頭文字の重複があった場合は配列順で先に出現した1つだけにショートオプションが設定されます。
		
	解析した結果はCmdParser.args, CmdParser.flgs, CmdParser.optsによって取得します。
	
	Args:
		flgKeys: フラグオプションに設定したいキーの配列
		optKeys: 引数付きオプションに設定したいキーの配列
	"""

	@property
	def isDefault(self)->List[str]:
		"""コマンドラインオプションの有無
		コマンドラインオプションがデフォルト(空)の場合はtrueを返します。
		"""
		return self.__isDefault

	@property
	def args(self)->List[str]:
		"""キーの指定がない既定のオプションのリスト"""
		return self.__args
	@property
	def flgs(self)->Dict[str,bool]:
		"""フラグオプション有無の辞書"""
		return self.__flgs

	@property
	def opts(self)->Dict[str,str]:
		"""オプションとオプション引数と紐づけた辞書"""
		return self.__opts

	def __init__(self,flgKeys:List[str]=None,optKeys:List[str]=None):
		flgKeys=flgKeys if not flgKeys is None else []
		optKeys=optKeys if not optKeys is None else []
		self.__isDefault:bool=False
		self.__args:List[str]=[]
		self.__flgs:Dict[str,bool]={key: False for key in flgKeys}
		self.__opts:Dict[str,str]={}

		rtCount:int=1
		args=sys.argv
		if len(args)<=rtCount:
			self.__isDefault=True
			return
		i=rtCount
		while i<len(args):
			arg=args[i]
			for key in flgKeys:
				if arg=="-"+key[0] or arg=="--"+key:
					self.__flgs[key]=True
					break
			else:
				for key in optKeys:
					if arg=="-"+key[0] or arg=="--"+key:
						i+=1
						if key in self.__opts:
							raise ValueError(f"オプション「--{key}」が複数入力されています。")
						if len(args)<=i:
							raise ValueError(f"オプション「--{key}」に対応する値が入力されていません。")
						self.__opts[key]=args[i]
						break
				else:
					if arg[0]=="-":
						try: float(arg)
						except:
							raise ValueError(f"オプション「{arg}」は定義されていません。")
					self.__args.append(arg)
			i+=1
