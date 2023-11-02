
option(Code, Message , CodeLink, InitialFlowCode, Keywords, [Code, Message, CodeLink, InitialFlowCode, Keywords]).


flow(Id, NameMessage, OptionsBase, [Id, NameMessage, OptionsNoDuplicados]):-
    agregarSinDuplicados(OptionsBase, [], OptionsNoDuplicados).


flowAddOption(Flow, Option, NewFlow):-
    flow(Id, NameMessage, OptionsBase, Flow),
    agregarSinDuplicados([Option|OptionsBase], [], OptionsNoDuplicados),
    flow(Id, NameMessage, OptionsNoDuplicados, NewFlow).

%Añadir eliminacion de duplicados y documentacion
%set_prolog_flag(answer_write_options,[max_depth(0)]).
% option(1,"1-viajar", 2,4, ["viajar", "turistear", "conocer"], O1),option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2),flow(1,"flujo 1:mensaje de prueba", [O1], F1), flowAddOption(F1, O2, F2).

%Funciones auxiliares que tendrán su propio archivo
pertenece(Elemento, [Elemento|_]).

pertenece(Elemento, [_|Resto]) :-
    pertenece(Elemento,Resto).

noPertenece(Elemento, Lista):-
    \+ pertenece(Elemento,Lista).

agregarSinDuplicados([], ListaAcc, ListaAcc).

agregarSinDuplicados([ElementoParaAgregar|RestoParaAgregar], Acc, ListaSalida) :-
    noPertenece(ElementoParaAgregar,Acc),
    agregarSinDuplicados(RestoParaAgregar,[ElementoParaAgregar|Acc],ListaSalida).

agregarSinDuplicados([ElementoParaAgregar|RestoParaAgregar], Acc,ListaSalida) :-
    pertenece(ElementoParaAgregar, Acc),
    agregarSinDuplicados(RestoParaAgregar, Acc, ListaSalida).



