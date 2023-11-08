:- module(tdaSystem_21159364_BricenoVilches, [getSystemName/2, getSystemInitialCBLink/2, getSystemUsers/2, getSystemLoggedUser/2, getSystemChatbots/2, getSystemFechaCreacion/2, vacioLoggedUser/1]).

getSystemName([Name|_], Name).

getSystemInitialCBLink([_,CBLink,_,_,_,_], CBLink).

getSystemUsers([_,_,Users,_,_,_], Users).

getSystemLoggedUser([_,_,_,LoggedUser,_,_], LoggedUser).

getSystemChatbots([_,_,_,_,_,Chatbots], Chatbots).

getSystemFechaCreacion([_,_,_,_,FechaCreacion,_],FechaCreacion).

vacioLoggedUser(System):-
    getSystemLoggedUser(System, []).
