!classDefinition: #CarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #CarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
CarolinaLaCurandera class
	instanceVariableNames: 'frasesPersonajePrometedor frasesPersonajeDesconocido cantidadDeInteraccionesPorPersonaje'!

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 12:32:01'!
interactuarCon: personajeJugadorAInteractuar
	| fraseAResponder |
	self recordarInteraccion: personajeJugadorAInteractuar.
	fraseAResponder := self responderSegunCantidadDeInteracciones: personajeJugadorAInteractuar.
	self verificarSiJugadorCompletoCantidadDeInteracciones: personajeJugadorAInteractuar.
	^fraseAResponder! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 01:03:15'!
olvidar
	cantidadDeInteraccionesPorPersonaje := Dictionary new.! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 11:52:59'!
reiniciarCantidadInteraccionesDeJugador: personajeJugadorAOlvidar
	cantidadDeInteraccionesPorPersonaje at: personajeJugadorAOlvidar put: 0.! !


!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'IA 10/4/2021 12:25:25'!
recordarInteraccion: personajeJugadorAInteractuar
	| cantidadInteracciones |
	cantidadInteracciones := (cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar ifAbsent: [ 0 ]) + 1.
	cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar put: cantidadInteracciones.
	
	! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'IA 10/4/2021 12:12:24'!
responderSegunCantidadDeInteracciones: personajeJugadorAInteractuar
	| personajeEsPrometedor cantidadDeInteracciones fraseJugadorPrometedor fraseJugadorDesconocido|
	
	personajeEsPrometedor := RiverwoodOpiniones obtenerSiPersonajeEsPrometedor: personajeJugadorAInteractuar.
	cantidadDeInteracciones := cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar.
	fraseJugadorPrometedor := frasesPersonajePrometedor at: (cantidadDeInteracciones min: frasesPersonajePrometedor size).
	fraseJugadorDesconocido := frasesPersonajeDesconocido at: (cantidadDeInteracciones min: frasesPersonajeDesconocido size).
	
	^ personajeEsPrometedor ifTrue: [ fraseJugadorPrometedor ] ifFalse: [ fraseJugadorDesconocido ]! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'IA 10/4/2021 12:32:01'!
verificarSiJugadorCompletoCantidadDeInteracciones: personajeJugadorAVerificarInteracciones
	| cantidadInteracciones |
	cantidadInteracciones := cantidadDeInteraccionesPorPersonaje at: personajeJugadorAVerificarInteracciones .
	(cantidadInteracciones = (frasesPersonajeDesconocido size)) ifTrue: [ RiverwoodOpiniones cambiarPersonajeAPrometedor: personajeJugadorAVerificarInteracciones ].! !


