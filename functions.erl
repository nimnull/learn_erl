-module(functions).
-export([
        head/1,
        second/1,
        same/2,
        old_enough/1,
        increment/1,
        decrement/1,
        map/2,
        incr/1,
        decr/1,
        max/1,
        sublist/2,
        zip/2
]).

% Find maximum value from list

max([H|T]) -> tail_max(T, H).

tail_max([], Max) -> Max;
tail_max([H|T], Max) when H > Max -> tail_max(T, H);
tail_max([_|T], Max) -> tail_max(T, Max).


head([H|_]) -> H.
second([_, X|_]) -> X.

same(X, X) -> true;
same(_,_) -> false.

old_enough(X) when X >= 16 -> true;
old_enough(_) -> false.

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

% Tail called sublist of N values from the L list:

sublist(L, N) -> lists:reverse(tail_sublist(L, N, [])).
tail_sublist(_, 0, Sublist) -> Sublist;
tail_sublist([], _, Sublist) -> Sublist;
tail_sublist([H|T], N, Sublist) when N > 0 -> tail_sublist(T, N - 1, [H|Sublist]).

zip([], []) -> [];
zip([X|Xt], [Y|Yt]) -> [[X, Y]|zip(Xt, Yt)].
