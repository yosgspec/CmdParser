;--------------------------------------------------
; �y�R�}���h���C���p�[�T�zCmdParser
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
���ɃV���v���ȃR�}���h���C���p�[�T�B
CmdParser.as���C���N���[�h���邱�ƁB
�ʓrDictionary.as���K�v�B

%type
���[�U�[��`����/�֐�

%port
Win
Mac
Cli
HSP3Dish

%group
�R�}���h���C���p�[�T
%*/

#include "Dictionary.as"

#ifndef CmdParser

/*
%index
#define CmdParserAliasOff
CmdParser���W���[���̃G�C���A�X�𖳌���

%inst
CmdParser���W���[���̃C���N���[�h�O�ɐ錾�����cmd����n�܂��`��S�Ė��������܂��B
���̏ꍇ���̑Ή��ɏ]���Ė���/�֐����Ăяo���K�v������܂��B

�G�C���A�X    : ���ۂ̖���/�֐���
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
�R�}���h���C��������̔z����擾

%prm
cmdAry
cmdAry : ���������R�}���h���C����Ԃ��z��ϐ�(������^)

%inst
�R�}���h���C��������dir_cmdline�𕪊������z����擾���܂��B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refArray@CmdParser���g�p���܂��B

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
�R�}���h���C���I�v�V�����̗L��

%prm
(cmd)
val : �I�v�V�����̗L��(1�܂���0)
cmd : CmdParser�̃��W���[���^�ϐ�

%inst
�R�}���h���C���I�v�V�������f�t�H���g(��)�̏ꍇ��1��Ԃ��܂��B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����isDafault@CmdParser���g�p���܂��B

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
����̃I�v�V�����̔z��̒���

