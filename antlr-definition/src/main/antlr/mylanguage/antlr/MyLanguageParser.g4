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

expression : ID
  | expression LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | expression LPAREN ID RPAREN
  | expression LESS_THAN expression // < operator
  | expression GREATER_THAN expression // > operator
  | LPAREN expression RPAREN
  ;
    catch[RecognitionException e] { throw e; }
