-module(duplicate).
-export([duplicate/2]).

% duplicate(0, _) -> [];
duplicate(N, Term) -> duplicate(N, Term, []).
duplicate(0, _, List) -> List;
duplicate(N, Term, List) when N > 0 -> duplicate(N-1, Term, [Term|List]).
% duplicate(N, Term) -> [Term|duplicate(N-1, Term)].


