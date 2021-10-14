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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assert wrappers' stamp: 'IA 10/14/2021 06:59:01'!
assertCantSuspend: customerToSuspend withFinalCustomerIncluded: finalCustomerIncluded inCustomerBook: customerBook
	
	self checkAssertError: [ customerBook suspendCustomerNamed: customerToSuspend.
		self fail ] withError: CantSuspend withAssertToCheck: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: finalCustomerIncluded) ].
! !

!CustomerBookTest methodsFor: 'assert wrappers' stamp: 'IA 10/14/2021 07:05:52'!
assertsOfNumberOfCustomersInCustomerBook: customerBook withNameOfCustomer: customerNameToCheck withNumberOfFinalCustomers: numberOfFinalCustomers.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: numberOfFinalCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfFinalCustomers equals: customerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'assert wrappers' stamp: 'IA 10/14/2021 06:43:23'!
checkAssertError: conditionToFail withError: anError withAssertToCheck: assertToCheck
	 
	[ (conditionToFail value).
	self fail ]
		on: anError 
		do: (assertToCheck).! !


!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:15:38'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerNameToTest |

	customerNameToTest := 'John Lennon'.

	self addingOrRemovingInCustomerBookComplyOnTime: #addCustomerNamed: accordingToTime: 50 withNameCostumer: customerNameToTest.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:15:48'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerNameToTest |

	customerNameToTest := 'Paul McCartney'.

	self addingOrRemovingInCustomerBookComplyOnTime: #removeCustomerNamed: accordingToTime: 100 withNameCostumer: customerNameToTest.
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:45:34'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self checkAssertError: [ customerBook addCustomerNamed: ''.
		self fail ] withError: Error withAssertToCheck: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].		! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:42:51'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookAndAddACustomer: johnLennon.
	
	self checkAssertError: [ customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail ] withError: NotFound withAssertToCheck: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 07:05:52'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook customerNameToTest |
	
	customerNameToTest := 'Paul McCartney'.
	customerBook := self createCustomerBookAndAddACustomer: customerNameToTest.

	customerBook suspendCustomerNamed: customerNameToTest.
	
	self assertsOfNumberOfCustomersInCustomerBook: customerBook withNameOfCustomer: customerNameToTest withNumberOfFinalCustomers: 1.
	self assert: (customerBook includesCustomerNamed: customerNameToTest).
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 07:05:52'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook customerNameToTest |
	
	customerNameToTest := 'Paul McCartney'.
	customerBook := self createCustomerBookAndAddACustomer: customerNameToTest.
	
	customerBook suspendCustomerNamed: customerNameToTest.
	customerBook removeCustomerNamed: customerNameToTest.
	
	self assertsOfNumberOfCustomersInCustomerBook: customerBook withNameOfCustomer: customerNameToTest withNumberOfFinalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: customerNameToTest).
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:57:22'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookAndAddACustomer: johnLennon.
	
	self assertCantSuspend: 'Ringo Star' withFinalCustomerIncluded: johnLennon inCustomerBook: customerBook.

! !

!CustomerBookTest methodsFor: 'tests' stamp: 'IA 10/14/2021 06:57:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookAndAddACustomer: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertCantSuspend: johnLennon withFinalCustomerIncluded: johnLennon inCustomerBook: customerBook.

! !


!CustomerBookTest methodsFor: 'time of actions' stamp: 'IA 10/14/2021 06:15:30'!
addingOrRemovingInCustomerBookComplyOnTime: anAction accordingToTime: timeInMiliseconds withNameCostumer: customerNameToTest

	| millisecondsOfAction customerBook |
	
	customerBook := CustomerBook new.
	(anAction = #removeCustomerNamed:) ifTrue: [customerBook addCustomerNamed: customerNameToTest].
	
	millisecondsOfAction := self timeOfActionOfAddingOrRemovingCustomerInCustomerBook: customerBook ofAction: anAction withNameCostumer: customerNameToTest.
	
	self assert: (millisecondsOfAction) < (timeInMiliseconds * millisecond).
	
! !

!CustomerBookTest methodsFor: 'time of actions' stamp: 'IA 10/14/2021 06:15:14'!
timeOfActionOfAddingOrRemovingCustomerInCustomerBook: costumerBook ofAction: anAction withNameCostumer: customerNameToTest
	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction sendTo: costumerBook with: customerNameToTest.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^ (millisecondsBeforeRunning - millisecondsAfterRunning)
	
! !


!CustomerBookTest methodsFor: 'customer managment' stamp: 'IA 10/14/2021 06:16:30'!
createCustomerBookAndAddACustomer: customerToAdd

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: customerToAdd.
	
	^ customerBook
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

!CustomerBook methodsFor: 'customer management' stamp: 'IA 10/14/2021 06:13:42'!
removeCustomerNamed: aName

	| nameToReturn |
	
	nameToReturn := self removeCustomerNamed: aName withStatus: suspended.
	
	nameToReturn = nil ifTrue: [nameToReturn := self removeCustomerNamed: aName withStatus: active].
	
	nameToReturn = nil ifFalse: [^ nameToReturn].
		
	^ NotFound signal
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IA 10/14/2021 06:14:25'!
removeCustomerNamed: aName withStatus: customerStatus	

	1 to: customerStatus size do: 
	[ :index |
		aName = (customerStatus at: index)
			ifTrue: [
				customerStatus removeAt: index.
				^ aName 
			] 
	].
	^ nil
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
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
