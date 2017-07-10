grammar Turing;

options {
    language = CSharp;
}

/*
 Parser rules
 */

expression
    : orExpression
    | additiveExpression
    ;

additiveExpression
    : multiplicativeExpression
    | additiveExpression ('+' | '-') multiplicativeExpression
    ;

multiplicativeExpression
    : primaryDoubleExpression
    | multiplicativeExpression ('*' | '/') primaryDoubleExpression
    ;

primaryDoubleExpression
    : DOUBLE
    | ID
    ;

orExpression
    : andExpression
    | orExpression 'or' andExpression
    ;

andExpression
    : notExpression
    | andExpression 'and' notExpression
    ;

notExpression
    : primaryBoolExpression
    | 'not' primaryBoolExpression
    ;

primaryBoolExpression
    : BOOLEAN
    | ID
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
