
:- module(tdaOption_21159364_BricenoVilches, [getOpCode/2, eliminarOpRepetidas/4]).


%getOpcode/2
%Dom: Opcion (list) X Code (symbol).
%Meta Principal: getOpCode/2
%Meta Secundaria: NA
getOpCode([Code | _], Code).






eliminarOpRepetidas([],_,AccOpciones,AccOpciones).

eliminarOpRepetidas([OpcionParaAgregar|RestoOpciones], AccCode,AccOpciones, ListaSalida) :-
    %Hacer selector de Code de opcion
    getOpCode(OpcionParaAgregar,Code),
    \+ member(Code,AccCode),
    eliminarOpRepetidas(RestoOpciones,[Code|AccCode],[OpcionParaAgregar|AccOpciones],ListaSalida).

eliminarOpRepetidas([OpcionParaAgregar|RestoOpciones], AccCode,AccOpciones,ListaSalida) :-
    getOpCode(OpcionParaAgregar,Code),
    member(Code, AccCode),
    eliminarOpRepetidas(RestoOpciones, AccCode, AccOpciones, ListaSalida).
