:- module(tdaChatHistory_21159364_BricenoVilches, [crearChatHistory/5, vacioChatHistory/2, armarFechaTiempo/1]).


:- use_module(tdaUser_21159364_BricenoVilches).
:- use_module(tdaOption_21159364_BricenoVilches).
:- use_module(tdaFlow_21159364_BricenoVilches).
:- use_module(tdaChatbot_21159364_BricenoVilches).

crearChatHistory(LoggedUser, Msg, ChatbotEncontrado, FlowEncontrado, ChatHistory):-
    armarLineaUser(LoggedUser,Msg,ChatHistoryUser),
    armarLineaChatbotFlujo(ChatHistoryUser, ChatbotEncontrado, FlowEncontrado, ChatHistorySalida),
    getFlowOptions(FlowEncontrado, Options),
    armarLineaOpciones(Options, ChatHistorySalida, ChatHistoryFinal),
    getUserChatHistory(LoggedUser, ChatHistoryLoggedUser),
    concat(ChatHistoryLoggedUser, ChatHistoryFinal, ChatHistoryActualizado),
    concat(ChatHistoryActualizado, "\n", ChatHistory).



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

armarLineaOpciones([],ChatHistoryOp, ChatHistoryOp).
armarLineaOpciones([Option | RestoOptions], ChatHistoryAcc, StrSalida):-
    getOpCode(Option, Code),
    concat(Code, ") ", Code1),
    getOpMsg(Option, Msg),
    encontrarOpString(Msg, Eleccion),
    concat(Code1, Eleccion, OpString),
    concat(OpString, "\n", OpString1),
    concat(ChatHistoryAcc, OpString1, ChatHistoryAccNew),
    armarLineaOpciones(RestoOptions, ChatHistoryAccNew, StrSalida).


vacioChatHistory("","Historial Vacío"):- !.
vacioChatHistory(ChatHistory, ChatHistory).


armarFechaTiempo(FechaTiempo):-
    get_time(FechaCreacion0),
    stamp_date_time(FechaCreacion0, Tiempo, 10800),
    format_time(atom(FechaTiempo), '%Y/%m/%d %H:%M:%S', Tiempo).
