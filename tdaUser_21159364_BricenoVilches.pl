:- module(tdaUser_21159364_BricenoVilches, [crearUser/2, getUserName/2, getUserChatHistory/2,verificarUserRepetidos/4, encontrarUser/3, actualizarUsers/4]).


crearUser(UserName, [UserName, ""]). %Hace una lista de usuario para tener su nombre y historial de chat dentro de un sistema

getUserName([Username, _], Username).

getUserChatHistory([_, ChatHistory], ChatHistory).

verificarUserRepetidos([], _, AccUsers, AccUsers).

verificarUserRepetidos([User | RestoUsers], AccUserName, AccUsers, ListaSalida):-
    getUserName(User, UserName),
    \+ member(UserName, AccUserName),
    verificarUserRepetidos(RestoUsers, [UserName|AccUserName], [User | AccUsers], ListaSalida).


encontrarUser(_, [], _):- fail.
encontrarUser(Username, [User | RestoUsers], UserEncontrado):-
    getUserName(User, UsernameList),
    downcase_atom(Username, DWUsername),
    downcase_atom(UsernameList, DWUsernameList),
    (DWUsername = DWUsernameList,
     UserEncontrado = User);
    encontrarUser(Username, RestoUsers, UserEncontrado).

% Caso Base, Devolver lista Acumulada cuando se vacie la lista de usuarios
actualizarUsers(_, [], AccUsuarios, AccUsuarios).
actualizarUsers(UserActualizado, [UserParaAgregar | RestoUsers ], AccUsuarios, UsersActualizada):-
    getUserName(UserActualizado, UserName1),
    getUserName(UserParaAgregar, UserName2),
    downcase_atom(UserName1, DWUserName1),
    downcase_atom(UserName2, DWUserName2),
    (DWUserName1 = DWUserName2, actualizarUsers(UserActualizado, RestoUsers, [UserActualizado | AccUsuarios], UsersActualizada ));
    actualizarUsers(UserActualizado, RestoUsers, [UserParaAgregar | AccUsuarios], UsersActualizada).
