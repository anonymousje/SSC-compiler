enum token {
    tok_printd = 1,
    tok_prints = 2,
    tok_for = 3,
    tok_increment = 4,
    tok_decrement = 5,
    tok_identifier = 6,
    tok_double_literal = 7,
    tok_string_literal = 8

};

union yylval {
    char *identifier;
    double double_literal;
    char *string_literal;
} yylval;

void yyerror (const char *msg)
{
    fprintf(stderr, "\n%s\n", msg);
} 