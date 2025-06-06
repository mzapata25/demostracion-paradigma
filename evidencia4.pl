% Reglas: enfermedad si se cumplen ciertos síntomas

enfermedad(gripe) :-
    tiene(fiebre), 
    tiene(dolor_cabeza), 
    tiene(tos).

enfermedad(resfriado) :- 
    tiene(estornudos), 
    tiene(tos), 
    \+ tiene(fiebre).

enfermedad(alergia) :-
    tiene(estornudos), 
    tiene(ojos_llorosos), 
    \+ tiene(fiebre).

enfermedad(covid) :-
    tiene(fiebre),
    tiene(tos),
    tiene(dificultad_respirar),
    tiene(perdida_olfato).

% Predicado dinámico para poder agregar hechos en tiempo de ejecución
:- dynamic tiene/1.

% Pregunta un síntoma si no se ha preguntado antes
preguntar(Sintoma) :-
    write('¿Tiene '), write(Sintoma), write('? (si/no): '),
    read(Respuesta),
    (Respuesta == si -> assertz(tiene(Sintoma)) ; true), !.


% Lista de síntomas a preguntar
sintomas([fiebre, dolor_cabeza, tos, estornudos, ojos_llorosos, dificultad_respirar, perdida_olfato]).

diagnostico :-
    sintomas(S),
    preguntar_sintomas(S),
    (enfermedad(E) -> 
        write('Diagnóstico posible: '), write(E), nl 
    ; 
        write('No se pudo determinar una enfermedad con los síntomas dados.'), nl),
    limpiar.

% Pregunta todos los síntomas
preguntar_sintomas([]).
preguntar_sintomas([H|T]) :- preguntar(H), preguntar_sintomas(T).

% Limpia los hechos almacenados para poder hacer una nueva consulta
limpiar :- retractall(tiene(_)).