!CarolinaLaCurandera class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 12:33:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesPersonajePrometedor := #('Salud aventurero!!' 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme' ).
	frasesPersonajeDesconocido := #('¿Estás enfermo forastero?' 'Ah, solo quieres conversar' 'Cuando tengas una aflicción, ven a verme' ).
	cantidadDeInteraccionesPorPersonaje := ((Dictionary new) add: (#hamilton->0); yourself).! !


!classDefinition: #PruebasInteracionesConCarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConCarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConCarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConCarolinaLaCurandera class
	instanceVariableNames: ''!

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'IA 10/4/2021 02:13:51'!
test01CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:37'!
test02CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Ah, solo quieres conversar'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:49:16'!
test03CuandoLaCuranderaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Cuando tengas una aflicción, ven a verme'.! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:11'!
test04LaCuranderaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:18'!
test05LaCuranderaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:32'!
test06CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |	
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Salud aventurero!!'.
! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:39'!
test07CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme'.
! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/25/2021 12:50:52'!
test08CuandoLaCuranderaTerminaSuRepertorioDeFrasesConUnPersonajeCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedor
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert isTrue: (self esVistoPorElPuebloComoPrometedor: self hamilton).! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/30/2021 19:09:06'!
test09CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaSuHiloDeDialogoConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Salud aventurero!!'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/30/2021 19:08:45'!
test10CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaElHiloDeDialogoDelGuardiaConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	

	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Bienvenido aventurero!!'. ! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'IA 10/4/2021 01:47:50'!
carolinaLaCurandera
	^CarolinaLaCurandera ! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'IA 10/4/2021 01:47:11'!
hamilton
	^ #hamilton! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'IA 10/4/2021 01:51:13'!
tirion
	^ #tirion! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:52:20'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 11:03:58'!
esVistoPorElPuebloComoPrometedor: unPersonaje
	^RiverwoodOpiniones obtenerSiPersonajeEsPrometedor: unPersonaje.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 01:27:11'!
hacerQueLaCuranderaOlvideSusInteracciones
	CarolinaLaCurandera olvidar! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 11:03:07'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	RiverwoodOpiniones olvidarPersonajesPrometedores! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 11:03:18'!
hacerQueRiverwoodVeaPrometedorAHamilton
	RiverwoodOpiniones cambiarPersonajeAPrometedor: #hamilton.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:48:36'!
olvidarInteraccionesYOpiniones
	self hacerQueLaCuranderaOlvideSusInteracciones.	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PruebasInteracionesConTreborElGuardia category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConTreborElGuardia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConTreborElGuardia class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConTreborElGuardia class
	instanceVariableNames: ''!

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:03:53'!
test01CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:08'!
test02CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Todo bien?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:25'!
test03CuandoElGuardiaOlvidaInteraccionesPreviasConUnPersonajeAlVolverAInteractuarLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia olvidar.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:35'!
test04CuandoElGuardiaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:44'!
test05CuandoElGuardiaInterctuaYTerminoSuRepertorioDeFrasesConUnPersonajeLeRespondeConSuUltimaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:36'!
test06ElGuardiaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.

	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:43'!
test07ElGuardiaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Algún problema?'.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Algún problema?'.
	! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:54:46'!
test08CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Bienvenido aventurero!!'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:55:02'!
test09CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Espero que tengas una buena estadia en Riverwood'.
! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'IA 10/4/2021 00:56:37'!
hamilton
	^ #hamilton! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'IA 10/4/2021 00:56:31'!
tirion
	^ #tirion! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:42:44'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/21/2021 20:49:11'!
hacerQueElGuardiaOlvideSusInteracciones
	TreborElGuardiaDeSkyrim olvidar.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 10:53:31'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	RiverwoodOpiniones olvidarPersonajesPrometedores.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 10:53:42'!
hacerQueRiverwoodVeaPrometedorAHamilton
	RiverwoodOpiniones cambiarPersonajeAPrometedor: #hamilton.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'IA 10/4/2021 00:57:14'!
olvidarInteraccionesYOpiniones
	self hacerQueElGuardiaOlvideSusInteracciones. 	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #RiverwoodOpiniones category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #RiverwoodOpiniones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RiverwoodOpiniones class' category: 'Ejercicio1-PNJ-Episodio2'!
RiverwoodOpiniones class
	instanceVariableNames: 'personajesPrometedores'!

!RiverwoodOpiniones class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 12:17:57'!
cambiarPersonajeAPrometedor: personajeJugadorAPrometedor
	personajesPrometedores at: personajeJugadorAPrometedor put: true.
	TreborElGuardiaDeSkyrim reiniciarCantidadInteraccionesDeJugador: personajeJugadorAPrometedor.
	CarolinaLaCurandera reiniciarCantidadInteraccionesDeJugador: personajeJugadorAPrometedor.
	! !

!RiverwoodOpiniones class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 12:33:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	personajesPrometedores := ((Dictionary new) add: (#hamilton->true); yourself).! !

!RiverwoodOpiniones class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 12:04:45'!
obtenerSiPersonajeEsPrometedor: personajeJugador
	^ (personajesPrometedores at: personajeJugador ifAbsent: [ false ])! !

!RiverwoodOpiniones class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 10:52:05'!
olvidarPersonajesPrometedores
	personajesPrometedores := Dictionary new.! !


!classDefinition: #TreborElGuardiaDeSkyrim category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #TreborElGuardiaDeSkyrim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreborElGuardiaDeSkyrim class' category: 'Ejercicio1-PNJ-Episodio2'!
TreborElGuardiaDeSkyrim class
	instanceVariableNames: 'frasesPersonajePrometedor frasesPersonajeDesconocido cantidadDeInteraccionesPorPersonaje'!

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 00:45:34'!
interactuarCon: personajeJugadorAInteractuar
	self recordarInteraccion: personajeJugadorAInteractuar.
	^ self responderSegunCantidadDeInteracciones: personajeJugadorAInteractuar! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 10:40:52'!
olvidar
	cantidadDeInteraccionesPorPersonaje := Dictionary new.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'IA 10/4/2021 11:21:06'!
reiniciarCantidadInteraccionesDeJugador: personajeJugadorAOlvidar
	cantidadDeInteraccionesPorPersonaje at: personajeJugadorAOlvidar put: 0.! !


!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'IA 10/4/2021 11:20:48'!
recordarInteraccion: personajeJugadorAInteractuar
	| cantidadInteracciones |
	cantidadInteracciones := (cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar ifAbsent: [ 0 ]) + 1.
	cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar put: cantidadInteracciones.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'IA 10/4/2021 11:24:19'!
responderSegunCantidadDeInteracciones: personajeJugadorAInteractuar
	| personajeEsPrometedor cantidadDeInteracciones fraseJugadorPrometedor fraseJugadorDesconocido|
	
	personajeEsPrometedor := RiverwoodOpiniones obtenerSiPersonajeEsPrometedor: personajeJugadorAInteractuar.
	cantidadDeInteracciones := cantidadDeInteraccionesPorPersonaje at: personajeJugadorAInteractuar.
	fraseJugadorPrometedor := frasesPersonajePrometedor at: (cantidadDeInteracciones min: frasesPersonajePrometedor size).
	fraseJugadorDesconocido := frasesPersonajeDesconocido at: (cantidadDeInteracciones min: frasesPersonajeDesconocido size).
	
	^ personajeEsPrometedor ifTrue: [ fraseJugadorPrometedor ] ifFalse: [ fraseJugadorDesconocido ]! !


!TreborElGuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'IA 10/4/2021 12:33:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesPersonajePrometedor := #('Bienvenido aventurero!!' 'Espero que tengas una buena estadia en Riverwood' ).
	frasesPersonajeDesconocido := #('Hola forastero' '¿Todo bien?' '¿Algún problema?' ).
	cantidadDeInteraccionesPorPersonaje := ((Dictionary new) add: (#hamilton->2); yourself).! !

CarolinaLaCurandera initializeAfterFileIn!
RiverwoodOpiniones initializeAfterFileIn!
TreborElGuardiaDeSkyrim initializeAfterFileIn!