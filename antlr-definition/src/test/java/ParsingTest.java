import mylanguage.antlr.MyLanguageLexer;
import mylanguage.antlr.MyLanguageParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;

// We want the following rule to be applied:
// expression LESS_THAN ID GREATER_THAN LPAREN ID RPAREN
// But instead, the following rule is applied:
// expression GREATER_THAN expression
// This seems to be contrary to ANTLR's professed behavior of preferring the earlier rule.
public class ParsingTest {
    private MyLanguageParser getParser() {
        String textToParse = "foo<bar>(baz)";
        MyLanguageLexer lexer = new MyLanguageLexer(CharStreams.fromString(textToParse));
        TokenStream tokens = new CommonTokenStream(lexer);
        return new MyLanguageParser(tokens);
    }

    @Test
    public void testParsingFunctionCallWithParameters() {
        MyLanguageParser parser = getParser();
        MyLanguageParser.ExpressionContext expr = parser.expression();

        System.out.println("expression: " + expr.getText());
        System.out.println("LESS_THAN: " + expr.LESS_THAN());
        System.out.println("GREATER_THAN: " + expr.GREATER_THAN());
        System.out.println("RPAREN: " + expr.LPAREN());
        System.out.println("RPAREN: " + expr.RPAREN());
        assertNotNull(expr.LESS_THAN());
        assertNotNull(expr.GREATER_THAN());
        assertNotNull(expr.LPAREN());
        assertNotNull(expr.RPAREN());
    }

    @Test
    public void testRuleVariant2() {
        MyLanguageParser parser = getParser();
        MyLanguageParser.Expression2Context expr = parser.expression2();

        System.out.println("expression: " + expr.getText());
        System.out.println("LESS_THAN: " + expr.LESS_THAN());
        System.out.println("GREATER_THAN: " + expr.GREATER_THAN());
        System.out.println("LPAREN: " + expr.LPAREN());
        System.out.println("RPAREN: " + expr.RPAREN());
        assertNotNull(expr.LESS_THAN());
        assertNotNull(expr.GREATER_THAN());
        assertNotNull(expr.LPAREN());
        assertNotNull(expr.RPAREN());
    }

    @Test
    public void testRuleVariant3() {
        MyLanguageParser parser = getParser();
        MyLanguageParser.Expression3Context expr = parser.expression3();

        System.out.println("expression: " + expr.getText());
        System.out.println("LESS_THAN: " + expr.LESS_THAN());
        System.out.println("GREATER_THAN: " + expr.GREATER_THAN());
        System.out.println("LPAREN: " + expr.LPAREN());
        System.out.println("RPAREN: " + expr.RPAREN());
        assertNotNull(expr.LESS_THAN());
        assertNotNull(expr.GREATER_THAN());
        assertNotNull(expr.LPAREN());
        assertNotNull(expr.RPAREN());
    }

    @Test
    public void testRuleVariant4() {
        MyLanguageParser parser = getParser();
        MyLanguageParser.Expression4Context expr = parser.expression4();

        System.out.println("expression: " + expr.getText());
        System.out.println("LESS_THAN: " + expr.LESS_THAN());
        System.out.println("GREATER_THAN: " + expr.GREATER_THAN());
        System.out.println("LPAREN: " + expr.LPAREN());
        System.out.println("RPAREN: " + expr.RPAREN());
        assertNotNull(expr.LESS_THAN());
        assertNotNull(expr.GREATER_THAN());
        assertNotNull(expr.LPAREN());
        assertNotNull(expr.RPAREN());
    }
}
