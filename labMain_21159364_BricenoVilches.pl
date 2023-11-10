
:- use_module(tdaOption_21159364_BricenoVilches).
:- use_module(tdaFlow_21159364_BricenoVilches).
:- use_module(tdaChatbot_21159364_BricenoVilches).
:- use_module(tdaSystem_21159364_BricenoVilches).
:- use_module(tdaUser_21159364_BricenoVilches).
:- use_module(tdaChatHistory_21159364_BricenoVilches).

%RF 2: TDA Option - constructor
% Dom: Code (int) X Message (string) X ChatbotCodeLink (int) X
% InitialFlowCodeLink (int) X Keywords (list) X Option (list). Meta
% Principal: option/6 Meta Secundaria: NA.

option(Code, Message , ChatbotCodeLink, InitialFlowCodeLink, Keywords, [Code, Message, ChatbotCodeLink, InitialFlowCodeLink, Keywords]).


%RF 3: TDA Flow - constructor
% Dom: Id (int) X NameMessage (string) X OptionsBase (list) X Flow
% (list)
% Meta Principal: flow/4
% Meta Secundaria: verificarOpRepetidas/4
% Predicado constructor de un flujo de un chatbot, verifica que la id de
% sus opciones sean únicas

flow(Id, NameMessage, OptionsBase, [Id, NameMessage, OptionsNoDuplicados]):-
    verificarOpRepetidas(OptionsBase, [],[], OptionsNoDuplicados).


%RF 4: TDA Flow - modificador
% Dom: Flow (list) X Option (list) X NewFlow (list)
% Meta Principal: flowAddOption/3
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
% Meta Principal: system/4
% Meta Secundaria: verificarChatbotsRepetidos/4, get_time/1.
% Predicado constructor de un sistema de chatbots. Deja registro de la
% fecha de creación, si los chatbots dados no tienen Ids unicas da false
% Se añade a la lista System una lista de usuarios y una lista que
% contiene al usuario logeado

system(Name, InitialChatbotCodeLink, ChatbotsBase, [Name, InitialChatbotCodeLink, [], [],FechaCreacion, ChatbotsNoDuplicados]):-
    verificarChatbotsRepetidos(ChatbotsBase, [], [], ChatbotsNoDuplicados),
    get_time(FechaCreacion).

%RF 8: TDA system - modificador
% Dom: System (list) X Chatbot (list) X NewSystem (list)
% Meta Principal: systemAddChatbot/3
% Meta Secundaria: getSystemChatbots/2, verificarChatbotsRepetidos/4,
% getSystemName/2, getSystemInitialCBLink/2, getSystemUsers/2,
% getSystemLoggedUser/2, getSystemLoggedUser/2,
% getSystemFechaCreacion/2, NewSystem = [Name, CBLink, Users, LoggedUser, FechaCreacion, ChatbotsNoDuplicados]
% Predicado modificador para añadir chatbots a un sistema, si la id de
% este chatbot se repite en el system dado, da false.

systemAddChatbot(System, Chatbot, NewSystem) :-
    getSystemChatbots(System, Chatbots),
    verificarChatbotsRepetidos([Chatbot | Chatbots], [], [], ChatbotsNoDuplicados),
    getSystemName(System, Name),
    getSystemInitialCBLink(System, CBLink),
    getSystemUsers(System, Users),
    getSystemLoggedUser(System, LoggedUser),
    getSystemFechaCreacion(System,FechaCreacion),
    NewSystem = [Name, CBLink, Users, LoggedUser, FechaCreacion, ChatbotsNoDuplicados].

%RF 9: TDA system - modificador
% Dom: System (list) X Username (string) X NewSystem (list)
% Meta Principal: systemAddUser/3
% Meta Secundaria: crearUser/2, getSystemUsers/2,
% verificarUserRepetidos/4, getSystemName/2, getSystemInitialCBLink/2,
% getSystemChatbots/2, getSystemLoggedUser/2,
% getSystemFechaCreacion/2, NewSystem = [Name, CBLink, NewUsers,
% LoggedUser, FechaCreacion, Chatbots].
% Predicado modificador para añadir usuarios a un sistema, solo agrega
% al usuario si el nombre de este no existe en el sistema.

systemAddUser(System, Username, NewSystem):-
    crearUser(Username, User),
    getSystemUsers(System, Users),
    verificarUserRepetidos([User|Users], [], [], NewUsers),
    getSystemName(System, Name),
    getSystemInitialCBLink(System, CBLink),
    getSystemChatbots(System, Chatbots),
    getSystemLoggedUser(System, LoggedUser),
    getSystemFechaCreacion(System,FechaCreacion),
    NewSystem = [Name, CBLink, NewUsers, LoggedUser, FechaCreacion, Chatbots].


%RF 10: TDA system - modificador
% Dom: System (list) X Username (string) X NewSystem (list)
% Meta Principal: systemLogin/3
systemLogin(System, Username, NewSystem):-
    getSystemUsers(System, Users),
    encontrarUser(Username, Users, UserEncontrado),
    vacioLoggedUser(System), %Verifica que no haya nadie logeado
    getSystemName(System, Name),
    getSystemInitialCBLink(System, CBLink),
    getSystemChatbots(System, Chatbots),
    getSystemFechaCreacion(System,FechaCreacion),
    NewSystem = [Name, CBLink, Users, UserEncontrado, FechaCreacion, Chatbots].


