::ビルド
hspc -mP -C cmdtest.hsp
del obj
npm run build
dotnet publish
rd /s /q obj

@echo off
::実行コマンド
set runtime_hsp=cmdtest
set runtime_nodejs=node cmdtest.js
set runtime_csharp=bin\Release\net6.0\win-x64\publish\cmdtest
set runtime_python=pypy3 cmdtest.py

::コマンドラインオプション
set options_0=
set options_1=1 2 3
set options_2=-a α --beta β -g γ
set options_3=--alpha	α -b	β --gamma γ
set options_4=-h --version
set options_5=--help	 	-v
set options_6=1 -a α -h --beta β 2 3 -v -g γ
set options_7=--alpaca "あ る ぱ か" -a α
set options_8=a"b"c"d"e
set options_9=a　b	c　d e
set options_10=--unknown
set options_11=-a
set options_12=-a α --alpha A
set options_13=-a -3 -2 -h -1 -0
set options_14=-vha α

for /l %%i in (0,1,14) do (
	echo;
	call echo $ runtime %%options_%%i%%
	for %%n in (hsp nodejs csharp python) do (
		call %%runtime_%%n%% %%options_%%i%%
	)
)
pause
