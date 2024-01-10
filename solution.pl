knows(pavlov, artist).
knows(artist, pavlov).
knows(writer, artist).
knows(artist, writer).
knows(writer, saharov).
knows(writer, voronov).
knows(pavlov, writer).
knows(writer, pavlov).
knows(voronov, levickiy).

in([L|_], L).
in([_|T], L) :- in(T, L).

meets([X|Y],[X1|Y1]) :- knows(X, X2); knows(Y, X2); knows(X, Y2); knows(Y, X2).

merge([], [], []).
merge([H1|T1], [H2|T2], [[H1,H2]|X]) :- merge(T1, T2, X).

solve :-
    permutation(NAMES, [voronov, pavlov, levickiy, sakharov]),
    permutation(PROFS, [dancer, artist, singer, writer]), 
    merge(NAMES, PROFS, NP), % Все пары имя-профессия

    % Воронов и Левицкий не певцы
    not(in(NP, [voronov, singer])),
    not(in(NP, [levickiy, singer])),

    % Павлов не артист и не писатель
    not(in(NP, [pavlov, artist])),
    not(in(NP, [pavlov, writer])),

    % Воронов и Сахаров не могут быть писателями
    not(in(NP, [voronov, writer])),
    not(in(NP, [sakharov, writer])),
    
    meets([voronov, _], [levickiy, _]),
    meets([_, artist], [pavlov, _]),
    meets([_, artist], [_, writer]),
    meets([pavlov, _], [_, writer]),
    meets([_, writer], [pavlov, _]),
    meets([pavlov, _], [_, artist]),
    meets([_, writer], [_, artist]),
    meets([_, writer], [sakharov, _]),
    meets([_, writer], [voronov, _]),

    write(NP).
