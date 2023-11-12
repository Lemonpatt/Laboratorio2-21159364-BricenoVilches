:- module(tdaChatbot_21159364_BricenoVilches, [getChatbotId/2, getChatbotName/2, getChatbotMsg/2, getChatbotStartFlowId/2, getChatbotFlows/2, verificarChatbotsRepetidos/4, encontrarChatbot/3, cambiarFlowCodeChatbot/3, actualizarChatbots/4]).


%TDA capa Selectores

%Dom: Chatbot(list) X Id (int)
%Meta Principal: getChatbotId/2
%Meta Secundaria: NA
%Predicado que encuentra en una lista Chatbot su Id

getChatbotId([Id|_], Id).


%Dom: Chatbot(list) X Name (string)
%Meta Principal: getChatbotName/2
%Meta Secundaria: NA
%Predicado que encuentra en una lista Chatbot su Name

getChatbotName([_,Name,_,_,_], Name).


%Dom: Chatbot(list) X Msg (string)
%Meta Principal: getChatbotMsg/2
%Meta Secundaria: NA
%Predicado que encuentra en una lista Chatbot su Msg

getChatbotMsg([_,_,Msg,_,_], Msg).


%Dom: Chatbot(list) X StartFlowId (int)
%Meta Principal: getChatbotStartFlowId/2
%Meta Secundaria: NA
%Predicado que encuentra en una lista Chatbot su StartFlowId

getChatbotStartFlowId([_,_,_,StartId,_],StartId).


%Dom: Chatbot(list) X Flows (list)
%Meta Principal: getChatbotFlows/2
%Meta Secundaria: NA
%Predicado que encuentra en una lista Chatbot su lista de flows

getChatbotFlows([_,_,_,_,Flows], Flows).



%TDA capa Modificadores


% Dom: ChatbotACambiar (list) X InitialFlowCodeLink (int) X ChatbotNuevo
% (list)
% Meta Principal: cambiarFlowCodeChatbot/3
% Meta Secundaria: getChatbotId/2, getChatbotName/2, getChatbotMsg/2,
% getChatbotFlows/2, ChatbotNuevo = [Id, Name, Msg, InitialFlowCodeLink,
% Flows].
% Predicado que modifica un Chatbot cambiando su InitialFlowCodeLink por
% uno dado.
%
cambiarFlowCodeChatbot(ChatbotACambiar, InitialFlowCodeLink, ChatbotNuevo):-
    getChatbotId(ChatbotACambiar, Id),
    getChatbotName(ChatbotACambiar, Name),
    getChatbotMsg(ChatbotACambiar, Msg),
    getChatbotFlows(ChatbotACambiar, Flows),
    ChatbotNuevo = [Id, Name, Msg, InitialFlowCodeLink, Flows].

% Dom: ChatbotActualizado(list) X Chatbots (list) X AccChatbots (list) X
% ChatbotsActualizados (list)
% Meta Principal: actualizarChatbots/4
% Meta Secundaria: 1) NA
% 2) getChatbotId/2, CbId1 = CbId2, actualizarChatbots/4
% Predicado que actualiza un chatbot específico dentro de una lista de
% chatbots con un chatbot con información actualizada.

% 1) Caso base, cuando la lista de chatbots esta vacía, Unifica la lista
% de chatbots acumulados con la lista de Salida.
actualizarChatbots(_, [], AccChatbots, AccChatbots).
% 2) Caso donde se va acumulando la lista de chatbots de forma
% recursiva, donde si la Id son iguales, entonces se agrega el
% chatbot actualizado al acumulador y no el de la lista de chatbots.
actualizarChatbots(ChatbotActualizado, [ChatbotParaAgregar | RestoChatbots ], AccChatbots, ChatbotsActualizados):-
    getChatbotId(ChatbotActualizado, CbId1),
    getChatbotId(ChatbotParaAgregar, CbId2),
    (CbId1 = CbId2, actualizarChatbots(ChatbotActualizado, RestoChatbots, [ChatbotActualizado | AccChatbots], ChatbotsActualizados ));
    actualizarChatbots(ChatbotActualizado, RestoChatbots, [ChatbotParaAgregar | AccChatbots], ChatbotsActualizados).



%TDA capa Pertenencia

% Dom: Chatbots (list) X AccId (list) X AccChatbots (list) X ListaSalida
% (list)
% Meta Principal: verificarChatbotsRepetidos/4
% Meta Secundaria: 1) NA.
% 2) getChatbotId/2, \+ member/2, append/3, verificarChatbotsRepetidos/4
% Predicado que verifica que una lista de chatbots no tenga ninguno
% repetido en base a sus Id

% 1) Caso base, cuando la lista de chatbots se vacía unifica el
% acumulador de chatbots a la lista de salida.
verificarChatbotsRepetidos([], _, AccChatbots, AccChatbots).
% 2) Añade de manera recursiva cada chatbot en la lista de
% chatbots al acumulador y sus Ids al acumulador de ids , siempre y
% cuando no se repita la id de un chatbot en el acum de Ids.
verificarChatbotsRepetidos([ChatbotParaAgregar|RestoChatbots], AccId, AccChatbots, ListaSalida) :-
    getChatbotId(ChatbotParaAgregar, Id),
    \+ member(Id, AccId),
    append(AccChatbots, [ChatbotParaAgregar], AccChatbotsNuevo),
    verificarChatbotsRepetidos(RestoChatbots, [Id|AccId], AccChatbotsNuevo, ListaSalida).


%Dom: CBLink (int) X Chatbots (list) X ChatbotEncontrado (list)
%Meta Principal: encontrarChatbot/3
%Meta Secundaria: 1) fail
% 2) getChatbotId/2, CBLink = ChatbotId, ChatbotEncontrado = Chatbot,
% encontrarChatbot/3
% Predicado que busca que exista un chatbot dentro de una lista de
% chatbots en base a su Id.

%1) Caso base, si la lista de chatbots se vacía entonces devuelve false
encontrarChatbot(_, [], _):- fail.
% 2) Caso donde se busca recursivamente de cola en la lista de chatbots
% que un chatbot individual tenga el mismo Id que el de la lista
encontrarChatbot(CBLink, [Chatbot | RestoChatbots], ChatbotEncontrado):-
    getChatbotId(Chatbot, ChatbotId),
    (CBLink = ChatbotId,
     ChatbotEncontrado = Chatbot);
    encontrarChatbot(CBLink, RestoChatbots, ChatbotEncontrado).

