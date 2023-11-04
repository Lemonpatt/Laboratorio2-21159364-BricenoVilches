:- module(tdaFlow_21159364_BricenoVilches, [getFlowId/2,getFlowOptions/2,getFlowMsg/2, eliminarFlowsRepetidos/4]).

getFlowId([Id | _], Id).

getFlowOptions([_,_,Options], Options).
getFlowMsg([_,Msg,_], Msg).

eliminarFlowsRepetidos([], _, AccFlows, AccFlows).

eliminarFlowsRepetidos([FlowParaAgregar | RestoFlows], AccIdFlow, AccFlows, ListaSalida) :-
    getFlowId(FlowParaAgregar, Id),
    \+ member(Id, AccIdFlow),
    eliminarFlowsRepetidos(RestoFlows, [Id | AccIdFlow], [FlowParaAgregar | AccFlows], ListaSalida).

eliminarFlowsRepetidos([FlowParaAgregar | RestoFlows], AccIdFlow, AccFlows, ListaSalida) :-
    getFlowId(FlowParaAgregar, Id),
    member(Id, AccIdFlow),
    eliminarFlowsRepetidos(RestoFlows, AccIdFlow, AccFlows, ListaSalida).