%RF 11: TDA system - modificador
% Dom: System (list) X NewSystem (list)
% Meta Principal: systemLogout/2
% Meta Secundaria: \+vacioLoggedUser/1, getSystemLoggedUser/2,
% getSystemUsers/2, actualizarUsers/4, getSystemName/2,
% getSystemInitialCBLink/2, getSystemChatbots/2,
% getSystemFechaCreacion/2, NewSystem = [Name, CBLink, UsersActualizada, [], FechaCreacion, Chatbots]
systemLogout(System, NewSystem):-
    \+ vacioLoggedUser(System),
    getSystemLoggedUser(System, UserActualizado),
    getSystemUsers(System, Users),
    actualizarUsers(UserActualizado, Users, [], UsersActualizada),
    getSystemName(System, Name),
    getSystemInitialCBLink(System, CBLink),
    getSystemChatbots(System, Chatbots),
    getSystemFechaCreacion(System,FechaCreacion),
    NewSystem = [Name, CBLink, UsersActualizada, [], FechaCreacion, Chatbots].

%RF 12: TDA system - otro
% Dom: System (list) X Message (string) X NewSystem (list)
% Meta Principal: systemTalkRec/3
% Meta Secundaria:\+vacioLoggedUser/2, getSystemLoggedUser/2,
% getSystemInitialCBLink/2, getSystemChatbots/2, encontrarChatbot/3,
% getChatbotStartFlowId/2, getChatbotFlows/2, encontrarFlow/3,
% getFlowOptions/2, encontrarMsgOp/3, crearChatHistory/5,
% getOpChatbotCodeLink/2, getOpInitialFlowLink/2,
% cambiarFlowCodeChatbot/3, getChatbotFlows/2, actualizarChatbots/4,
% getUserName/2, actualizarNuevoSystem/5.
%
%
systemTalkRec(System, Msg, NewSystem):-
    \+ vacioLoggedUser(System), %Tiene que haber alguien logeado en el system
    getSystemLoggedUser(System, LoggedUser),
    getSystemInitialCBLink(System, CBLink),
    getSystemChatbots(System, Chatbots),
    encontrarChatbot(CBLink, Chatbots, ChatbotEncontrado),
    getChatbotStartFlowId(ChatbotEncontrado, InitialFlowId),
    getChatbotFlows(ChatbotEncontrado, Flows),
    encontrarFlow(InitialFlowId, Flows, FlowEncontrado),
    getFlowOptions(FlowEncontrado, Options),
    encontrarMsgOp(Msg, Options, OptionEncontrada),
    crearChatHistory(LoggedUser, Msg, ChatbotEncontrado, FlowEncontrado, ChatHistory),
    getOpChatbotCodeLink(OptionEncontrada, CBLinkNew),
    encontrarChatbot(CBLinkNew, Chatbots, ChatbotACambiar),
    getOpInitialFlowCodeLink(OptionEncontrada, InitialFlowCodeLink),
    cambiarFlowCodeChatbot(ChatbotACambiar, InitialFlowCodeLink, ChatbotNuevo),
    getChatbotFlows(ChatbotNuevo, FlowsARevisar),
    encontrarFlow(InitialFlowCodeLink, FlowsARevisar, _), %Revisa que el nuevo Chatbot tenga el Flow al cual ahora se dirige
    actualizarChatbots(ChatbotNuevo, Chatbots, [], ChatbotsActualizados),
    getUserName(LoggedUser, User),
    actualizarNuevoSystem(System, CBLinkNew, User, ChatHistory, ChatbotsActualizados, NewSystem).




%Añadir eliminacion de duplicados y documentacion
% set_prolog_flag(answer_write_options,[max_depth(0)]),option(1,"1-viajar",2,1, ["viajar", "turistear", "conocer"],O1),option(2, "2 - estudiar",4, 3, ["aprender", "perfeccionarme"], O2),flow(1,"flujo 1:mensaje de prueba", [O1], F1), flowAddOption(F1, O2, F2),flow(2, "Flujo 1: mensaje de prueba", [ ], F3),chatbot(1, "chatbot", "Prueba1", 1, [F1], CB1), chatbotAddFlow(CB1, F3, CB2),chatbot(2, "chatbot Viajes", "Prueba2", 1, [F2], CB3),system("Sistema1", 1,[CB2], S1),systemAddChatbot(S1, CB3, S2), systemAddUser(S2, "user0", S3), systemAddUser(S3, "user1", S4),systemLogin(S3, "user1", S5), systemLogout(S5,S6).
%
%
%
%
%
% set_prolog_flag(answer_write_options,[max_depth(0)]),option(1,"1-viajar",2,1, ["viajar", "turistear", "conocer"],O1),option(2, "2-estudiar",4, 3, ["aprender", "perfeccionarme"], O2),flow(1,"flujo 1:mensaje de prueba", [O1], F1), flowAddOption(F1, O2, F2),flow(2, "Flujo 1: mensaje de prueba", [ ], F3),chatbot(1, "chatbot", "Prueba1", 1, [F2], CB1), chatbotAddFlow(CB1, F3, CB2),chatbot(2, "chatbot Viajes", "Prueba2", 1, [F2], CB3),system("Sistema1", 1,[CB2], S1),systemAddChatbot(S1, CB3, S2), systemAddUser(S2, "user0", S3), systemAddUser(S3, "user1", S4),systemLogin(S4, "user1", S5), systemLogout(S5,S6),systemTalkRec(S5, "Turistear", S7).

%Funciones auxiliares que tendrán su propio archivo.



