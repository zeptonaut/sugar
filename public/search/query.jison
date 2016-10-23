/* description: Parses end creates Sugar task search queries. */

/* lexical grammar */
%lex
%%

\s+                   return 'SPACE'
"sort:"               return 'SORT'
[A-Za-z0-9]+          return 'TERM'
","                   return ','
"+"                   return '+'
"-"                   return '-'
<<EOF>>               return 'EOF'
.                     return 'INVALID'


/lex

%start query

%% /* language grammar */

/* TODO(charliea): Add better default sort. */
query
    : filter EOF
        {return $1;}
    | filter SPACE sort EOF
        {return $1 + ' ' + $3;}
    | sort SPACE filter EOF
        {return $3 + ' ' + $1;}
    | sort EOF
        {return $1;}
    ;

filter
    : TERM
        {$$ = yytext;}
    | filter SPACE TERM
        {$$ = '(' + $1 + ' AND ' + $3 + ')';}
    ;

sort
    : SORT sort_order
        {$$ = 'SORT BY ' + $2;}
    | sort ',' sort_order
        {$$ = $1 + ' ' + $3;}
    ;

sort_order
    : '+' TERM
        {$$ = yytext + ' ASC';}
    | '-' TERM
        {$$ = yytext + ' DESC';}
    ;
