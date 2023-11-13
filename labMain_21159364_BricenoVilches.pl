

% RF 1: Aquí se ven los 6 TDAs pedidos, que han sido creados y añadidos
% para su uso en un Código principal, cada uno de estos TDAs está
% separado por sus capas para cada predicado y estos solo contienen los
% necesarios para la implementación del laboratorio.

:- use_module(tdaOption_21159364_BricenoVilches).
:- use_module(tdaFlow_21159364_BricenoVilches).
:- use_module(tdaChatbot_21159364_BricenoVilches).
:- use_module(tdaSystem_21159364_BricenoVilches).
:- use_module(tdaUser_21159364_BricenoVilches).
:- use_module(tdaChatHistory_21159364_BricenoVilches).


%RF 2: TDA Option - constructor
% Dom: Code (int) X Message (string) X ChatbotCodeLink (int) X
% InitialFlowCodeLink (int) X Keywords (list) X Option (list). Meta
% Meta Principal: option/6
% Meta Secundaria: NA.
% Predicado constructor de una opción para flujo de un chatbot. Cada
% opción se enlaza a un chatbot y flujo especificados por sus
% respectivos códigos.

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
% Meta Secundaria: getFlowOptions/2 append/3,verificarOpRepetidas/4,getFlowMsg/2,getFlowId/2,
% NewFlow=[Id,Msg,OptionsNoDuplicados]
% Predicado que añade una opcion nueva a un flujo, retorna falso si la
% Id de la opción dada ya se encuentra en el Flow

flowAddOption(Flow, Option, NewFlow):-
    getFlowOptions(Flow, Options),
    append(Options, [Option], Options1),
    verificarOpRepetidas(Options1, [], [], OptionsNoDuplicados),
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
% Meta Secundaria: getChatbotFlow/2,append/3 verificarFlowsRepetidos/4,
% getChatbotId/2, getChatbotName/2, getChatbotMsg/2,
% getChatbotStartFlowId/2, NewChatbot = [ChatbotId, Name,
% WelcomeMessage, StartFlowId,FlowsNoDuplicados]
% Predicado modificador para añadir un flujo nuevo con ID única a un
% chatbot al final de la lista de flows, si ID no es única retorna false

chatbotAddFlow(Chatbot, Flow, NewChatbot) :-
    getChatbotFlows(Chatbot, Flows),
    append(Flows, [Flow], Flows1),
    %Añade al final de la lista de flows con recursión de cola:
    verificarFlowsRepetidos(Flows1, [], [], FlowsNoDuplicados), %Verifica que no se repita la Id de flows, si se repite el resultado es false.
    getChatbotId(Chatbot, ChatbotId),
    getChatbotName(Chatbot, Name),
    getChatbotMsg(Chatbot, WelcomeMessage),
    getChatbotStartFlowId(Chatbot, StartFlowId),
    NewChatbot = [ChatbotId, Name, WelcomeMessage, StartFlowId,FlowsNoDuplicados].


%RF 7: TDA system - constructor
% Dom: Name (string) X InitialChatbotCodeLink (int) X ChatbotsBase
% (list) X system (list)
% Meta Principal: system/4
% Meta Secundaria: verificarChatbotsRepetidos/4, armarFechaTiempo/1.
% Predicado constructor de un sistema de chatbots. Deja registro de la
% fecha de creación, si los chatbots dados no tienen Ids unicas da false
% Se añade a la lista System una lista de usuarios y una lista que
% contiene al usuario logeado

system(Name, InitialChatbotCodeLink, ChatbotsBase, [Name, InitialChatbotCodeLink, [], [],FechaCreacion, ChatbotsNoDuplicados]):-
    verificarChatbotsRepetidos(ChatbotsBase, [], [], ChatbotsNoDuplicados),
    armarFechaTiempo(FechaCreacion).


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
    append(Chatbots, [Chatbot], Chatbots1),
    verificarChatbotsRepetidos(Chatbots1, [], [], ChatbotsNoDuplicados),
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
% Meta Secundaria: getSystemUsers/2, encontrarUser/3,
% vacioLoggedUser/1,getSystemName/2, getSystemInitialCBLink/2,
% getSystemChatbots/2, getSystemFechaCreacion/2, NewSystem = [Name,
% CBLink, Users, UserEncontrado, FechaCreacion, Chatbots].
% Predicado que busca el nombre de un usuario dentro de la lista de
% usuarios del sistema dado y hace una instancia de este en la lista
% de usuarios logeados, retorna false en casos donde ya haya alguien
% logeado o no exista el usuario.

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
% Predicado que en el caso que haya alguien logeado, lo devuelve a la
% lista de usuarios con un posible historial de chat nuevo y elimina la
% instancia desactualizada anterior de la lista, vacía la lista logged
% user. En caso contrario retorna falso.

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

