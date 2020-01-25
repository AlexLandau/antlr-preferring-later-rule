parser grammar MyLanguageParser;

@header {
  package mylanguage.antlr;
}

tokens {
  NEWLINE,
  WS,
  LINE_COMMENT,
  BLOCK_COMMENT,
  PACKAGE,
  IMPORT,
  FUNCTION,
  STRUCT,
  UNION,
  RETURN,
  LET,
  IF,
  ELSE,
  REQUIRES,
  WHILE,
  LITERAL,
  INTEGER_LITERAL,
  DOT,
  COMMA,
  COLON,
  ASSIGN,
  DOT_ASSIGN,
  EQUALS,
  NOT_EQUALS,
  LPAREN,
  RPAREN,
  LBRACKET,
  RBRACKET,
  LBRACE,
  RBRACE,
  D_QUOTE,
  S_QUOTE,
  ARROW,
  LESS_THAN,
  GREATER_THAN,
  PIPE,
  AT,
  AMPERSAND,
  PLUS,
  HYPHEN,
  TIMES,
  AND,
  OR,
  MODULE_ID,
  ID,
  UNDERSCORE
}

namespace : ID | ID DOT namespace ;
    catch[RecognitionException e] { throw e; }
entity_id : ID | namespace DOT ID ;
    catch[RecognitionException e] { throw e; }
type_ref : entity_id | AMPERSAND entity_id | module_ref COLON entity_id | module_ref COLON AMPERSAND entity_id ;
    catch[RecognitionException e] { throw e; }
module_ref : module_id // Name only
  | module_id COLON module_id // Group and name
  | module_id COLON module_id COLON LITERAL ; // Group, name, and version
    catch[RecognitionException e] { throw e; }
module_id : ID | MODULE_ID ;
    catch[RecognitionException e] { throw e; }

annotations : | annotation annotations ;
    catch[RecognitionException e] { throw e; }
annotation : annotation_name
  | annotation_name LPAREN annotation_contents_list RPAREN ;
    catch[RecognitionException e] { throw e; }
annotation_name : AT entity_id ;
    catch[RecognitionException e] { throw e; }
annotation_contents_list : | annotation_item | annotation_item COMMA | annotation_item COMMA annotation_contents_list ;
    catch[RecognitionException e] { throw e; }
annotation_item : LITERAL | LBRACKET annotation_contents_list RBRACKET ;
    catch[RecognitionException e] { throw e; }

// cd_type_parameters is nonempty
cd_type_parameters : type_parameter | type_parameter COMMA | type_parameter COMMA cd_type_parameters ;
    catch[RecognitionException e] { throw e; }
type_parameter : ID | ID COLON type_class ;
    catch[RecognitionException e] { throw e; }
type_class : ID ;
    catch[RecognitionException e] { throw e; }

assignments : | assignment assignments ;
    catch[RecognitionException e] { throw e; }
assignment : LET ID ASSIGN expression
  | LET ID COLON type ASSIGN expression;
    catch[RecognitionException e] { throw e; }

type : type_ref
  | type_ref LESS_THAN cd_types GREATER_THAN
  | LPAREN cd_types RPAREN ARROW type
  | AMPERSAND LPAREN cd_types RPAREN ARROW type
  | LESS_THAN cd_type_parameters GREATER_THAN LPAREN cd_types RPAREN ARROW type
  | AMPERSAND LESS_THAN cd_type_parameters GREATER_THAN LPAREN cd_types RPAREN ARROW type ;
    catch[RecognitionException e] { throw e; }
cd_types : | type | type COMMA | type COMMA cd_types ;
    catch[RecognitionException e] { throw e; }
cd_types_nonempty : type | type COMMA | type COMMA cd_types_nonempty ;
    catch[RecognitionException e] { throw e; }
cd_types_or_underscores_nonempty : type_or_underscore | type_or_underscore COMMA | type_or_underscore COMMA cd_types_or_underscores_nonempty ;
    catch[RecognitionException e] { throw e; }
type_or_underscore : UNDERSCORE | type ;
    catch[RecognitionException e] { throw e; }
expression : type_ref DOT LITERAL // sem1-style literal with explicit type, e.g. String."foo" or Integer."42"
  | ID
  | LITERAL // String literal, e.g. "foo"
  | INTEGER_LITERAL // Integer literal, e.g. 42
  | LBRACKET cd_expressions RBRACKET LESS_THAN type GREATER_THAN
  | expression LESS_THAN cd_types_or_underscores_nonempty GREATER_THAN PIPE LPAREN cd_expressions_or_underscores RPAREN // Function binding with type parameters
  | expression LESS_THAN cd_types_nonempty GREATER_THAN LPAREN cd_expressions RPAREN
  | expression ARROW ID
  | expression PIPE LPAREN cd_expressions_or_underscores RPAREN // Function binding
  | expression LPAREN cd_expressions RPAREN // Calling function reference OR function variable
  | expression DOT ID
  | expression LESS_THAN expression // < operator
  | expression GREATER_THAN expression // > operator
  | LPAREN expression RPAREN
  ;
    catch[RecognitionException e] { throw e; }

// cd_expressions may be empty
cd_expressions : | expression | expression COMMA cd_expressions ;
    catch[RecognitionException e] { throw e; }
cd_expressions_or_underscores : | expression_or_underscore | expression_or_underscore COMMA cd_expressions_or_underscores ;
    catch[RecognitionException e] { throw e; }
expression_or_underscore : UNDERSCORE | expression ;
    catch[RecognitionException e] { throw e; }
