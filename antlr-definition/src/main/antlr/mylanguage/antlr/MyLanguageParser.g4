parser grammar MyLanguageParser;

@header {
  package mylanguage.antlr;
}

tokens {
  NEWLINE,
  WS,
  LINE_COMMENT,
  BLOCK_COMMENT,
  LPAREN,
  RPAREN,
  LESS_THAN,
  GREATER_THAN,
  ID
}

// String to parse: foo<bar>(baz)

// This fails to parse as intended
expression : ID
  | expression LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | expression LESS_THAN expression // < operator
  | expression GREATER_THAN expression // > operator
  | LPAREN expression RPAREN
  ;

// This fails to parse as intended
expression2 : ID
  | ID LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | expression2 LESS_THAN expression2 // < operator
  | expression2 GREATER_THAN expression2 // > operator
  | LPAREN ID RPAREN
  ;

// This parses as intended
expression3 : ID
  | ID LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | ID LESS_THAN ID // < operator
  | expression3 GREATER_THAN expression3 // > operator
  | LPAREN ID RPAREN
  ;

// This parses as intended
expression4 : ID
  | ID LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | ID LESS_THAN expression4 // < operator
  | ID GREATER_THAN expression4 // > operator
  | LPAREN ID RPAREN
  ;
