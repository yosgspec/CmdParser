::�r���h
hspc -mP -C cmdtest.hsp
del obj
npm run build
dotnet publish
rd /s /q obj

@echo off
::���s�R�}���h
set runtime_hsp=cmdtest
set runtime_nodejs=node cmdtest.js
set runtime_csharp=bin\Release\net6.0\win-x64\publish\cmdtest
set runtime_python=pypy3 cmdtest.py

::�R�}���h���C���I�v�V����
set options_0=
set options_1=1 2 3
set options_2=-a �� --beta �� -g ��
set options_3=--alpha	�� -b	�� --gamma ��
set options_4=-h --version
set options_5=--help	 	-v
set options_6=1 -a �� -h --beta �� 2 3 -v -g ��
set options_7=--alpaca "�� �� �� ��" -a ��
set options_8=a"b"c"d"e
set options_9=a�@b	c�@d e
set options_10=--unknown
set options_11=-a
set options_12=-a �� --alpha A
set options_13=-a -3 -2 -h -1 -0
set options_14=-vha ��

for /l %%i in (0,1,14) do (
	echo;
	call echo $ runtime %%options_%%i%%
	for %%n in (hsp nodejs csharp python) do (
		call %%runtime_%%n%% %%options_%%i%%
	)
)
pause
