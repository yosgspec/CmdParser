;--------------------------------------------------
; 【コマンドラインパーサ】CmdParser
;                                   by.YOS G-spec
;--------------------------------------------------
/*
%dll
CmdParser

%ver
3.6

%date
2021/11/25

%author
YOS G-spec

%url
https://github.com/yosgspec/CmdParser

%note
非常にシンプルなコマンドラインパーサ。
CmdParser.asをインクルードすること。
別途Dictionary.asが必要。

%type
ユーザー定義命令/関数

%port
Win
Mac
Cli
HSP3Dish

%group
コマンドラインパーサ
%*/

#include "Dictionary.as"

#ifndef CmdParser

/*
%index
#define CmdParserAliasOff
CmdParserモジュールのエイリアスを無効化

%inst
CmdParserモジュールのインクルード前に宣言するとcmdから始まる定義を全て無効化します。
その場合次の対応に従って命令/関数を呼び出す必要があります。

エイリアス    : 実際の命令/関数名
--------------:-----------------------
cmdIsDefault  : isDefault@CmdParser
cmdArgsLength : argsLength@CmdParser
cmdRefArgs    : refArgs@CmdParser
cmdRefFlgs    : refFlgs@CmdParser
cmdRefOpts    : refOpts@CmdParser
cmdRef        : ref@CmdParser
cmdRefArray   : refArray@CmdParser

%href
new@CmdParser
cmdIsDefault
cmdArgsLength
cmdRefArgs
cmdRefFlgs
cmdRefOpts
cmdRef
cmdRefArray
%*/
#ifndef CmdParserAliasOff
	#define global cmdIsDefault isDefault@CmdParser
	#define global cmdArgsLength argsLength@CmdParser
	#define global cmdRefArgs refArgs@CmdParser
	#define global cmdRefFlgs refFlgs@CmdParser
	#define global cmdRefOpts refOpts@CmdParser
	#define global cmdRef ref@CmdParser
	#define global cmdRefArray refArray@CmdParser
#endif

typeMod@CmdParser=vartype("struct")
typeStr@CmdParser=vartype("str")
typeLbl@CmdParser=vartype("label")
ldim defaultFlgKeys@CmdParser,0
ldim defaultOptKeys@CmdParser,0
ldim defaultArgs@CmdParser,0
ldim defaultOpts@CmdParser,0
ldim defaultFlgs@CmdParser,0
#module CmdParser __isDefault,__argsLength,__args,__flgs,__opts

/*
%index
cmdRefArray
コマンドライン文字列の配列を取得

%prm
cmdAry
cmdAry : 分割したコマンドラインを返す配列変数(文字列型)

%inst
コマンドライン文字列dir_cmdlineを分割した配列を取得します。

#define CmdParserAliasOffを使用した場合は、本命令は使用できなくなり、代わりにrefArray@CmdParserを使用します。

%href
dir_cmdline
#define CmdParserAliasOff
%*/
	#define refArray(%1) sdim %1: __refArray@CmdParser %1
	#deffunc local __refArray array args
		cmd=dir_cmdline
		cmd=strtrim(cmd,,' ')
		wquot="&quot;"
		while 0<=instr(cmd,,wquot): wquot+=";": wend
		space="&nbsp;"
		while 0<=instr(cmd,,space): space+=";": wend
		wspace=space+space
		strrep cmd,"\\\"",wquot

		sdim wqbreaks
		split cmd,"\"",wqbreaks
		cmd=""
		foreach wqbreaks
			if cnt\2=0 {
				strrep wqbreaks(cnt),"\t",space
				strrep wqbreaks(cnt)," ",space
				while 0<=instr(wqbreaks(cnt),,wspace)
					strrep wqbreaks(cnt),wspace,space
				wend
			}
			cmd+=wqbreaks(cnt)
		loop
		strrep cmd,wquot,"\""
		split cmd,space,args
	return

/*
%index
cmdIsDefault
コマンドラインオプションの有無

%prm
(cmd)
val : オプションの有無(1または0)
cmd : CmdParserのモジュール型変数

%inst
コマンドラインオプションがデフォルト(空)の場合は1を返します。

#define CmdParserAliasOffを使用した場合は、本関数は使用できなくなり、代わりにisDafault@CmdParserを使用します。

%href
new@CmdParser
cmdRefArray
cmdRef
cmdRefArgs
cmdRefFlgs
cmdRefOpts
#define CmdParserAliasOff
%*/
	#modcfunc local isDefault
		return __isDefault

