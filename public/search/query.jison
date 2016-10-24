/* description: Parses and creates Sugar task search queries. */

/* lexical grammar */
%lex
%%

/*
\s+                   return 'SPACE'
*/
"sort:"               return 'SORT'
[A-Za-z0-9]+          return 'TERM'
"+"                   return '+'
"-"                   return '-'
<<EOF>>               return 'EOF'
.                     return 'INVALID'


/lex

%start query

%% /* language grammar */

/* TODO(charliea): Add better default sort. */
query
    : /*filter EOF
        { return { filter: $1 }; }
    | filter SPACE sort EOF
        { return { filter: $1, sort: $3 }; }
    | sort SPACE filter EOF
        { return { filter: $3, sort: $1 }; }
    |*/ sort EOF
        { return { sort: $1 }; }
    ;
/*
filter
    : TERM
        { $$ = function(task) { return task.description.indexOf($1) !== -1; }; }
    | filter SPACE TERM
        { $$ = function(task) { return $1(task) && task.description.indexOf($3) !== -1; }; }
    ;
*/
sort
    : SORT sort_order
        { $$ = $2; }
    ;

sort_order
    : '+' TERM
        { $$ = getCompare(yytext, '+'); }
    | '-' TERM
        { $$ = getCompare(yytext, '-'); }
    ;
