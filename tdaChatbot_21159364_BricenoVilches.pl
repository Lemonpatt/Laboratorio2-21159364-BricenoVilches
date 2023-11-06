:- module(tdaChatbot_21159364_BricenoVilches, [getChatbotId/2, getChatbotName/2, getChatbotMsg/2, getChatbotStartFlowId/2, getChatbotFlows/2, verificarChatbotsRepetidos/4]).



getChatbotId([Id|_], Id).

getChatbotName([_,Name,_,_,_], Name).

getChatbotMsg([_,_,Msg,_,_], Msg).

getChatbotStartFlowId([_,_,_,StartId,_],StartId).

getChatbotFlows([_,_,_,_,Flows], Flows).

verificarChatbotsRepetidos([], _, AccChatbots, AccChatbots).

verificarChatbotsRepetidos([ChatbotParaAgregar|RestoChatbots], AccId, AccChatbots, ListaSalida) :-
    getChatbotId(ChatbotParaAgregar, Id),
    \+ member(Id, AccId),
    verificarChatbotsRepetidos(RestoChatbots, [Id|AccId], [ChatbotParaAgregar|AccChatbots], ListaSalida).
