/*
%index
cmdArgsLength
既定のオプションの配列の長さ

%prm
(cmd)
val : 配列の長さ(整数)
cmd : CmdParserのモジュール型変数

%inst
cmdRefArgs及びcmdRefで取得できるキー指定のない既定のオプションの配列(args)の長さを取得します。
length関数との違いはargsが空の時に0を返すことです。

#define CmdParserAliasOffを使用した場合は、本関数は使用できなくなり、代わりにargsLength@CmdParserを使用します。

%href
new@CmdParser
cmdRef
cmdRefArgs
#define CmdParserAliasOff
%*/
	#modcfunc local argsLength
		return __argsLength

/*
%index
cmdRefArgs
既定のオプションの配列を取得

%prm
cmd, args
cmd  : CmdParserのモジュール型変数
args : 既定のオプションの配列(文字列または未定義のラベル)

%inst
キーの指定がない既定のオプションの配列を取得します。
与えられた既定のオプションが存在しなかった場合は未定義のラベル型の変数となっています。
そのまま処理をしようとした場合エラーとなりますので注意してください。

#define CmdParserAliasOffを使用した場合は、本命令は使用できなくなり、代わりにrefArgs@CmdParserを使用します。

%href
new@CmdParser
cmdRefArray
cmdRef
cmdRefArgsLength
cmdRefFlgs
cmdRefOpts
#define CmdParserAliasOff
%*/
	#define refArgs(%1,%2) sdim %2: __refArgs@CmdParser %1,%2
	#modfunc local __refArgs array _args
		foreach __args: _args.cnt=__args.cnt: loop: return

/*
%index
cmdRefFlgs
フラグオプションの辞書を取得

%prm
cmd, flgs
cmd  : CmdParserのモジュール型変数
flgs : フラグオプションの辞書(Dictionary(1または0))

%inst
フラグオプションの有無を1または0の整数で表現した辞書を取得します。

#define CmdParserAliasOffを使用した場合は、本命令は使用できなくなり、代わりにrefFlgs@CmdParserを使用します。

%href
new@CmdParser
cmdRefArray
cmdRef
cmdRefArgs
cmdRefOpts
#define CmdParserAliasOff
dcItem
%*/
	#define refFlgs(%1,%2) dimtype %2,typeMod@CmdParser: __refFlgs@CmdParser %1,%2
	#modfunc local __refFlgs var _flgs
		_flgs=__flgs: return

/*
%index
cmdRefOpts
引数付きオプションの辞書を取得

%prm
cmd, flgs
cmd  : CmdParserのモジュール型変数
opts : 引数付きオプションの辞書(Dictionary(文字列))

%inst
オプションとオプション引数と紐づけた辞書を取得します。
コマンドライン引数が与えられた時に指定されていないオプションは辞書に存在しないことに注意してください。
オプションの有無はdcContainsKeyで確認できます。

#define CmdParserAliasOffを使用した場合は、本命令は使用できなくなり、代わりにrefOpts@CmdParserを使用します。

%href
new@CmdParser
cmdRefArray
cmdRef
cmdRefArgs
cmdRefFlgs
#define CmdParserAliasOff
dcItem
dcContainsKey
%*/
	#define refOpts(%1,%2) dimtype %2,typeMod@CmdParser: __refOpts@CmdParser %1,%2
	#modfunc local __refOpts var _opts
		_opts=__opts: return

/*
%index
cmdRef
パースしたコマンドラインをまとめて取得

%prm
cmd, args, flgs, opts
cmd  : CmdParserのモジュール型変数
args : 既定のオプションの配列(文字列)[省略可]
flgs : フラグオプションの辞書(Dictionary(1または0))[省略可]
opts : 引数付きオプションの辞書(Dictionary(文字列))[省略可]

%inst
cmdRefArgs, cmdRefFlgs, cmdRefOptsで取得する配列と辞書を一括で取得できます。
詳細はそれぞれの命令を参照してください。

#define CmdParserAliasOffを使用した場合は、本命令は使用できなくなり、代わりにrefOpts@CmdParserを使用します。

%href
new@CmdParser
cmdRefArray
cmdRefArgs
cmdRefFlgs
cmdRefOpts
#define CmdParserAliasOff
%*/
	#define ref(%1,%2=defaultArgs@CmdParser,%3=defaultFlgs@CmdParser,%4=defaultOpts@CmdParser) \
		sdim %2 :\
		if typeLbl@CmdParser!=vartype(%2){__refArgs@cmdParser %1,%2}\
		dimtype %3,typeMod@CmdParser :\
		if typeLbl@CmdParser!=vartype(%3){__refFlgs@cmdParser %1,%3}\
		dimtype %4,typeMod@CmdParser :\
		if typeLbl@CmdParser!=vartype(%4){__refOpts@cmdParser %1,%4}

