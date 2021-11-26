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
	 *
	 * @remarks
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
	 * コマンドライン引数の分割・解析を行うパーサ。
	 *
	 * @remarks
	 * 引数flgKeys, optKeysにはオプションとして設定したい文字列を含む配列を与えます。
	 *
	 * 与えるオプションはフラグオプションの物と引数付きオプションの2種類が選択できます。
	 *
	 * フラグオプション : オプションが含まれるだけで効力を持つ
	 * 例: node cmd.js --help
	 *
	 * 引数付きオプション : オプションと値を与える必要がある
	 * 例: node cmd.js --lang ja
	 *
	 * コマンドラインで使用できるオプションの形式はロングオプション(--○○○○)とショートオプション(-○)の2タイプがあります。
	 *
	 * ロングオプションはflgKeysとoptKeysの文字列配列により設定されます。
	 * キーの重複があった場合はフラグオプションが優先されます。
	 *
	 * ショートオプションはロングオプションの頭文字を取り自動で設定されます。
	 * 頭文字の重複があった場合は配列順で先に出現した1つだけにショートオプションが設定されます。
	 *
	 * また、ショートオプションは連ねて複合させることもできます。
	 * その場合、引数を指定できるのは一番最後のオプションに限ります。
	 * 例: node cmd.js -vhl ja ⇒ node cmd.js -v -h -l ja
	 *
	 * 解析した結果はCmdParser.args, CmdParser.flgs, CmdParser.optsによって取得します。
	 * @param flgKeys - フラグオプションに設定したいキーの配列
	 * @param optKeys - 引数付きオプションに設定したいキーの配列
	 * @throws {TypeError} 不適切なコマンドラインオプションを与えられた場合に例外を返します。
	 */
	constructor(flgKeys?:string[],optKeys?:string[]){
		flgKeys=flgKeys ?? [];
		optKeys=optKeys ?? [];
		this.args=[];
		this.flgs=new Map<string,boolean>(flgKeys.map(key=>[key,false]));
		this.opts=new Map<string,string>();

		const rtCount:number=2;
		const inputArgs=process.argv;
		if(inputArgs.length<=rtCount){
			this.isDefault=true;
			return;
		}

		const args:string[]=[];
		for(let i=rtCount;i<inputArgs.length;i++){
			let arg=inputArgs[i];
			if(2<arg.length
			&& "--"!=arg.slice(0,2)
			&& "-"==arg[0]
			&& !Number.isFinite(+arg)){
				for(let s of arg.slice(1))
					args.push("-"+s);
				continue;
			}
			args.push(arg);
		}

		cmdnext:
		for(let i=0;i<args.length;i++){
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
						throw new TypeError(`オプション「--${key}」が複数入力されています。`);
					if(args.length<=i)
						throw new TypeError(`オプション「--${key}」に対応する値が入力されていません。`);
					this.opts.set(key,args[i]);
					continue cmdnext;
				}
			}
			if(arg[0]=="-" && !Number.isFinite(+arg)) throw new TypeError(`オプション「${arg}」は定義されていません。`);
			this.args.push(arg);
		}
	}
}
