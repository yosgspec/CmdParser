/*************************************************
 【コマンドラインパーサ】CmdParser
                                   by.YOS G-spec
**************************************************/
using System;
using System.Collections.Generic;
using System.Linq;

namespace CmdParsers{
/// <summary>
/// 非常にシンプルなコマンドラインパーサ
/// </summary>
class CmdParser{
	/// <summary>
	/// コマンドラインオプションの有無
	/// コマンドラインオプションがデフォルト(空)の場合はtrueを返します。
	/// </summary>
	public readonly bool isDefault=false;

	/// <summary>
	/// キーの指定がない既定のオプションのリスト
	/// </summary>
	public readonly List<string> args;

	/// <summary>
	/// フラグオプション有無の辞書
	/// </summary>
	public readonly Dictionary<string,bool> flgs;

	/// <summary>
	/// オプションとオプション引数と紐づけた辞書
	/// </summary>
	public readonly Dictionary<string,string> opts;

	/// <summary>
	/// コマンドライン引数の分割・解析を行うCmdParserクラスのコンストラクタ。
	///
	/// 引数flgKeys, optKeysにはオプションとして設定したい文字列を含む配列を与えます。
    ///
	/// オプションの種類は2種類あり、フラグオプションの物と引数付きオプションの2種類が選択できます。
    ///
	/// フラグオプション : オプションが含まれるだけで効力を持つ
	/// 例: hsp.exe --help
    ///
	/// 引数付きオプション : オプションと値を与える必要がある
	/// 例: hsp.exe --lang ja
    ///
	/// コマンドラインで使用できるオプションの形式はロングオプション(--○○○○)とショートオプション(-○)の2タイプがあります。
    ///
	/// ロングオプションはflgKeysとoptKeysの文字列配列により設定されます。
	/// キーの重複があった場合はフラグオプションが優先されます。
    ///
	/// ショートオプションはロングオプションの頭文字を取り自動で設定されます。
	/// 頭文字の重複があった場合は配列順で先に出現した1つだけにショートオプションが設定されます。
	///
	/// 解析した結果はCmdParser.args, CmdParser.flgs, CmdParser.optsによって取得します。
	/// <param name="flgKeys">フラグオプションに設定したいキーの配列</param>
	/// <param name="optKeys">引数付きオプションに設定したいキーの配列</param>
	/// </summary>
	public CmdParser(string[] flgKeys=null,string[] optKeys=null){
		flgKeys ??= new string[]{};
		optKeys ??= new string[]{};
		this.args=new List<string>{};
		this.flgs=flgKeys.ToDictionary(key=>key,_=>false);
		this.opts=new Dictionary<string,string>{};

		const int rtCount=1;
		string[] args=Environment.GetCommandLineArgs();
		if(args.Length<=rtCount){
			this.isDefault=true;
			return;
		}
		for(int i=rtCount;i<args.Length;i++){
			var arg=args[i];
			foreach(var key in flgKeys){
				if(arg=="-"+key[0] || arg=="--"+key){
					this.flgs[key]=true;
					goto cmdnext;
				}
			}
			foreach(var key in optKeys){
				if(arg=="-"+key[0] || arg=="--"+key){
					i++;
					if(this.opts.ContainsKey(key))
						throw new FormatException($"オプション「--{key}」が複数入力されています。");
					if(args.Length<=i)
						throw new FormatException($"オプション「--{key}」に対応する値が入力されていません。");
					this.opts.Add(key,args[i]);
					goto cmdnext;
				}
			}
			if(arg[0]=='-' && !double.TryParse(arg,out _)) throw new FormatException($"オプション「{arg}」は定義されていません。");
			this.args.Add(arg);
			cmdnext:;
		}
	}
}
}