/*
%index
new@CmdParser
コマンドライン引数を分割・解析

%prm
cmd, flgKeyss, optKeys
cmd  : CmdParserのモジュール型変数に設定する変数
flgKeys : フラグオプションに設定したいキーの配列(文字列)[省略可]
optKeys : 引数付きオプションに設定したいキーの配列(文字列)[省略可]

%inst
コマンドライン引数の分割・解析を行うCmdParserモジュールを初期化します。
(CmdPerserモジュールコンストラクタ)

引数cmdに配列を与える場合は配列変数が破棄されますので注意してください。
引数flgKeys, optKeysにはオプションとして設定したい文字列を含む配列を与えます。

不適切なオプションが与えられた場合はrefstrにメッセージを返します。
(正常な場合は空の文字列が返ります)

与えるオプションはフラグオプションの物と引数付きオプションの2種類が選択できます。

フラグオプション : オプションが含まれるだけで効力を持つ
例: cmdhsp --help

引数付きオプション : オプションと値を与える必要がある
例: cmdhsp --lang ja

コマンドラインで使用できるオプションの形式はロングオプション(--○○○○)とショートオプション(-○)の2タイプがあります。

ロングオプションはflgKeysとoptKeysの文字列配列により設定されます。
キーの重複があった場合はフラグオプションが優先されます。

ショートオプションはロングオプションの頭文字を取り自動で設定されます。
頭文字の重複があった場合は配列順で先に出現した1つだけにショートオプションが設定されます。

また、ショートオプションは連ねて複合させることもできます。
その場合、引数を指定できるのは一番最後のオプションに限ります。
例: cmdhsp -vhl ja ⇒ cmdhsp -v -h -l ja

解析した結果はcmdRefArgs, cmdRefFlgs, cmdRefOpts, cmdRefなどの命令によって取得します。

%href
dir_cmdline
cmdRefArray
cmdIsDefault
cmdArgsLength
cmdRefArgs
cmdRefFlgs
cmdRefOpts
cmdRef
#define CmdParserAliasOff
%*/
	#define new(%1,%2=defaultFlgKeys@CmdParser,%3=defaultOptKeys@CmdParser) \
		dimtype %1,typeMod@CmdParser: newmod %1,CmdParser,%2,%3
	#modinit array flgKeys,array optKeys
		__argsLength=0
		ldim __args,0
		new@Dictionary __flgs,"int"
		if typeStr=vartype(flgKeys) {
			foreach flgKeys: add@Dictionary __flgs,flgKeys.cnt,0: loop}
		new@Dictionary __opts,"str"

		errMes=""
		rtCount=0
		refArray inputArgs
		if length(inputArgs)=1 & inputArgs="" {
			__isDefault=1
			return errMes
		}

		#define ctype strNumChk(%1) (0=(0.0=%1 & "-0"!=strmid(%1,0,2)))
		ldim args,0
		repeat length(inputArgs),rtCount
			arg=inputArgs.cnt
			if 2<strlen(arg) {
			if "--"!=strmid(arg,0,2) {
			if "-"=strmid(arg,0,1) {
			if 0=strNumChk(arg) {
				repeat strlen(arg)-1,1
					if typeLbl=vartype(args): last=0: else: last=length(args)
					args(last)="-"+strmid(arg,cnt,1)
				loop
				continue
			}}}}
			if typeLbl=vartype(args): last=0: else: last=length(args)
			args(last)=arg
		loop

		hasflgKeys=typeStr=vartype(flgKeys)
		hasOptKeys=typeStr=vartype(optKeys)
		i=0
		repeat:if length(args)<=i: break
			arg=args(i)
			if typeStr=vartype(flgKeys) {
				for n,,length(flgKeys)
					key=flgKeys(n)
					if arg="-"+strmid(key,0,1) | arg="--"+key {
						set@Dictionary __flgs,key,1
						i++:continue
					}
				next
			}
			if hasOptKeys {
				for n,,length(optKeys)
					key=optKeys(n)
					if arg="-"+strmid(key,0,1) | arg="--"+key {
						i++
						if containsKey@Dictionary(__opts,key) {
							errMes=strf("オプション「--%s」が複数入力されています。",key)
							break
						}
						if length(args)<=i {
							errMes=strf("オプション「--%s」に対応する値が入力されていません。",key)
							break
						}
						add@Dictionary __opts,key,args(i)
						i++:continue
					}
				next
			}
			if strmid(arg,0,1)="-":if 0=strNumChk(arg) {
				errMes=strf("オプション「%s」は定義されていません。",arg)
				break
			}
			__args(__argsLength)=arg
			__argsLength++
			i++
		loop
	return errMes
#global
#endif
