grammar Turing;

options {
    language = CSharp;
}

/*
 Parser rules
 */

expression
    : primaryExpr
    ;

primaryExpr
    : BOOLEAN
    | ID
    | DOUBLE
    | STRING
    ;

/*
 Lexer rules
 */

BOOLEAN : 'True' | 'False';

ID : [a-zA-Z_][a-zA-Z_0-9]* ;

DOUBLE : '-'? (DIGIT+ ('.' DIGIT+)? ) ;

DIGIT : [0-9] ;

STRING
    : '\'' (~('\'' | '\r' | '\n'))* '\''
    ;

NEWLINE : ('\r' | '\n')+ ;

WS : ('\t' | ' ')+ -> channel(HIDDEN);
