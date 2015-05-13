-module(calc).
-export([rpn/1, rpn_test/0]).

% Smth = "1 2 3 + 4 * 5 / -"

rpn(Expr) when is_list(Expr) ->
    LExpr = string:tokens(Expr, " "),
    try
        [Res] = lists:foldl(fun rpn/2, [], LExpr),
        Res
    catch
        _:_ -> erlang:error(badarith)
    end
.

read(N) ->
    case string:to_float(N) of
        {error, no_float} -> list_to_integer(N);
        {F, _} -> F
    end
.

rpn("+", [N1, N2|S]) -> [N2 + N1 | S];
rpn("-", [N1, N2|S]) -> [N2 - N1 | S];
rpn("*", [N1, N2|S]) -> [N2 * N1 | S];
rpn("/", [N1, N2|S]) -> [N2 / N1 | S];
rpn("^", [N1, N2|S]) -> [math:pow(N2, N1) | S];
rpn("sum", L) -> lists:foldr(
                    fun
                        (El, []) -> [El];
                        (El, [H|T]) -> [El + H | T]
                    end, [], L);
rpn(X, Stack) ->
    [read(X)|Stack]
.

rpn_test() ->
    5 = rpn("2 3 +"),
    87 = rpn("90 3 -"),
    -4 = rpn("10 4 3 + 2 * -"),
    -2.0 = rpn("10 4 3 + 2 * - 2 /"),
    50 = rpn("10 10 10 20 sum"),
    10.0 = rpn("10 10 10 20 sum 5 /"),
    ok = try
        rpn("90 34 12 33 55 66 + * - +")
        % rpn("20 30 zuzu")
    catch
        error:badarith -> ok
    end,

    ok
.
