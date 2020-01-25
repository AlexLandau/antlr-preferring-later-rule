# antlr-preferring-later-rule
Repro of what looks like a bug in ANTLR

Given the following ANTLR parsing rule:

```
expression : ID
  | expression LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
  | expression LESS_THAN expression // < operator
  | expression GREATER_THAN expression // > operator
  | LPAREN expression RPAREN
  ;
```

... I'd expect the string `foo<bar>(baz)` to match on the second rule (`expression LESS_THAN ID GREATER_THAN LPAREN ID RPAREN`). Instead, it parses as (essentially) `(foo < bar) > (baz)`.

There are four tests, each for a variant of the rule (two fail, two work as intended). Run them with `./gradlew test`.

Per the discussion at https://github.com/antlr/antlr4/issues/866, this may be a known issue that isn't going to be fixed.
