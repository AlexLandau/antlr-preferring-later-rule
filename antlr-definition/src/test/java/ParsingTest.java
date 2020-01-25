import mylanguage.antlr.MyLanguageLexer;
import mylanguage.antlr.MyLanguageParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;

public class ParsingTest {
    @Test
    public void testParsingFunctionCallWithParameters() {
        String textToParse = "foo<bar>(baz)";
        MyLanguageLexer lexer = new MyLanguageLexer(CharStreams.fromString(textToParse));
        TokenStream tokens = new CommonTokenStream(lexer);
        MyLanguageParser parser = new MyLanguageParser(tokens);

        MyLanguageParser.ExpressionContext expr = parser.expression();

        // We want the following rule to be applied:
        // expression LESS_THAN cd_types_nonempty GREATER_THAN LPAREN_NO_WS cd_expressions RPAREN
        // But instead, the following rule is applied:
        // expression GREATER_THAN expression
        // This seems to be contrary to ANTLR's professed behavior of preferring the earlier rule.

        System.out.println("expression: " + expr.getText());
        System.out.println("LESS_THAN: " + expr.LESS_THAN());
        System.out.println("GREATER_THAN: " + expr.GREATER_THAN());
        // TODO: Fix this
        System.out.println("lparen: " + expr.lparen());
        System.out.println("RPAREN: " + expr.RPAREN());
        assertNotNull(expr.LESS_THAN());
        assertNotNull(expr.GREATER_THAN());
        assertNotNull(expr.lparen());
        assertNotNull(expr.RPAREN());
    }
}
