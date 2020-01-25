lexer grammar MyLanguageLexer;

@header {
  package mylanguage.antlr;
}

// Whitespace
NEWLINE            : ('\r\n' | 'r' | '\n') -> skip ;
WS                 : [\t ]+ -> skip ;

// Comments
LINE_COMMENT       : '//' (~[\n\r])* (NEWLINE | EOF) -> skip ;
BLOCK_COMMENT       : '/*' .*? '*/' -> skip;

// Operators
LPAREN             : '(' ;
RPAREN             : ')' ;
LESS_THAN          : '<' ;
GREATER_THAN       : '>' ;

// Identifiers
ID                 : ([a-zA-Z]|[_]+[a-zA-Z0-9])[A-Za-z0-9_]* ;
