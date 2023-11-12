:- module(tdaSystem_21159364_BricenoVilches, [getSystemName/2, getSystemInitialCBLink/2, getSystemUsers/2, getSystemLoggedUser/2, getSystemChatbots/2, getSystemFechaCreacion/2, vacioLoggedUser/1, actualizarNuevoSystem/6,myRandom/2]).



%TDA capa Selectores


%Dom: System (list) X Name (string)
%Meta Principal: getSystemName/2
%Meta Secundaria: NA
%Predicado que encuentra desde una lista system su Name

getSystemName([Name|_], Name).


%Dom: System (list) X InitialCBLink (int)
%Meta Principal: getSystemInitialCBLink/2
%Meta Secundaria: NA
%Predicado que encuentra desde una lista system su InitialCBLink

getSystemInitialCBLink([_,CBLink,_,_,_,_], CBLink).


%Dom: System (list) X Users (list)
%Meta Principal: getSystemUsers/2
%Meta Secundaria: NA
%Predicado que encuentra desde una lista system su lista de usuarios

getSystemUsers([_,_,Users,_,_,_], Users).


%Dom: System (list) X LoggedUser (list)
%Meta Principal: getSystemLoggedUser/2
%Meta Secundaria: NA
% Predicado que encuentra desde una lista system su lista del usuario
% logeado

getSystemLoggedUser([_,_,_,LoggedUser,_,_], LoggedUser).


%Dom: System (list) X FechaCreacion (symbol)
%Meta Principal: getSystemFechaCreacion/2
%Meta Secundaria: NA
%Predicado que encuentra desde una lista system su Fecha de Creacion

getSystemFechaCreacion([_,_,_,_,FechaCreacion,_],FechaCreacion).


%Dom: System (list) X Chatbots (list)
%Meta Principal: getSystemChatbots/2
%Meta Secundaria: NA
%Predicado que encuentra desde una lista system su lista de Chatbots

getSystemChatbots([_,_,_,_,_,Chatbots], Chatbots).



%TDA capa Modificador


% Dom: System (list) X CBLinkNew (int) X UserName (string) X ChatHistory
% (string) X ChatbotsActualizados (list) X NewSystem(list)
% Meta Principal: actualizarNuevoSystem/6
% Meta Secundaria: getSystemName/2, getSystemUsers/2,
% getSystemFechaCreacion/2, LoggedUser = [UserName, ChatHistory],  NewSystem = [Name, CBLinkNew, Users, LoggedUser, FechaCreacion, ChatbotsActualizados]
% Predicado que modifica un sistema con valores encontrados y creados en
% systemTalkRec.

actualizarNuevoSystem(System, CBLinkNew, UserName, ChatHistory, ChatbotsActualizados, NewSystem):-
    getSystemName(System, Name),
    getSystemUsers(System, Users),
    getSystemFechaCreacion(System, FechaCreacion),
    LoggedUser = [UserName, ChatHistory],
    NewSystem = [Name, CBLinkNew, Users, LoggedUser, FechaCreacion, ChatbotsActualizados].



%TDA capa Pertenencia

%Dom: System (list)
%Meta Principal: vacioLoggedUser/1
%Meta Secundaria: getSystemLoggedUser/2
% Predicado que verifica si un sistema tiene alguien logeado o no,
% retornado true o false.

vacioLoggedUser(System):-
    getSystemLoggedUser(System, []).



%TDA capa Otros

%Dom: Xn (int) X Xn1 (int)
%Meta Principal: myRandom/2
% Meta Secundaria: MulTemp is 1103515245 * Xn, SumTemp is MulTemp +
% 12345, Xn1 is SumTemp mod 2147483648
% Predicado que genera un número pseudo aleatorio para la creación de la
% Seed en systemSimulate
myRandom(Xn, Xn1):-
    MulTemp is 1103515245 * Xn,
    SumTemp is MulTemp + 12345,
    Xn1 is SumTemp mod 2147483648.

