
:- use_module(tdaOption_21159364_BricenoVilches).
:- use_module(tdaFlow_21159364_BricenoVilches).
:- use_module(tdaChatbot_21159364_BricenoVilches).

%RF 2: TDA Option - constructor
% Dom: Code (int) X Message (string) X CodeLink (int) X InitialFlowCode
% (int) X Keywords (list) X Option (list).
% Meta Principal: option/6
% Meta Secundaria: NA.

option(Code, Message , CodeLink, InitialFlowCode, Keywords, [Code, Message, CodeLink, InitialFlowCode, Keywords]).


%RF 3: TDA Flow - constructor
%Dom: Id (int) X NameMessage (string) X OptionsBase (list) X Flow (list)
%Meta Principal: flow/4
%Meta Secundaria: verificarOpRepetidas/4
% Predicado constructor de un flujo de un chatbot, verifica que la id de
% sus opciones sean únicas

flow(Id, NameMessage, OptionsBase, [Id, NameMessage, OptionsNoDuplicados]):-
    verificarOpRepetidas(OptionsBase, [],[], OptionsNoDuplicados).


%RF 4: TDA Flow - modificador
%Dom: Flow (list) X Option (list) X NewFlow (list)
%Meta Principal: flowAddOption/3
% Meta Secundaria: getFlowOptions/2,verificarOpRepetidas/4,getFlowMsg/2,getFlowId/2,
% NewFlow=[Id,Msg,OptionsNoDuplicados]
% Predicado que añade una opcion nueva a un flujo, retorna falso si la Id
% de la opción dada ya se encuentra en el Flow

flowAddOption(Flow, Option, NewFlow):-
    getFlowOptions(Flow, Options),
    verificarOpRepetidas([Option|Options], [], [], OptionsNoDuplicados),
    getFlowMsg(Flow, Msg),
    getFlowId(Flow, Id),
    NewFlow = [Id, Msg, OptionsNoDuplicados].


%RF 5: TDA chatbot - constructor
% Dom: ChatbotId (int) X Name (string) X WelcomeMessage (string) X
% StartFlowId (int) X FlowsBase (list) X Chatbot (list)
% Meta Principal: chatbot/6
% Meta Secundaria: verificarFlowsRepetidos/4
% Predicado constructor de un chatbot, retorna falso si flujos tienen Id
% repetidas

chatbot(ChatbotId, Name, WelcomeMessage,StartFlowId,FlowsBase, [ChatbotId, Name, WelcomeMessage,StartFlowId,FlowsNoDuplicados]):-
    verificarFlowsRepetidos(FlowsBase, [], [], FlowsNoDuplicados).

%RF 6: TDA chatbot - modificador
% Dom: Chatbot (list) X Flow (list) X NewChatbot (list)
% Meta Principal: chatbotAddFlow/3
% Meta Secundaria: getChatbotFlow/2, verificarFlowsRepetidos/4,
% getChatbotId/2, getChatbotName/2, getChatbotMsg/2,
% getChatbotStartFlowId/2, NewChatbot = [ChatbotId, Name,
% WelcomeMessage, StartFlowId,FlowsNoDuplicados]
% Predicado modificador para añadir un flujo nuevo con ID única a un
% chatbot al final de la lista de flows, si ID no es única retorna false

chatbotAddFlow(Chatbot, Flow, NewChatbot) :-
    getChatbotFlows(Chatbot, Flows),
    %Añade al final de la lista de flows con recursión de cola:
    verificarFlowsRepetidos([Flow|Flows], [], [], FlowsNoDuplicados), %Verifica que no se repita la Id de flows, si se repite el resultado es false.
    getChatbotId(Chatbot, ChatbotId),
    getChatbotName(Chatbot, Name),
    getChatbotMsg(Chatbot, WelcomeMessage),
    getChatbotStartFlowId(Chatbot, StartFlowId),
    NewChatbot = [ChatbotId, Name, WelcomeMessage, StartFlowId,FlowsNoDuplicados].


%RF 7: TDA system - constructor
% Dom: Name (string) X InitialChatbotCodeLink (int) X ChatbotsBase
% (list) X system (list)
% Meta Principal: system/6
% Meta Secundaria: verificarChatbotsRepetidos/4, get_time/1.
% Predicado constructor de un sistema de chatbots. Deja registro de la
% fecha de creación, si los chatbots dados no tienen Ids unicas da false
% Se añade a la lista System una lista de usuarios y una lista que
% contiene al usuario logeado

system(Name, InitialChatbotCodeLink, ChatbotsBase, [Name, InitialChatbotCodeLink, [], [],FechaCreacion, ChatbotsNoDuplicados]):-
    verificarChatbotsRepetidos(ChatbotsBase, [], [], ChatbotsNoDuplicados),
    get_time(FechaCreacion).

