:- module(tdaUser_21159364_BricenoVilches, [crearUser/2, getUserName/2, getUserChatHistory/2,verificarUserRepetidos/4, encontrarUser/3, actualizarUsers/4]).

%TDA capa Constructor

%Dom: UserName (string) X User (list)
%Meta Principal: crearUser/2
%Meta Secundaria: NA
%Predicado que crea una lista usuario dado un nombre
crearUser(UserName, [UserName, ""]). %Hace una lista de usuario para tener su nombre y historial de chat dentro de un sistema


%TDA capa Selector


%Dom: User (list) X Username (string)
%Meta Principal: getUserName/2
%Meta Secundaria: Na
%Predicado que encuentra el username de una lista User
getUserName([Username, _], Username).


%Dom: User (list) X ChatHistory (string)
%Meta Principal: getUserChatHistory/2
%Meta Secundaria: Na
%Predicado que encuentra el Historial de Chat de una lista user

getUserChatHistory([_, ChatHistory], ChatHistory).




%TDA Capa Modificadora

% Dom: UserActualizado (list) X Users (list) X AccUsuarios (list) X
% UsersActualizada (list)
% Meta Principal: actualizarUsers/4
% Meta Secundaria: 1) NA.
% 2) getUserName/2, downcase_atom/2, DWUserName1 = DWUserName2,
% actualizarUsers/4
% Predicado que modifica la lista de usuarios reemplazando un usuario
% actualizado dentro de la lista encontrando el mismo nombre.

% 1) Caso Base, Devolver lista Acumulada cuando se vacie la lista de usuarios
actualizarUsers(_, [], AccUsuarios, AccUsuarios).
% 2) Caso donde compara los nombres del usuario actualizado y el usuario
% sacado de la lista, si son iguales mete el usuario actualizado,
% reemplazando al anterior, recursivamente añadiento los anteriores y el
% resto.
actualizarUsers(UserActualizado, [UserParaAgregar | RestoUsers ], AccUsuarios, UsersActualizada):-
    getUserName(UserActualizado, UserName1),
    getUserName(UserParaAgregar, UserName2),
    downcase_atom(UserName1, DWUserName1),
    downcase_atom(UserName2, DWUserName2),
    (DWUserName1 = DWUserName2, actualizarUsers(UserActualizado, RestoUsers, [UserActualizado | AccUsuarios], UsersActualizada ));
    actualizarUsers(UserActualizado, RestoUsers, [UserParaAgregar | AccUsuarios], UsersActualizada).



%TDA Capa Pertenencia


% Dom: Users (list) X AccUserName (list), AccUsers (list) X ListaSalida
% (list)
% Meta Principal: verificarUserRepetidos/4
% Meta Secundaria: 1) NA
% 2) getUserName/2,downcase_atom/2, \+member/2, verificarUserRepetidos/4
% Predicado que verifica que ningún usuario se repita en una lista en
% base a sus nombres acumulando.

% 1) Caso base, Si se vacía la lista de usuarios entonces unifica la
% lista acumuladora de users con la lista de salida.
verificarUserRepetidos([], _, AccUsers, AccUsers).

% 2) Caso donde busca individualmente en cada user de la lista con
% recursion si sus nombres no pertenezcan a la lista acc de username,
% son añadidos a ambas listas acumuladoras y se sigue la recursion.
verificarUserRepetidos([User | RestoUsers], AccUserName, AccUsers, ListaSalida):-
    getUserName(User, UserName),
    downcase_atom(UserName, DWUserName),
    \+ member(DWUserName, AccUserName),
    verificarUserRepetidos(RestoUsers, [DWUserName|AccUserName], [User | AccUsers], ListaSalida).


%Dom: Username (string) X Users (list) X UserEncontrado (list)
%Meta Principal: encontrarUser/3
% Meta Secundaria: 1)NA
% 2)getUserName/2, downcase_atom/2, DWUsername =
% DWUsernameList, UserEncontrado = User, encontrarUser/3
% Predicado que encuentra un usuario dentro de una lista de usuarios
% dado el nombre de este.

% 1) Caso base, si la lista de usuarios se vacía entonces no encontró al
% usuario y retorna false.
encontrarUser(_, [], _):- fail.
% 2) Caso donde compara el nombre de cada usuario de la lista de manera
% recursiva hasta encontrar uno que tenga el mismo nombre del username
% dado al predicado.
encontrarUser(Username, [User | RestoUsers], UserEncontrado):-
    getUserName(User, UsernameList),
    downcase_atom(Username, DWUsername),
    downcase_atom(UsernameList, DWUsernameList),
    (DWUsername = DWUsernameList,
     UserEncontrado = User);
    encontrarUser(Username, RestoUsers, UserEncontrado).