%RF 12: TDA system - modificador
% Dom: System (list) X Message (string) X NewSystem (list)
% Meta Principal: systemTalkRec/3
% Meta Secundaria:\+vacioLoggedUser/2, getSystemLoggedUser/2,
% getSystemInitialCBLink/2, getSystemChatbots/2, encontrarChatbot/3,
% getChatbotStartFlowId/2, getChatbotFlows/2, encontrarFlow/3,
% getFlowOptions/2, encontrarMsgOp/3, crearChatHistory/5,
% getOpChatbotCodeLink/2, getOpInitialFlowLink/2,
% cambiarFlowCodeChatbot/3, getChatbotFlows/2, actualizarChatbots/4,
% getUserName/2, actualizarNuevoSystem/5.
% Predicado que permite interactuar con un Chatbot, recibe un sistema y
% es dirigido a su chatbot inicial, luego el chatbot redirige al flow
% inicial, en donde buscamos el mensaje dado en las opciones del flow,
% si existe toma los links de la opcion que cambiarán cual será el
% chatbot inicial del sistema y flow inicial de ese chatbot. En caso de
% no encontrar el mensaje, si donde redirigen los initialCodeLinks del
% sistema no se encuentran o los Links de la opcion no existen entonces
% retorna false.
%
systemTalkRec(System, Msg, NewSystem):-
    (\+vacioLoggedUser(System), %Tiene que haber alguien logeado en el system
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
    actualizarNuevoSystem(System, CBLinkNew, User, ChatHistory, ChatbotsActualizados, NewSystem));

    %En caso de que el mensaje no se encuentre en las opciones
    (\+vacioLoggedUser(System), %Tiene que haber alguien logeado en el system
    getSystemLoggedUser(System, LoggedUser),
    getSystemInitialCBLink(System, CBLink),
    getSystemChatbots(System, Chatbots),
    encontrarChatbot(CBLink, Chatbots, ChatbotEncontrado),
    getChatbotStartFlowId(ChatbotEncontrado, InitialFlowId),
    getChatbotFlows(ChatbotEncontrado, Flows),
    encontrarFlow(InitialFlowId, Flows, FlowEncontrado),
    getFlowOptions(FlowEncontrado, Options),
    \+encontrarMsgOp(Msg,Options, _),
    crearChatHistory(LoggedUser, Msg, ChatbotEncontrado, FlowEncontrado, ChatHistory),
    getUserName(LoggedUser, User),
    actualizarNuevoSystem(System, CBLink, User, ChatHistory, Chatbots, NewSystem)
).


%RF 13: TDA system - otro
% Dom: System (list) X Username (string) X ChatHistory (string)
% Meta Primaria: systemSynthesis/3
% Meta Secundaria: vacioLoggedUser/1, getSystemUsers/2, encontrarUser/3,
% getUserChatHistory/2, vacioChatHistory/2,
% \+vacioLoggedUser/1, getSystemLoggedUser/1.
% Predicado que muestra en consola el Historial de Chat de un usuario
% dado, primero busca si ese usuario está logeado, ya que será el
% historial más actualizado, si no está lo busca en la lista de usuarios
% y muestra ese historial, en caso que tampoco esté retorna false.
%
systemSynthesis(System, Username, ChatHistory):-
    (\+vacioLoggedUser(System),
     getSystemLoggedUser(System, User),
     encontrarUser(Username, [User], UserEncontrado),
     getUserChatHistory(UserEncontrado, ChatHistoryRevisar),
     vacioChatHistory(ChatHistoryRevisar, ChatHistory));
        (%Si no esta el usuario logeado entonces el historial mas actualizado del usuario buscado estará en la lista de Users
     getSystemUsers(System, Users),
     encontrarUser(Username, Users, UserEncontrado),
     getUserChatHistory(UserEncontrado, ChatHistoryRevisar),
     vacioChatHistory(ChatHistoryRevisar, ChatHistory)).



%RF 14: TDA system - modificador
% Dom: System (list) X MaxInteractions (int) X Seed (int) X NewSystem(list)
% Meta Principal: systemSimulate/4
% Meta Secondaria: MaxInteractions =:= 0, NewSystem = System,
% number_chars/2, systemTalkRec/3, myRandom/2, MaxInteractionsNueva is
% MaxInteractions - 1, systemSimulate/4, vacioLoggedUser/1, concat/3,
% systemAddUser/3, systemLogin/3.
% Predicado que simula una conversacion con un chatbot dentro de un
% sistema con alguien logeado, la cantidad de veces que el usuario
% interactúa con el sistema es dado por MaxInteractions y lo que se
% pregunta en cada interacción es dado por los numeros de Seed.


systemSimulate(System, MaxInteractions, Seed, NewSystem):-
    %Caso para terminar el ciclo
    (MaxInteractions =:= 0,
    NewSystem = System);
    (\+vacioLoggedUser(System),
     number_chars(Seed, [PrimerDigitoStr|_]),
     systemTalkRec(System, PrimerDigitoStr, SystemActualizado),
     myRandom(Seed,SeedNueva),
     MaxInteractionsNueva is MaxInteractions - 1,
     systemSimulate(SystemActualizado, MaxInteractionsNueva, SeedNueva, NewSystem));
    %Aqui se realiza el caso en que no haya nadie logeado en el sistema, por lo tanto se crea un usuario solo para la emulación
    (vacioLoggedUser(System),
     number_chars(Seed, [PrimerDigitoStr|_]),
     concat("userSimulado", Seed, AñadirUser),
     systemAddUser(System, AñadirUser, System1),
     systemLogin(System1, AñadirUser, System2),
     number_chars(Seed, [PrimerDigitoStr|_]),
     systemTalkRec(System2, PrimerDigitoStr, SystemActualizado),
     myRandom(Seed,SeedNueva),
     MaxInteractionsNueva is MaxInteractions - 1,
     systemSimulate(SystemActualizado, MaxInteractionsNueva, SeedNueva, NewSystem));
    (myRandom(Seed,SeedNueva),
    systemSimulate(System, MaxInteractions, SeedNueva, NewSystem)).





