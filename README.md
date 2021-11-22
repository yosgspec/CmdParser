# CmdParser
非常にシンプルなHSP3、TypeScript、C#、Python用のコマンドラインパーサ。

```bash
$ runtime
{"hsp3.6":"デフォルトオプションで実行しています。"}
{"nodejs":"デフォルトオプションで実行しています。"}
{"csharp":"デフォルトオプションで実行しています。"}
{"python":"デフォルトオプションで実行しています。"}

$ runtime 1 2 3
{"hsp3.6":{"args":["1","2","3"],"flgs":{"help":false,"version":false},"opts":{}}}
{"nodejs":{"args":["1","2","3"],"flgs":{"help":false,"version":false},"opts":{}}}
{"csharp":{"args":["1","2","3"],"flgs":{"help":false,"version":false},"opts":{}}}
{"python":{"args":["1","2","3"],"flgs":{"help":false,"version":false},"opts":{}}}

$ runtime -a α --beta β -g γ
{"hsp3.6":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"nodejs":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"csharp":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"python":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}

$ runtime --alpha       α -b   β --gamma γ
{"hsp3.6":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"nodejs":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"csharp":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"python":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}

$ runtime -h --version
{"hsp3.6":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"nodejs":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"csharp":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"python":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}

$ runtime --help                -v
{"hsp3.6":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"nodejs":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"csharp":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}
{"python":{"args":[],"flgs":{"help":true,"version":true},"opts":{}}}

$ runtime 1 -a α -h --beta β 2 3 -v -g γ
{"hsp3.6":{"args":["1","2","3"],"flgs":{"help":true,"version":true},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"nodejs":{"args":["1","2","3"],"flgs":{"help":true,"version":true},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"csharp":{"args":["1","2","3"],"flgs":{"help":true,"version":true},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}
{"python":{"args":["1","2","3"],"flgs":{"help":true,"version":true},"opts":{"alpha":"α","beta":"β","gamma":"γ"}}}

$ runtime --alpaca "あ る ぱ か" -a α
{"hsp3.6":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpaca":"あ る ぱ か","alpha":"α"}}}
{"nodejs":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpaca":"あ る ぱ か","alpha":"α"}}}
{"csharp":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpaca":"あ る ぱ か","alpha":"α"}}}
{"python":{"args":[],"flgs":{"help":false,"version":false},"opts":{"alpaca":"あ る ぱ か","alpha":"α"}}}

$ runtime a"b"c"d"e
{"hsp3.6":{"args":["abcde"],"flgs":{"help":false,"version":false},"opts":{}}}
{"nodejs":{"args":["abcde"],"flgs":{"help":false,"version":false},"opts":{}}}
{"csharp":{"args":["abcde"],"flgs":{"help":false,"version":false},"opts":{}}}
{"python":{"args":["abcde"],"flgs":{"help":false,"version":false},"opts":{}}}

$ runtime a　b  c　d e
{"hsp3.6":{"args":["a　b","c　d","e"],"flgs":{"help":false,"version":false},"opts":{}}}
{"nodejs":{"args":["a　b","c　d","e"],"flgs":{"help":false,"version":false},"opts":{}}}
{"csharp":{"args":["a　b","c　d","e"],"flgs":{"help":false,"version":false},"opts":{}}}
{"python":{"args":["a　b","c　d","e"],"flgs":{"help":false,"version":false},"opts":{}}}

$ runtime --unknown
{"hsp3.6":{"refstr":"オプション「--unknown」は定義されていません。"}}
{"nodejs":{"SyntaxError":"オプション「--unknown」は定義されていません。"}}
{"csharp":{"System.FormatException":"オプション「--unknown」は定義されていません。"}}
{"python":{"ValueError":"オプション「--unknown」は定義されていません。"}}

$ runtime -a
{"hsp3.6":{"refstr":"オプション「--alpha」に対応する値が入力されていません。"}}
{"nodejs":{"SyntaxError":"オプション「--alpha」に対応する値が入力されていません。"}}
{"csharp":{"System.FormatException":"オプション「--alpha」に対応する値が入力されていません。"}}
{"python":{"ValueError":"オプション「--alpha」に対応する値が入力されていません。"}}

$ runtime -a α --alpha A
{"hsp3.6":{"refstr":"オプション「--alpha」が複数入力されています。"}}
{"nodejs":{"SyntaxError":"オプション「--alpha」が複数入力されています。"}}
{"csharp":{"System.FormatException":"オプション「--alpha」が複数入力されています。"}}
{"python":{"ValueError":"オプション「--alpha」が複数入力されています。"}}
```
