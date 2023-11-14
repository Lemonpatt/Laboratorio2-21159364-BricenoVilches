% Script de pruebas del enunciado.
% Este debe ser copiado y pegado en la consola de SWI-Prolog despues de
% hacer un consult a labMain para cargar los predicados.

% Los ejemplos con su explicación estarán al final usando este script
% como base para demostrar el funcionamiento de los predicados

% Cabe recalcar que siempre se debe copiar y pegar desde esta primera
% consulta hasta donde se desee simplemente cambiando la coma por un
% punto en la ultima consulta.


option(1, "1-Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2-Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false,porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11

%Chatbot1
option(1, "1-New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2-París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3-Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4-Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),


%Opciones segundo flujo Chatbot1
option(1, "1-Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2-Museos", 1, 2, ["Museo"], OP8),
option(3, "3-Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4-Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1-Solo", 1, 3, ["Solo"], OP11),
option(2, "2-En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3-En familia", 1, 3, ["Familia"], OP13),
option(4, "4-Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5-En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),


%Chatbot2
option(1, "1-Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2-Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3-Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10),
systemTalkRec(S10, "hola", S11),
systemTalkRec(S11, "1", S12),
systemTalkRec(S12, "1", S13),
systemTalkRec(S13, "Museo", S14),
systemTalkRec(S14, "1", S15),
systemTalkRec(S15, "3", S16),
systemTalkRec(S16, "5", S17),
systemSynthesis(S17, "user2", Str1),
systemSimulate(S3, 5, 32131, S99).











% ------------------------------------------------------------------------%











% Ejemplos (Importante, se debe copiar desde la primera consulta para
% que este script de prueba funcione)

%COPIAR DESDE AQUI Y VER LOS EJEMPLOS AÑADIDOS ABAJO

% La repetición del codigo de arriba en sí no es tan necesaria pero
% sirve para mostrar menos cosas en la consola y ordenar más el script
% de pruebas.

set_prolog_flag(answer_write_options,[max_depth(0)]),
option(1, "1-Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2-Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0),
%Chatbot1
option(1, "1-New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2-París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3-Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4-Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),


%Opciones segundo flujo Chatbot1
option(1, "1-Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2-Museos", 1, 2, ["Museo"], OP8),
option(3, "3-Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4-Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1-Solo", 1, 3, ["Solo"], OP11),
option(2, "2-En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3-En familia", 1, 3, ["Familia"], OP13),
option(4, "4-Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5-En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),


%Chatbot2
option(1, "1-Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2-Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3-Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),



%-------------------------------------------------------
%EJEMPLOS USANDO COMO BASE EL SCRIPT DE PRUEBAS ANTERIOR
%RF 2: creación de opciones

%se crean opciones para posteriormente usarlas en los ejemplos

option(3, "3-Ver redes sociales", 3, 1, ["Contactos", "Plataformas", "Redes", "redes sociales"], OP19),
option(1, "1-Whatsapp", 3, 1, ["wsp"], OP20),
option(2, "2-Twitter", 3, 1, ["X"], OP21),
option(3, "3-Facebook", 3, 1, ["Meta", "Face"], OP22),
option(4, "4-Volver", 0, 1, ["Regresar", "Salir"], OP23),


%RF 3: Creación de Flows


%Creamos un flow con las opciones anteriores
flow(1, "Flujo 1 Chatbot 3\nElije que red social visitar", [OP20,OP21,OP22,OP23], F1),

%Creamos un flow vacío sin opciones
flow(4, "Ejemplo Flow Vacío", [], FVacio),

%Un ejemplo en donde el predicado flow retornará false
% flow(1, "Flujo Prueba", [OP20, OP20, OP21], FPrueba), %Aquí retorna false debido a que OP20, OP20 son el mismo flow, por lo tanto no es realizable


%flow(1, "Flujo Prueba 2", [OP19, OP23, OP21, OP22], FPrueba2), %Retorna false debido a que OP19 y OP22 tienen la misma Id demostrando que si se hace en base a la Id

%RF 4: Añadir opción a un flow

%Añade sin problemas a un flow vacío
flowAddOption(FVacio, OP22, FVacioAdd),

% Intentamos añadir la opcion 19 pero esta tiene la id repetida en F1
% por lo que retorna false
%flowAddOption(F1, OP19, F1Add),

% Añadimos otra vez una opcion al flow vacio para mostrar que queda
% añadido al final de la lista de opciones.
flowAddOption(FVacioAdd, OP23, FVacioAdd2),

%Actualizamos el flujo del enunciado
flowAddOption(F11, OP19, FNuevo),

%RF 5: Crear chatbots

%Ejemplo de creacion de Chatbot
chatbot(3, "Redes", "Bienvenido\n¿Dónde quieres ir?", 1, [F1], CB11),

%Chatbot vacío se crea sin problemas
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [], CB12),

%Ejemplo donde chatbot retorna false debido a ID repetidas
%chatbot(1, "test", "CB id Repetida", 1, [F1, FPrueba], CB13),

%RF 6: Añadir flow a chatbot

% Añadimos la opcion creada anteriormente al chatbot inicial del ejemplo
% con la idea de recrearlo con más opciones
chatbotAddFlow(CB12,FNuevo, CB14),

%retorna false ya que ya se encuentra dentro un flow con la misma id
%chatbotAddFlow(CB11, FPrueba, CB15),

% Ejemplo de flow siendo añadido al final de la lista (REQUISITO, ver
% flujo vacío añadido al final)
chatbotAddFlow(CB1, FVacio, CB16),


%RF 7: Crear sistema

%Se crea un sistema vacío correctamente
system("SistemaVacio", 0, [], SVacio),

%Creamos un sistema para usarlo como ejemplo despues
system("Chatbots Ejemplo", 0, [CB11], S0Redes),

%Sistema que retorna false por los chatbots con Id repetida
%system("Chatbot Id Repetidas", 0, [CB12, CB14], SError),

%RF 8: Añadir chatbots a un sistema

%Se añade chatbots usando el sistema de ejemplo

systemAddChatbot(S0Redes, CB14, S1New),

%Retorna false debido a que el id se repite dentro
%systemAddChatbot(S1New, CB0, S1Ej),

%Añadimos un chatbot para la implementación.
systemAddChatbot(S1New, CB1, S1New1),

% Como se puede observar en la resolucion quedan desordenados pero esto
% no es importante para la resolución
systemAddChatbot(S1New1, CB2, S1New2),


%RF 9: Añadir un usuario al sistema

%Añadimos un usuario sin problemas a la lista
systemAddUser(S1New2, "admin", S1User),

%Se añade otro usuario sin importar el orden
systemAddUser(S1User, "user1", S1User1),

%Retorna false debido a que el usuario a añadir existe
%systemAddUser(S1User1, "admin", S1User2),

%Retorna false debido a que las id de nombre son case insensitive
%systemAddUser(S1User1, "UsEr1", S1User3),

%Creado para un error subsecuente
systemAddUser(S0Redes, "admin", SEjError),
%RF 10: logear usuario en un sistema

% Logea al usuario admin, colocandolo dentro de la lista de usuarios logeados
systemLogin(S1User1, "ADMIN", S1Login),

% Intenta logear al sistema sin nadie logeado un usuario que no existe
% en el sistema por lo que retorna false
%systemLogin(S1User1, "user2", S1Login1),

% Intenta logear al user1 el cual existe en el sistema pero como hay
% alguien logeado ya, retorna false.
%systemLogin(S1Login, "user1", S1Login2),

%Creado para mostrar un error subsecuente
systemLogin(SEjError, "admin", SEjError1),



%RF 11: Deslogear a un usuario logeado en el sistema

%Deslogea al sistema con el admin logeado
systemLogout(S1Login, S1Logout),

%Intenta deslogear un sistema con nadie logeado, retorna false
%systemLogout(S1Logout, S1Logout2),

% Algo muy importante de esta funcion es que guarda todo el historial de
% un usuario que haya interactuado con un chatbot, el ejemplo estará mas
% adelante en systemTalkRec


%RF 12: Interactuar con un sistema de chatbots

% Se intenta interactuar con un sistema que no tiene nadie logeado, por
% lo que retorna false
%systemTalkRec(S1Logout, "hola", S1Fail),

% Esto da un error porque este sistema específico no tiene a ningún
% chatbot o flow al cual dirigirse
%systemTalkRec(SEjError1, "1", SEjError2).

% A este predicado en realidad no le importa recibir un mensaje que no
% sea nada especifico, lo unico que causa que este predicado retorne
% false es que una opcion elegida no lleve a nada, o que no haya nadie
% logeado. Esto se consideró para poder guardar todas las interacciones
% en el historial.
systemTalkRec(S1Login, "hola", S21),


% Se usan strings del op code, su mensaje, o keywords para demostrar que
% no importan si estan en mayusculas o minusculas, todas estas estan
% ligadas a una opcion menos la ultima

systemTalkRec(S21, "ver REDES sociales", S22),
systemTalkRec(S22, "WSP", S23),
systemTalkRec(S23, "4", S24),
systemTalkRec(S24, "1", S25),
systemTalkRec(S25, "reGResar", S26),
systemTalkRec(S26, "Ver estado Final", Sfin),


%RF 13: Mostrar historial de usuario dentro del sistema

%Mostramos el string de lo hecho anteriormente con systemTalkRec
systemSynthesis(Sfin, "Admin", Str2),

% Mostramos tambien el historial vacío del otro usuario dentro del
% sistema (puede comentar los otros synthesis para verlo de mejor
% manera)
systemSynthesis(Sfin, "user1", Str3),


% Ahora con el ejemplo anterior mostramos que systemLogout es capaz de
% guardar el historial por lo que deberia quedar Str2=Str4

systemLogout(Sfin, Sfin1),

% Debido a que hay una igualdad de Str4 y Str2, Sfin1 se mostrará
% despues en la consola aunque esté definida antes.
systemSynthesis(Sfin1, "Admin", Str4),

%Arroja false ya que no está ese usuario en el sistema
%systemSynthesis(Sfin, "user2", Str5),


%RF 14: Simular una conversacion con los chatbots y un usuario.

% Primero explicando el funcionamiento de este predicado, este no
% necesita un usuario logeado para funcionar, ya que creará un
% "userSimulado"+Seed como usuario nuevo que guardará la interacción, de
% caso contrario el predicado asume que hay un usuario logeado ya que se
% quiere usar este para la simulación

%En este sistema esta el usuario "admin" logeado, simulará con este
systemSimulate(S1Login, 5, 25151, Sim),

% Este sistema ahora no tiene a nadie logeado por lo que creará un nuevo
% sistema.
systemSimulate(S1Logout, 5, 77282, Sim1),

% Este retornará el mismo sistema ya que no tiene iteraciones que hacer,
% también no creara un nuevo user.
% Queda igual a S1Logout, por lo que es dificil verlo en la consola, aún
% así no aparece al final por lo que eso sirve tambien para probar que
% su definicion se fue arriba en la consola.
systemSimulate(S1Logout, 0, 0, Sim2).