%prm
(cmd)
val : �z��̒���(����)
cmd : CmdParser�̃��W���[���^�ϐ�

%inst
cmdRefArgs�y��cmdRef�Ŏ擾�ł���L�[�w��̂Ȃ�����̃I�v�V�����̔z��(args)�̒������擾���܂��B
length�֐��Ƃ̈Ⴂ��args����̎���0��Ԃ����Ƃł��B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����argsLength@CmdParser���g�p���܂��B

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
����̃I�v�V�����̔z����擾

%prm
cmd, args
cmd  : CmdParser�̃��W���[���^�ϐ�
args : ����̃I�v�V�����̔z��(������܂��͖���`�̃��x��)

%inst
�L�[�̎w�肪�Ȃ�����̃I�v�V�����̔z����擾���܂��B
�^����ꂽ����̃I�v�V���������݂��Ȃ������ꍇ�͖���`�̃��x���^�̕ϐ��ƂȂ��Ă��܂��B
���̂܂܏��������悤�Ƃ����ꍇ�G���[�ƂȂ�܂��̂Œ��ӂ��Ă��������B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refArgs@CmdParser���g�p���܂��B

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
�t���O�I�v�V�����̎������擾

%prm
cmd, flgs
cmd  : CmdParser�̃��W���[���^�ϐ�
flgs : �t���O�I�v�V�����̎���(Dictionary(1�܂���0))

%inst
�t���O�I�v�V�����̗L����1�܂���0�̐����ŕ\�������������擾���܂��B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refFlgs@CmdParser���g�p���܂��B

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
�����t���I�v�V�����̎������擾

%prm
cmd, flgs
cmd  : CmdParser�̃��W���[���^�ϐ�
opts : �����t���I�v�V�����̎���(Dictionary(������))

%inst
�I�v�V�����ƃI�v�V���������ƕR�Â����������擾���܂��B
�R�}���h���C���������^����ꂽ���Ɏw�肳��Ă��Ȃ��I�v�V�����͎����ɑ��݂��Ȃ����Ƃɒ��ӂ��Ă��������B
�I�v�V�����̗L����dcContainsKey�Ŋm�F�ł��܂��B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refOpts@CmdParser���g�p���܂��B

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
�p�[�X�����R�}���h���C�����܂Ƃ߂Ď擾

%prm
cmd, args, flgs, opts
cmd  : CmdParser�̃��W���[���^�ϐ�
args : ����̃I�v�V�����̔z��(������)[�ȗ���]
flgs : �t���O�I�v�V�����̎���(Dictionary(1�܂���0))[�ȗ���]
opts : �����t���I�v�V�����̎���(Dictionary(������))[�ȗ���]

%inst
cmdRefArgs, cmdRefFlgs, cmdRefOpts�Ŏ擾����z��Ǝ������ꊇ�Ŏ擾�ł��܂��B
�ڍׂ͂��ꂼ��̖��߂��Q�Ƃ��Ă��������B

#define CmdParserAliasOff���g�p�����ꍇ�́A�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refOpts@CmdParser���g�p���܂��B

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
�R�}���h���C�������𕪊��E���

%prm
cmd, flgKeyss, optKeys
cmd  : CmdParser�̃��W���[���^�ϐ��ɐݒ肷��ϐ�
flgKeys : �t���O�I�v�V�����ɐݒ肵�����L�[�̔z��(������)[�ȗ���]
optKeys : �����t���I�v�V�����ɐݒ肵�����L�[�̔z��(������)[�ȗ���]

%inst
�R�}���h���C�������̕����E��͂��s��CmdParser���W���[�������������܂��B
(CmdPerser���W���[���R���X�g���N�^)

����cmd�ɔz���^����ꍇ�͔z��ϐ����j������܂��̂Œ��ӂ��Ă��������B
����flgKeys, optKeys�ɂ̓I�v�V�����Ƃ��Đݒ肵������������܂ޔz���^���܂��B

�s�K�؂ȃI�v�V�������^����ꂽ�ꍇ��refstr�Ƀ��b�Z�[�W��Ԃ��܂��B
(����ȏꍇ�͋�̕����񂪕Ԃ�܂�)

�^����I�v�V�����̓t���O�I�v�V�����̕��ƈ����t���I�v�V������2��ނ��I���ł��܂��B

�t���O�I�v�V���� : �I�v�V�������܂܂�邾���Ō��͂�����
��: cmdhsp --help

�����t���I�v�V���� : �I�v�V�����ƒl��^����K�v������
��: cmdhsp --lang ja

�R�}���h���C���Ŏg�p�ł���I�v�V�����̌`���̓����O�I�v�V����(--��������)�ƃV���[�g�I�v�V����(-��)��2�^�C�v������܂��B

�����O�I�v�V������flgKeys��optKeys�̕�����z��ɂ��ݒ肳��܂��B
�L�[�̏d�����������ꍇ�̓t���O�I�v�V�������D�悳��܂��B

�V���[�g�I�v�V�����̓����O�I�v�V�����̓���������莩���Őݒ肳��܂��B
�������̏d�����������ꍇ�͔z�񏇂Ő�ɏo������1�����ɃV���[�g�I�v�V�������ݒ肳��܂��B

�܂��A�V���[�g�I�v�V�����͘A�˂ĕ��������邱�Ƃ��ł��܂��B
���̏ꍇ�A�������w��ł���͈̂�ԍŌ�̃I�v�V�����Ɍ���܂��B
��: cmdhsp -vhl ja �� cmdhsp -v -h -l ja

��͂������ʂ�cmdRefArgs, cmdRefFlgs, cmdRefOpts, cmdRef�Ȃǂ̖��߂ɂ���Ď擾���܂��B

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
							errMes=strf("�I�v�V�����u--%s�v���������͂���Ă��܂��B",key)
							break
						}
						if length(args)<=i {
							errMes=strf("�I�v�V�����u--%s�v�ɑΉ�����l�����͂���Ă��܂���B",key)
							break
						}
						add@Dictionary __opts,key,args(i)
						i++:continue
					}
				next
			}
			if strmid(arg,0,1)="-":if 0=strNumChk(arg) {
				errMes=strf("�I�v�V�����u%s�v�͒�`����Ă��܂���B",arg)
				break
			}
			__args(__argsLength)=arg
			__argsLength++
			i++
		loop
	return errMes
#global
#endif
