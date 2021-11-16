!classDefinition: #TestMarsRover category: '05-MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: 'initialPosition inicialCardinalPoint marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!TestMarsRover methodsFor: 'setup' stamp: 'IA 11/16/2021 07:03:14'!
setUp

	initialPosition := (0@0).
	inicialCardinalPoint := $N.
	marsRover := MarsRover inPosition: initialPosition lookingTo: inicialCardinalPoint.! !


!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 06:31:41'!
test01MarsRoverCantInitializeWithAnInvalidInitialPosition

	| invalidInitialPosition |
	
	invalidInitialPosition := 1.
	
	self should: [ MarsRover inPosition: invalidInitialPosition lookingTo: inicialCardinalPoint. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidTypeOfPositionDescription ].! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 06:31:38'!
test02MarsRoverCantInitializeWithAnInvalidInitialLookingCardinalPoint

	| invalidInicialCardinalPoint |
	
	invalidInicialCardinalPoint := $D.
	
	self should: [ MarsRover inPosition: initialPosition lookingTo: invalidInicialCardinalPoint. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidCardinalPointDescription ].! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 13:04:45'!
test03MarsRoverMaintainsItsInitialPositionIWhenMovementCommandsAreEmpty

	| emptyMovementCommands |
	
	emptyMovementCommands := ''.
	
	marsRover moveAccordingToStringCommands: emptyMovementCommands.
	
	self assert: initialPosition equals: marsRover currentPosition.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 12:59:03'!
test04MarsRoverMovesForwardWhenWeSentCommandF

	| expectedPosition |
	
	expectedPosition := initialPosition + (0@1).
	
	marsRover moveAccordingToStringCommands: 'f'.
	
	self assert: expectedPosition equals: marsRover currentPosition.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 12:59:00'!
test05MarsRoverMovesBackwardWhenWeSentCommandB

	| expectedPosition |
	
	expectedPosition := initialPosition - (0@1).
	
	marsRover moveAccordingToStringCommands: 'b'.
	
	self assert: expectedPosition equals: marsRover currentPosition.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 08:49:41'!
test06MarsRoverCanMoveBackwardAndForwardWithOneStringMovementCommand

	| expectedPosition |
	
	expectedPosition := initialPosition.
	
	marsRover moveAccordingToStringCommands: 'bf'.
	
	self assert: expectedPosition equals: marsRover currentPosition.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 07:58:44'!
test07MarsRoverRotateLeftWhenWeSentCommandL

	| expectedLookingCardinalPoint |
	
	expectedLookingCardinalPoint := $W.
	
	marsRover moveAccordingToStringCommands: 'l'.
	
	self assert: expectedLookingCardinalPoint equals: marsRover currentLookingCardinalPoint.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 08:01:43'!
test08MarsRoverRotateRightWhenWeSentCommandR

	| expectedLookingCardinalPoint |
	
	expectedLookingCardinalPoint := $E.
	
	marsRover moveAccordingToStringCommands: 'r'.
	
	self assert: expectedLookingCardinalPoint equals: marsRover currentLookingCardinalPoint.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 12:50:35'!
test09MarsRoverCanRotateTwiceWithOneStringMovementCommand

	| expectedLookingCardinalPoint |
	
	expectedLookingCardinalPoint := $S.
	
	marsRover moveAccordingToStringCommands: 'rr'.
	
	self assert: expectedLookingCardinalPoint equals: marsRover currentLookingCardinalPoint.! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 16:14:39'!
test10MarsRoverCanHandleOneStringMovementCommandWithRotationsAndTransitations

	| stringMovementCommand expectedPosition |
	
	stringMovementCommand := 'lfflb'.
	expectedPosition := initialPosition + (-2@1). 
	marsRover moveAccordingToStringCommands: stringMovementCommand.
	
	self assert: expectedPosition equals: (marsRover currentPosition).! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 15:53:22'!
