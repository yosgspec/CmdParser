/*************************************************
 【コマンドラインパーサ】CmdParser
							by.YOS G-spec
**************************************************/
"use strict";

/**
 * 非常にシンプルなコマンドラインパーサ
 */
export class CmdParser{
	/**
	 * コマンドラインオプションの有無
	 * コマンドラインオプションがデフォルト(空)の場合はtrueを返します。
	 */
	public readonly isDefault:boolean=false;

	/**
	 * キーの指定がない既定のオプションのリスト
	 */
	public readonly args:string[];

	/**
	 * フラグオプション有無の辞書
	 */
	public readonly flgs:Map<string,boolean>;

	/**
	 * オプションとオプション引数と紐づけた辞書
	 */
	public readonly opts:Map<string,string>;

	/**
	 * コマンドライン引数の分割・解析を行うCmdParserクラスのコンストラクタ。
	 *
	 * 引数flgKeys, optKeysにはオプションとして設定したい文字列を含む配列を与えます。
	 *
	 * オプションの種類は2種類あり、フラグオプションの物と引数付きオプションの2種類が選択できます。
	 *
	 * フラグオプション : オプションが含まれるだけで効力を持つ
	 * 例: hsp.exe --help
	 *
	 * 引数付きオプション : オプションと値を与える必要がある
	 * 例: hsp.exe --lang ja
	 *
	 * コマンドラインで使用できるオプションの形式はロングオプション(--○○○○)とショートオプション(-○)の2タイプがあります。
	 *
	 * ロングオプションはflgKeysとoptKeysの文字列配列により設定されます。
	 * キーの重複があった場合はフラグオプションが優先されます。
	 *
	 * ショートオプションはロングオプションの頭文字を取り自動で設定されます。
	 * 頭文字の重複があった場合は配列順で先に出現した1つだけにショートオプションが設定されます。
	 *
	 * 解析した結果はCmdParser.args, CmdParser.flgs, CmdParser.optsによって取得します。
	 * @param flgKeys - フラグオプションに設定したいキーの配列
	 * @param optKeys - 引数付きオプションに設定したいキーの配列
	 */
	constructor(flgKeys?:string[],optKeys?:string[]){
		flgKeys ||= [];
		optKeys ||= [];
		this.args=[];
		this.flgs=new Map<string,boolean>(flgKeys.map(key=>[key,false]));
		this.opts=new Map<string,string>();

		const rtCount:number=2;
		const args=process.argv;
		if(args.length<=rtCount){
			this.isDefault=true;
			return;
		}
		cmdnext:
		for(let i=rtCount;i<args.length;i++){
			let arg=args[i];
			for(let key of flgKeys){
				if(arg=="-"+key[0] || arg=="--"+key){
					this.flgs.set(key,true)
					continue cmdnext;
				}
			}
			for(let key of optKeys){
				if(arg=="-"+key[0] || arg=="--"+key){
					i++;
					if(this.opts.has(key))
						throw new SyntaxError(`オプション「--${key}」が複数入力されています。`);
					if(args.length<=i)
						throw new SyntaxError(`オプション「--${key}」に対応する値が入力されていません。`);
					this.opts.set(key,args[i]);
					continue cmdnext;
				}
			}
			if(arg[0]=="-" && !Number.isFinite(+arg)) throw new SyntaxError(`オプション「${arg}」は定義されていません。`);
			this.args.push(arg);
		}
	}
}
