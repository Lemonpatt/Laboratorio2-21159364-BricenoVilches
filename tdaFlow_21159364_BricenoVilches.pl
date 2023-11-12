:- module(tdaFlow_21159364_BricenoVilches, [getFlowId/2,getFlowOptions/2,getFlowMsg/2, verificarFlowsRepetidos/4, encontrarFlow/3]).

%TDA capa Selectores


%Dom: Flow (list) X Id (int)
%Meta Principal: getFlowId/2
%Meta Secundaria: NA
%Encuentra en una lista flow su Id.

getFlowId([Id | _], Id).


%Dom: Flow (list) X Options (list)
%Meta Principal: getFlowOptions/2
%Meta Secundaria: NA
%Encuentra en una lista flow su lista de opciones.

getFlowOptions([_,_,Options], Options).


%Dom: Flow (list) X Msg (string)
%Meta Principal: getFlowMsg/2
%Meta Secundaria: NA
%Encuentra en una lista flow su Msg

getFlowMsg([_,Msg,_], Msg).



%TDA capa Pertenencia

% Dom: Flows (list) X AccIdFlow (list) X AccFlows (list) X ListaSalida
% (list)
% Meta Principal: verificarOpRepetidas/4 Meta Secundaria: 1) NA.
% 2) getFlowId/2, \+member/2, append/3, verificarFlowsRepetidos/4.
% Verifica que una lista de flows no tenga repetido ninguno en base a
% sus ID, si hay uno repetido retorna false.

% 1) Caso Base, cuando se vacía la lista de Flows Unifica la lista de
% Flows Acumulados con la lista de salida.
verificarFlowsRepetidos([], _, AccFlows, AccFlows).
% 2) Caso en donde no se encuentra el Id del Flow en la AccIdFlow por lo
% tanto se añaden los flows a AccFlows de manera recursiva
verificarFlowsRepetidos([FlowParaAgregar | RestoFlows], AccIdFlow, AccFlows, ListaSalida) :-
    getFlowId(FlowParaAgregar, Id),
    \+ member(Id, AccIdFlow),
    append(AccFlows, [FlowParaAgregar], AccFlowsNew),
    verificarFlowsRepetidos(RestoFlows, [Id | AccIdFlow], AccFlowsNew, ListaSalida).


%Dom: InitialFlowId (int) X Flows (list) X FlowEncontrado (list)
%Meta Principal: encontrarFlow/3
% Meta Secundaria: 1) fail
% 2) getFlowId/2, InitialFlowId = FlowId, FlowEncontrado = Flow,
% encontrarFlow/3
% Predicado que dado un Id de Flow busca si existe un Flow con el mismo
% Id en una lista de Flows.


% 1) Caso Base, si la lista se vacía y no logra encontrar una opcion
% correspondiente, retorna false.
encontrarFlow(_, [], _):- fail.
% 2) Busca recusivamente en la lista de flows anta encontrar un Flow con
% la misma Id dada.
encontrarFlow(InitialFlowId, [Flow | RestoFlows], FlowEncontrado):-
    getFlowId(Flow, FlowId),
    (InitialFlowId = FlowId,
     FlowEncontrado = Flow);
    encontrarFlow(InitialFlowId, RestoFlows, FlowEncontrado).