test11MarsRoverShouldRaiseAnErrorWhenWeSentAnInvalidCommand

	| invalidMovementCommand |
	
	invalidMovementCommand := 't'.
	
	self should: [ marsRover moveAccordingToStringCommands: invalidMovementCommand. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRoverMovementType invalidMovementTypeDescription. ].! !

!TestMarsRover methodsFor: 'test' stamp: 'IA 11/16/2021 16:14:52'!
test12MarsRoverShouldMoveUntilAnInvalidCommandAppears

	| testingStringCommands expectedPosition |
	
	testingStringCommands := 'lfflbt'.
	expectedPosition := initialPosition + (-2@1). 
	
	self should: [ marsRover moveAccordingToStringCommands: testingStringCommands. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRoverMovementType invalidMovementTypeDescription. ].
		
	self assert: expectedPosition equals: marsRover currentPosition.! !


!classDefinition: #MarsRover category: '05-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentLookingCardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRover methodsFor: 'accesing' stamp: 'IA 11/16/2021 07:59:10'!
currentLookingCardinalPoint

	^ currentLookingCardinalPoint.! !

!MarsRover methodsFor: 'accesing' stamp: 'IA 11/16/2021 05:48:20'!
currentPosition
	
	^ currentPosition.! !


!MarsRover methodsFor: 'commands' stamp: 'IA 11/16/2021 12:42:44'!
moveAccordingToStringCommands: aStringWithMovementCommands 
	
	aStringWithMovementCommands do: [ :aCommand | self processCommand: aCommand ]. 
	! !

!MarsRover methodsFor: 'commands' stamp: 'IA 11/16/2021 16:13:52'!
processCommand: aCommand 
	
	| typeOfMovement |
	
	typeOfMovement := MarsRoverMovementType with: aCommand.
	
	typeOfMovement sendMovementCommandTo: self.! !


!MarsRover methodsFor: 'initialization' stamp: 'IA 11/16/2021 11:57:49'!
initializeInPosition: anInitialPosition lookingTo: aCardinalPoint

	currentPosition := anInitialPosition.
	currentLookingCardinalPoint := aCardinalPoint.! !


!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 12:06:25'!
rotateLeft

	| referenceCardinalPointMovement |
	
	referenceCardinalPointMovement := MarsRoverCardinalPointMovementReference pointingTo: currentLookingCardinalPoint.

	referenceCardinalPointMovement rotateLeft: self.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:54:16'!
rotateLeftAccordingToEast

	currentLookingCardinalPoint := $N.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 10:53:16'!
rotateLeftAccordingToNorth

	currentLookingCardinalPoint := $W.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:52:52'!
rotateLeftAccordingToSouth

	currentLookingCardinalPoint := $E.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:53:45'!
rotateLeftAccordingToWest

	currentLookingCardinalPoint := $S.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 12:06:39'!
rotateRight

	| referenceCardinalPointMovement |
	
	referenceCardinalPointMovement := MarsRoverCardinalPointMovementReference pointingTo: currentLookingCardinalPoint.

	referenceCardinalPointMovement rotateRight: self.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:51:37'!
rotateRightAccordingToEast

	currentLookingCardinalPoint := $S.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:44:52'!
rotateRightAccordingToNorth

	currentLookingCardinalPoint := $E.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:50:51'!
rotateRightAccordingToSouth

	currentLookingCardinalPoint := $W.! !

!MarsRover methodsFor: 'rotation - private' stamp: 'IA 11/16/2021 11:52:19'!
rotateRightAccordingToWest

	currentLookingCardinalPoint := $N.! !


!MarsRover methodsFor: 'signal errors' stamp: 'IA 11/16/2021 13:04:28'!
signalInvalidCommand
	
	self error: self class invalidCommandDescritpion.! !

!MarsRover methodsFor: 'signal errors' stamp: 'IA 11/16/2021 06:09:35'!
signalnvalidCardinalPoint

	^ self error: self class invalidCardinalPointDescription.! !


!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:22:42'!
moveBackwards

	| referenceCardinalPointMovement |
	
	referenceCardinalPointMovement := MarsRoverCardinalPointMovementReference pointingTo: currentLookingCardinalPoint.

	referenceCardinalPointMovement moveBackwards: self.! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:57:46'!
