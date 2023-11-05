:- use_module(tdaOption_21159364_BricenoVilches).


option(Code, Message , CodeLink, InitialFlowCode, Keywords, [Code, Message, CodeLink, InitialFlowCode, Keywords]).



flow(Id, NameMessage, OptionsBase, [Id, NameMessage, OptionsNoDuplicados]):-
    eliminarOpRepetidas(OptionsBase, [],[], OptionsNoDuplicados).


flowAddOption(Flow, Option, NewFlow):-
    getFlowOptions(Flow, Options),
    eliminarOpRepetidas([Option|Options], [], [], OptionsNoDuplicados),
    getFlowMsg(Flow, Msg),
    getFlowId(Flow, Id),
    NewFlow = [Id, Msg, OptionsNoDuplicados].

