
:- module(tdaOption_21159364_BricenoVilches, [getOpCode/2, getOpMsg/2, getOpChatbotCodeLink/2, getOpInitialFlowCodeLink/2, verificarOpRepetidas/4, encontrarMsgOp/3, encontrarOpString/2]).


%Capa TDA selectores


%Dom: Option (list) X Code (int).
%Meta Principal: getOpCode/2
%Meta Secundaria: NA
%Encuentra en una lista Opción su Código

getOpCode([Code | _], Code).


%Dom: Option (list) X Msg (string).
%Meta Principal: getOpMsg/2
%Meta Secundaria: NA
%Encuentra en la lista Opción su mensaje

getOpMsg([_,Msg,_,_,_],Msg).


%Dom: Option (list) X ChatbotCodeLink (int)
%Meta Principal: getOpChatbotCodeLink/2
%Meta Secundaria: NA
%Encuentra de una lista Opción su ChatbotCodeLink.

getOpChatbotCodeLink([_,_,ChatbotCodeLink,_,_],ChatbotCodeLink).


%Dom: Option (list) X InitialFlowCodeLink (int)
%Meta Principal: getOpInitialFlowCodeLink/2
%Meta Secundaria: NA
%Encuentra en la lista Opción su InitialFlowCodeLink.

getOpInitialFlowCodeLink([_,_,_,InitialFlowCodeLink,_], InitialFlowCodeLink).


%Dom: Option (list) X Keywords (list)
%Meta Principal: getOpChatbotCodeLink/2
%Meta Secundaria: NA
%Encuentra la lista de Keywords de la lista Opción.

getOpKeywords([_,_,_,_,Keywords], Keywords).



%TDA capa Pertenencia


%Dom: Opciones (list) X AccCode (list) X AccOpciones (list) X ListaSalida (list)
%Meta Principal: verificarOpRepetidas/4
% Meta Secundaria: 1) NA.
%2) getOpCode/2, \+member/2, append/3, verificarOpRepetidas/4.
% Verifica que una lista de opciones no tenga repetida ninguna en base a
% sus ID, si hay una repetida retorna false.


%1)Caso Base
% Cuando se vacía la lista de opciones unifica AccOpciones con la última
% variable del predicado
verificarOpRepetidas([],_,AccOpciones,AccOpciones).

% 2)Caso donde el Code de la opcion no se encuentra en AccCode y se
% acumulan las opciones en una lista de manera recursiva
verificarOpRepetidas([OpcionParaAgregar|RestoOpciones], AccCode,AccOpciones, ListaSalida) :-
    getOpCode(OpcionParaAgregar,Code),
    \+ member(Code,AccCode), %No esta, por lo tanto se añade a ambas listas acumuladoras
    append(AccOpciones, [OpcionParaAgregar], AccOpcionesNuevo),
    verificarOpRepetidas(RestoOpciones,[Code|AccCode],AccOpcionesNuevo,ListaSalida).

%Dom: Msg (string) X Options (list) X OpEncontrada (list)
%Meta Principal: encontrarMsgOp/3
% Meta Secundaria: 1) fail
% 2) getOpMsg/2, msgEncontrado/2, OpEncontrada =
% Option, getOpKeywords/2, keywordEncontrado/2, encontrarMsgOp/3
% Predicado que dado un String de mensaje lo busca en una lista de
% opciones, buscando en su Code, propio mensaje de la Opcion o sus
% keywords.


% 1) Caso Base, si la lista se vacía y no logra encontrar una opcion
% correspondiente, retorna false.
encontrarMsgOp(_, [], _):- fail.

% 2) Busca en cada opción individual de manera recursiva una de
% las opciones explicadas arriba
encontrarMsgOp(Msg, [Option|RestoOptions], OpEncontrada):-
    (getOpMsg(Option, OpMsg),
     msgEncontrado(OpMsg, Msg),
    OpEncontrada = Option);
    (getOpKeywords(Option, Keywords),
     keywordEncontrado(Msg, Keywords),
    OpEncontrada = Option);
    encontrarMsgOp(Msg,RestoOptions, OpEncontrada).


%Dom: String (string) X Substring (string)
%Meta Principal: msgEncontrado/2
%Meta Secundaria: encontrarOpString/2, encontrarOpNum/2,
% downcase_atom/2, Numero1 = DowncaseSubstring, Eleccion1 =
% DowncaseSubstring, DowncaseString = DowncaseSubstring.
% Predicado que busca dentro del string mensaje de una opción, si un
% mensaje dado se encuentra dentro de este.

msgEncontrado(String, Substring) :-
    encontrarOpString(String, Eleccion),
    encontrarOpNum(String, Numero),
    downcase_atom(Substring, DowncaseSubstring),
    ((downcase_atom(Numero,Numero1),Numero1 = DowncaseSubstring);
    (downcase_atom(Eleccion, Eleccion1), Eleccion1 = DowncaseSubstring);
    (downcase_atom(String, DowncaseString), DowncaseString = DowncaseSubstring)).

%Dom: Msg (string) X Keywords (list)
%Meta Principal: keywordEncontrado/2
% Meta Secundaria:1)NA.
%2) downcase_atom/2, DowncaseMsg = Downcasekeyword, keywordEncontrado/2
% Predicado que busca si un string mensaje se encuentra dentro de una
% lista de keywords sin importar sus mayusculas


% 1) Caso base, si la lista se vacía es porque no encontró ninguna
% keyword correspondiente al Msg.
keywordEncontrado(_, []):- fail.

% 2) Realiza el proceso de comparar cada keyword individualmente en
% forma recursiva
keywordEncontrado(Msg, [Keyword|RestoKeywords]):-
    downcase_atom(Msg,DowncaseMsg),
    downcase_atom(Keyword, DowncaseKeyword),
    DowncaseMsg = DowncaseKeyword;
    keywordEncontrado(Msg, RestoKeywords).



% TDA capa Otros


%Dom: String (string) X Eleccion (string)
%Meta Principal: encontrarOpString/2
%Meta Secundaria: sub_string/5
% Predicado que separa del mensaje de una opcion el nombre de la
% eleccion, por ejemplo "2-Seleccionar" pondría en la variable Elección
% "Seleccionar".

encontrarOpString(String, Eleccion) :-
    sub_string(String, _, _, After, "-"),
    !,
    sub_string(String, _, After, 0, Eleccion).


%Dom: String (string) X Numero (string)
%Meta Principal: encontrarOpString/2
%Meta Secundaria: sub_string/5
% Predicado que separa del mensaje de una opción su número para la
% eleccion.

encontrarOpNum(String, Numero) :-
    sub_string(String, Before, _, _, "-"),
    !,
    sub_string(String, 0, Before, _, Numero).