moveBackwardsAccordingToEast
	
	currentPosition := currentPosition - (1@0).! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:57:58'!
moveBackwardsAccordingToNorth
	
	currentPosition := currentPosition - (0@1).! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:58:20'!
moveBackwardsAccordingToSouth
	
	currentPosition := currentPosition + (0@1).! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:58:31'!
moveBackwardsAccordingToWest
	
	currentPosition := currentPosition + (1@0).! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:23:07'!
moveForward

	| referenceCardinalPointMovement |
	
	referenceCardinalPointMovement := MarsRoverCardinalPointMovementReference pointingTo: currentLookingCardinalPoint.

	referenceCardinalPointMovement moveForward: self.! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:03:08'!
moveForwardAccordingToEast
	
	self moveBackwardsAccordingToWest.! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:02:32'!
moveForwardAccordingToNorth
	
	self moveBackwardsAccordingToSouth.! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:02:52'!
moveForwardAccordingToSouth
	
	self moveBackwardsAccordingToNorth.! !

!MarsRover methodsFor: 'transitions - private' stamp: 'IA 11/16/2021 12:02:45'!
moveForwardAccordingToWest
	
	self moveBackwardsAccordingToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: '05-MarsRover'!
MarsRover class
	instanceVariableNames: 'isAValidPosition'!

