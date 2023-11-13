:- module(tdaChatHistory_21159364_BricenoVilches, [crearChatHistory/5, vacioChatHistory/2, armarFechaTiempo/1]).


:- use_module(tdaUser_21159364_BricenoVilches).
:- use_module(tdaOption_21159364_BricenoVilches).
:- use_module(tdaFlow_21159364_BricenoVilches).
:- use_module(tdaChatbot_21159364_BricenoVilches).



%TDA capa Constructor

% Dom: LoggedUser (list) X Msg (string) X ChatbotEncontrado (list) X
% FlowEncontrado (list) X ChatHistory (string)
% Meta Principal: crearChatHistory/5
% Meta Secundaria: armarLineaUser/3, armarLineaChatbotFlujo/4,
% getFlowOptions/2, armarLineaOpciones/3, getUserChatHistory/2, concat/3
% Predicado que junta strings obteniendo el historial de chat de una
% interacción a un chatbot.

crearChatHistory(LoggedUser, Msg, ChatbotEncontrado, FlowEncontrado, ChatHistory):-
    armarLineaUser(LoggedUser,Msg,ChatHistoryUser),
    armarLineaChatbotFlujo(ChatHistoryUser, ChatbotEncontrado, FlowEncontrado, ChatHistorySalida),
    getFlowOptions(FlowEncontrado, Options),
    armarLineaOpciones(Options, ChatHistorySalida, ChatHistoryFinal),
    getUserChatHistory(LoggedUser, ChatHistoryLoggedUser),
    concat(ChatHistoryLoggedUser, ChatHistoryFinal, ChatHistoryActualizado),
    concat(ChatHistoryActualizado, "\n", ChatHistory).



%TDA capa Modificador

%Dom: Chathistory (string) X Chathistory (string)
%Meta Principal: vacioChatHistory/2
%Meta Secundaria: NA
% Predicado que verifica si un historial está vacío o no.
% 1) Caso donde el historial está vacío, devuelve un string "Historial
% Vacío" para poder representarlo de mejor manera.
vacioChatHistory("","Historial Vacío"):- !.
%2) En caso contrario se deja igual sin cambios.
vacioChatHistory(ChatHistory, ChatHistory).



%TDA capa Otros


%Dom: LoggedUser (list) X Msg (string) X ChatHistory (string)
%Meta Principal: armarLineaUser/3
% Meta Secundaria: Str = " - ", armarFechaTiempo/1, concat/3,
% getUserName/2, ChatHistory = ChatHistoryCompleto.
% Predicado que junta al string dado de ChatHistory una linea con la
% información del usuario y el mensaje dicho por este mismo

armarLineaUser(LoggedUser, Msg, ChatHistory):-
    Str = " - ",
    armarFechaTiempo(Tiempo),
    concat(Tiempo, Str, ChatHistory0),
    getUserName(LoggedUser, UserName),
    concat(ChatHistory0, UserName, ChatHistory1),
    concat(ChatHistory1, ": ", ChatHistory2),
    concat(ChatHistory2, Msg, ChatHistory3),
    concat(ChatHistory3, "\n", ChatHistoryCompleto),
    ChatHistory = ChatHistoryCompleto.

% Dom: ChatHistory0 (string) X ChatbotEncontrado (list) X FlowEncontrado
% (list) X ChatHistorySalida (string)
% Meta Principal: armarLineaChatbotFlujo/4
% Meta Secundaria: Str = " - ", armarFechaTiempo/1, concat/3
% getChatbotMsg/2, getFlowMsg/2
% Predicado que junta una nueva linea al ChatHistory con la información
% del chatbot y flujo al cual se comunica el usuario.

armarLineaChatbotFlujo(ChatHistory0, ChatbotEncontrado, FlowEncontrado, ChatHistorySalida):-
    Str = " - ",
    armarFechaTiempo(Tiempo),
    concat(Tiempo, Str, TiempoStr),
    concat(ChatHistory0, TiempoStr, ChatHistory),
    getChatbotMsg(ChatbotEncontrado, CBMsg),
    concat(ChatHistory, CBMsg, ChatHistory1),
    concat(ChatHistory1, ": ", ChatHistory2),
    getFlowMsg(FlowEncontrado, FlowMsg),
    concat(ChatHistory2, FlowMsg, ChatHistory3),
    concat(ChatHistory3, "\n", ChatHistoryCompleto),
    ChatHistorySalida = ChatHistoryCompleto.

%Dom: Options (list) X ChatHistoryAcc (string) X StrSalida (string)
%Meta Principal: armarLineaOpciones/3
%Meta Secundaria: 1) NA
% 2) getOpCode/2, concat/3, getOpMsg/2, encontrarOpString/2,
% armarLineaOpciones/3
% Predicado que revisa opcion por opcion juntando la informacion de cada
% una en un string el cual se añade al ChatHistory.

% 1) Caso base, cuando se vacían las opciones se unifica el string
% acumulado con el StrSalida.
armarLineaOpciones([],ChatHistoryOp, ChatHistoryOp).
% 2) En este caso se saca la informacion de cada opcion recursivamente
% haciendo un string que se acumula en ChatHistoryAcc.
armarLineaOpciones([Option | RestoOptions], ChatHistoryAcc, StrSalida):-
    getOpCode(Option, Code),
    concat(Code, ") ", Code1),
    getOpMsg(Option, Msg),
    encontrarOpString(Msg, Eleccion),
    concat(Code1, Eleccion, OpString),
    concat(OpString, "\n", OpString1),
    concat(ChatHistoryAcc, OpString1, ChatHistoryAccNew),
    armarLineaOpciones(RestoOptions, ChatHistoryAccNew, StrSalida).



%Dom: FechaTiempo (string)
%Meta Principal: armarFechaTiempo/1
%Meta Secundaria: get_time/1, stamp_date_time/3, format_time/3
% Predicado que transforma el stamp del tiempo en un formato fecha, con
% un UTC-4 de Chile.
armarFechaTiempo(FechaTiempo):-
    get_time(FechaCreacion0),
    stamp_date_time(FechaCreacion0, Tiempo, 10800),
    format_time(atom(FechaTiempo), '%Y/%m/%d %H:%M:%S', Tiempo).
