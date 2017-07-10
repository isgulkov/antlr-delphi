grammar Delphi;

options {
    language = CSharp;
}

/*
 Parser rules
 */

file
    :
    ('var' NEWLINE
    (variableDeclaration NEWLINE)*)?
    'begin' NEWLINE
    (statement NEWLINE)*
    'end.' NEWLINE? EOF
    ;

variableDeclaration
    : ID (',' ID) ':' TYPENAME ';'
    ;

codeBlock
    : 'begin' NEWLINE (statement NEWLINE)* 'end'
    ;

statement
    : assignmentStatement
    | whileStatement
    | ifStatement
    | writelnStatement
    ;

assignmentStatement
    : ID ':=' expression ';'
    ;

whileStatement
    : 'while' orExpression 'do' statement
    | 'while' orExpression 'do' NEWLINE codeBlock
    ;

ifStatement
    : 'if' orExpression 'then' statement
    | 'if' orExpression 'then' NEWLINE codeBlock
    ;

writelnStatement
    : 'writeln' '(' (expression | STRING)? ')' ';'
    ;

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

TYPENAME : 'boolean' | 'double' ;

BOOLEAN : 'True' | 'False' ;

ID : [a-zA-Z_][a-zA-Z_0-9]* ;

DOUBLE : '-'? (DIGIT+ ('.' DIGIT+)? ) ;

DIGIT : [0-9] ;

STRING
    : '\'' (~('\'' | '\r' | '\n'))* '\''
    ;

NEWLINE : ('\r' | '\n')+ ;

WS : ('\t' | ' ')+ -> channel(HIDDEN);