!MarsRover class methodsFor: 'assertions' stamp: 'IA 11/16/2021 06:15:03'!
assertThatIsAValidCardinalPoint: aPotencialCardinalPoint

	| validCardinalPoints |

	validCardinalPoints := (#N, #S, #E, #O).

	(validCardinalPoints includes: aPotencialCardinalPoint) ifFalse: [ self error: self invalidCardinalPointDescription ].! !

!MarsRover class methodsFor: 'assertions' stamp: 'IA 11/16/2021 06:17:23'!
assertThatIsAValidPositionPoint: aPotencialPoint

	(aPotencialPoint isKindOf: Point) ifFalse: [ self error: self invalidTypeOfPositionDescription ].! !


!MarsRover class methodsFor: 'errors descriptions' stamp: 'IA 11/16/2021 06:08:42'!
invalidCardinalPointDescription

	^ 'Invalid cardinal point!!'.! !

!MarsRover class methodsFor: 'errors descriptions' stamp: 'IA 11/16/2021 06:08:11'!
invalidTypeOfPositionDescription

	^ 'Invalid type of position!!'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 06:18:23'!
inPosition: anInitialPosition lookingTo: aCardinalPoint

	self assertThatIsAValidCardinalPoint: aCardinalPoint.
	self assertThatIsAValidPositionPoint: anInitialPosition.

	^ self new initializeInPosition: anInitialPosition lookingTo: aCardinalPoint.! !


!classDefinition: #MarsRoverCardinalPointMovementReference category: '05-MarsRover'!
Object subclass: #MarsRoverCardinalPointMovementReference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:31:38'!
moveBackwards: aMarsRover

	^ self subclassResponsibility.! !

!MarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:31:50'!
moveForward: aMarsRover

	^ self subclassResponsibility.! !


!MarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:27:23'!
rotateLeft: aMarsRover

	^ self subclassResponsibility.! !

!MarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:27:29'!
rotateRight: aMarsRover

	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalPointMovementReference class' category: '05-MarsRover'!
MarsRoverCardinalPointMovementReference class
	instanceVariableNames: ''!

!MarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:30:43'!
canHandle: aCardinalPoint

	^ self subclassResponsibility.! !

!MarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:34:04'!
for: aCardinalPoint

	^ self new.! !

!MarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:36:40'!
pointingTo: aCardinalPoint

	"At this point, we dont need to assert cardinalpoint"

	^ (MarsRoverCardinalPointMovementReference allSubclasses detect: [:aClass | aClass canHandle: aCardinalPoint]) for: aCardinalPoint.! !


!classDefinition: #EastMarsRoverCardinalPointMovementReference category: '05-MarsRover'!
MarsRoverCardinalPointMovementReference subclass: #EastMarsRoverCardinalPointMovementReference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!EastMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:35:02'!
moveBackwards: aMarsRover
	
	^ aMarsRover moveBackwardsAccordingToEast.! !

!EastMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:34:43'!
moveForward: aMarsRover

	^ aMarsRover moveForwardAccordingToEast.! !


!EastMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:28:22'!
rotateLeft: aMarsRover

	^ aMarsRover rotateLeftAccordingToEast.! !

!EastMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:35:11'!
rotateRight: aMarsRover
	
	^ aMarsRover rotateRightAccordingToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastMarsRoverCardinalPointMovementReference class' category: '05-MarsRover'!
EastMarsRoverCardinalPointMovementReference class
	instanceVariableNames: ''!

!EastMarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:29:34'!
canHandle: aCardinalPoint

	^ aCardinalPoint = $E.! !


!classDefinition: #NorthMarsRoverCardinalPointMovementReference category: '05-MarsRover'!
MarsRoverCardinalPointMovementReference subclass: #NorthMarsRoverCardinalPointMovementReference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!NorthMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:38:29'!
moveBackwards: aMarsRover
	
	^ aMarsRover moveBackwardsAccordingToNorth.! !

!NorthMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:38:45'!
moveForward: aMarsRover
	
	^ aMarsRover moveForwardAccordingToNorth.! !


!NorthMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:38:09'!
rotateLeft: aMarsRover
	
	^ aMarsRover rotateLeftAccordingToNorth.! !

!NorthMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:37:58'!
rotateRight: aMarsRover
	
	^ aMarsRover rotateRightAccordingToNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthMarsRoverCardinalPointMovementReference class' category: '05-MarsRover'!
NorthMarsRoverCardinalPointMovementReference class
	instanceVariableNames: ''!

!NorthMarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:29:45'!
canHandle: aCardinalPoint

	^ aCardinalPoint = $N.! !


!classDefinition: #SouthMarsRoverCardinalPointMovementReference category: '05-MarsRover'!
MarsRoverCardinalPointMovementReference subclass: #SouthMarsRoverCardinalPointMovementReference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!SouthMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:42:02'!
moveBackwards: aMarsRover
	
	^ aMarsRover moveBackwardsAccordingToSouth.! !

!SouthMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:42:15'!
moveForward: aMarsRover
	
	^ aMarsRover moveForwardAccordingToSouth.! !


!SouthMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:42:26'!
rotateLeft: aMarsRover
	
	^ aMarsRover rotateLeftAccordingToSouth.! !

!SouthMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:42:35'!
rotateRight: aMarsRover
	
	^ aMarsRover rotateRightAccordingToSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthMarsRoverCardinalPointMovementReference class' category: '05-MarsRover'!
SouthMarsRoverCardinalPointMovementReference class
	instanceVariableNames: ''!

!SouthMarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:29:59'!
canHandle: aCardinalPoint

	^ aCardinalPoint = $S.! !


!classDefinition: #WestMarsRoverCardinalPointMovementReference category: '05-MarsRover'!
MarsRoverCardinalPointMovementReference subclass: #WestMarsRoverCardinalPointMovementReference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!WestMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:43:27'!
rotateLeft: aMarsRover
	
	^ aMarsRover rotateLeftAccordingToWest.! !

!WestMarsRoverCardinalPointMovementReference methodsFor: 'rotation' stamp: 'IA 11/16/2021 10:43:20'!
rotateRight: aMarsRover
	
	^ aMarsRover rotateRightAccordingToWest.! !


!WestMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:43:08'!
moveBackwards: aMarsRover
	
	^ aMarsRover moveBackwardsAccordingToWest.! !

!WestMarsRoverCardinalPointMovementReference methodsFor: 'movement' stamp: 'IA 11/16/2021 10:42:59'!
moveForward: aMarsRover
	
	^ aMarsRover moveForwardAccordingToWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestMarsRoverCardinalPointMovementReference class' category: '05-MarsRover'!
WestMarsRoverCardinalPointMovementReference class
	instanceVariableNames: ''!

!WestMarsRoverCardinalPointMovementReference class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 12:30:12'!
canHandle: aCardinalPoint

	^ aCardinalPoint = $W.! !


!classDefinition: #MarsRoverMovementType category: '05-MarsRover'!
Object subclass: #MarsRoverMovementType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRoverMovementType methodsFor: 'movement' stamp: 'IA 11/16/2021 16:13:25'!
sendMovementCommandTo: aMarsRover

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverMovementType class' category: '05-MarsRover'!
MarsRoverMovementType class
	instanceVariableNames: ''!

!MarsRoverMovementType class methodsFor: 'errors description' stamp: 'IA 11/16/2021 15:41:10'!
invalidMovementTypeDescription

	^ 'Invalid movement type!!'.! !


!MarsRoverMovementType class methodsFor: 'assertions' stamp: 'IA 11/16/2021 16:16:27'!
asserThatIsAValidMovementType: aPotentialMovementType

	^ ('lrfb' includes: aPotentialMovementType) ifFalse: [ self error: self invalidMovementTypeDescription. ].! !


!MarsRoverMovementType class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:35:48'!
canHandle: aMovementType

	^ self subclassResponsibility.! !

!MarsRoverMovementType class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:36:04'!
for: aMovementType

	^ self new.! !

!MarsRoverMovementType class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:42:16'!
with: aMovementType

	self asserThatIsAValidMovementType: aMovementType.

	^ (MarsRoverMovementType allSubclasses detect: [ :aClass | aClass canHandle: aMovementType ]) for: aMovementType.! !


!classDefinition: #MoveBackwardsMovement category: '05-MarsRover'!
MarsRoverMovementType subclass: #MoveBackwardsMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MoveBackwardsMovement methodsFor: 'movement' stamp: 'IA 11/16/2021 16:13:25'!
sendMovementCommandTo: aMarsRover

	^ aMarsRover moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardsMovement class' category: '05-MarsRover'!
MoveBackwardsMovement class
	instanceVariableNames: ''!

!MoveBackwardsMovement class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:42:47'!
canHandle: aMovementType

	^ aMovementType = $b.! !


!classDefinition: #MoveForwardMovement category: '05-MarsRover'!
MarsRoverMovementType subclass: #MoveForwardMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MoveForwardMovement methodsFor: 'movement' stamp: 'IA 11/16/2021 16:13:25'!
sendMovementCommandTo: aMarsRover

	^ aMarsRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardMovement class' category: '05-MarsRover'!
MoveForwardMovement class
	instanceVariableNames: ''!

!MoveForwardMovement class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:42:57'!
canHandle: aMovementType

	^ aMovementType = $f.! !


!classDefinition: #RotateLeftMovement category: '05-MarsRover'!
MarsRoverMovementType subclass: #RotateLeftMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!RotateLeftMovement methodsFor: 'movement' stamp: 'IA 11/16/2021 16:13:25'!
sendMovementCommandTo: aMarsRover

	^ aMarsRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftMovement class' category: '05-MarsRover'!
RotateLeftMovement class
	instanceVariableNames: ''!

!RotateLeftMovement class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:43:28'!
canHandle: aMovementType

	^ aMovementType = $l.! !


!classDefinition: #RotateRightMovement category: '05-MarsRover'!
MarsRoverMovementType subclass: #RotateRightMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!RotateRightMovement methodsFor: 'movement' stamp: 'IA 11/16/2021 16:13:25'!
sendMovementCommandTo: aMarsRover

	^ aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightMovement class' category: '05-MarsRover'!
RotateRightMovement class
	instanceVariableNames: ''!

!RotateRightMovement class methodsFor: 'instance creation' stamp: 'IA 11/16/2021 15:43:38'!
canHandle: aMovementType

	^ aMovementType = $r.! !
