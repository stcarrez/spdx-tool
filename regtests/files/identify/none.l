%unit CSS.Analysis.Parser.Lexer
%option case-insensitive
%option yylineno

h               [0-9a-f]
nonascii        [\240-\377]
unicode         \\{h}{1,6}(\r\n|[ \t\r\n\f])?
escape          {unicode}|\\[^\r\n\f0-9a-f]
nmstart         [_a-z]|{nonascii}|{escape}
nmchar          [_a-z0-9-]|{nonascii}|{escape}
num             [0-9]+
comment         ^\#.*$
ident           -?{nmstart}{nmchar}*(\(\))?
name            {nmchar}+
s               [ \t\r\n\f]+
w               {s}?
nl              \n|\r\n|\r|\f

%%

^\#.*$                  null;
\{                      return '{';
\}                      return '}';
