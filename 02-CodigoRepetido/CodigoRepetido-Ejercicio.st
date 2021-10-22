!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'johnLennon paulMcCaurtney ringoStarr customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assertions' stamp: 'IA 10/22/2021 15:55:24'!
assertIn: aCustomerBook thatTheNumberOfActiveCustomersIs: aNumberOfActiveCustomers andTheNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers

	| numberOfTotalCustomers |
	
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	
	numberOfTotalCustomers := aNumberOfActiveCustomers + aNumberOfSuspendedCustomers.
	
	self assert: numberOfTotalCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'IA 10/22/2021 15:31:58'!
should: aBlockToMeasure notTakeMoreThan: aTimeLimit

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockToMeasure value.	
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < aTimeLimit.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'IA 10/22/2021 15:43:47'!
should: aBlockThatShouldFail raise: anExceptionType asserting: aVerificationBlock
	 
	[ aBlockThatShouldFail value.
	self fail ]
		on: anExceptionType 
		do: (aVerificationBlock).! !


!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:27:57'!
setUp
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	paulMcCaurtney := 'Paul McCaurtney'.
	ringoStarr := 'Ringo Starr'.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:47:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self
		should: [ customerBook addCustomerNamed: johnLennon. ]
		notTakeMoreThan: 50 * millisecond
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:47:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	customerBook addCustomerNamed: paulMcCaurtney.
	
	self
		should: [ customerBook removeCustomerNamed: paulMcCaurtney. ]
		notTakeMoreThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:47:46'!
test03CanNotAddACustomerWithEmptyName 
		
	self
		should: [ customerBook addCustomerNamed: ''. ]
		raise: Error
		asserting: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty. ].		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:46:44'!
test04CanNotRemoveAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon .
	
	self 
		should: [ customerBook removeCustomerNamed: paulMcCaurtney. ]
		raise: NotFound
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon). ].
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:57:50'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	
	customerBook addCustomerNamed: paulMcCaurtney.
	customerBook suspendCustomerNamed: paulMcCaurtney.
	
	self
		assertIn: customerBook
		thatTheNumberOfActiveCustomersIs: 0
		andTheNumberOfSuspendedCustomersIs: 1.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 15:59:44'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	customerBook addCustomerNamed: paulMcCaurtney.
	customerBook suspendCustomerNamed: paulMcCaurtney.
	customerBook removeCustomerNamed: paulMcCaurtney.
	
	self
		assertIn: customerBook
		thatTheNumberOfActiveCustomersIs: 0
		andTheNumberOfSuspendedCustomersIs: 0.
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 16:04:30'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [ customerBook suspendCustomerNamed: ringoStarr. ]
		raise: CantSuspend
		asserting: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon). ].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/22/2021 16:05:43'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		should: [ customerBook suspendCustomerNamed: johnLennon . ]
		raise: CantSuspend
		asserting: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon). ].
! !


!CustomerBookTest methodsFor: 'customer managment' stamp: 'IA 10/22/2021 15:26:40'!
createCustomerBookAndAddACustomer: customerToAdd

	| customerBoook |
	
	customerBoook := CustomerBook new.
	
	customerBoook addCustomerNamed: customerToAdd.
	
	^ customerBoook
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'IA 10/14/2021 06:12:38'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'IA 10/22/2021 16:08:51'!
removeCustomerNamed: aName

	^ active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^ NotFound signal ] ].
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'IA 10/22/2021 16:10:19'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].

	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'IA 10/14/2021 06:09:54'!
numberOfActiveCustomers
	
	^ active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'IA 10/14/2021 06:11:35'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'accessing' stamp: 'IA 10/14/2021 06:10:24'!
numberOfSuspendedCustomers
	
	^ suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'IA 10/14/2021 06:09:34'!
includesCustomerNamed: aName

	^ (active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'IA 10/14/2021 06:09:40'!
isEmpty
	
	^ active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
