!classDefinition: #OOLimitedStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOLimitedStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 03:31:34'!
test01LimitedStackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOLimitedStack with: 5.
	
	self assert: stack isEmpty! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:09:42'!
test02PushAddElementsToTheLimitedStack

	| stack |
	
	stack := OOLimitedStack with: 5.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:09:58'!
test03PopRemovesElementsFromTheLimitedStack

	| stack |
	
	stack := OOLimitedStack with: 5.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:10:05'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOLimitedStack with: 5.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 03:32:14'!
test05LimitedStackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOLimitedStack with: 5.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:10:33'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOLimitedStack with: 5.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:10:47'!
test07TopDoesNotRemoveObjectFromLimitedStack

	| stack pushedObject |
	
	stack := OOLimitedStack with: 5.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:18:31'!
test08CanNotPopWhenThereAreNoObjectsInTheLimitedStack

	| stack  |
	
	stack := OOLimitedStack with: 5.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack stackEmptyErrorDescription ]
		
! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:18:28'!
test09CanNotPopWhenThereAreNoObjectsInTheLimitedStackAndTheLimitedStackHadObjects

	| stack  |
	
	stack := OOLimitedStack with: 5.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack stackEmptyErrorDescription ]
		
! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 03:31:55'!
test10CanNotTopWhenThereAreNoObjectsInTheLimitedStack

	| stack  |
	
	stack := OOLimitedStack with: 5.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack stackEmptyErrorDescription ]
		
! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:16:59'!
test11CanNotPushWhenTheLimitedStackIsFull

	| stack pushedObject |
	
	stack := OOLimitedStack with: 1.
	pushedObject := 'something'.
	stack push: pushedObject.

	self
		should: [ stack push: 'something' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack stackFullErrorDescription ].
		
! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:17:13'!
test12TopReturnsLastPushedObjectInFullLimitedStack

	| stack pushedObject |
	
	stack := OOLimitedStack with: 1.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:24:26'!
test13CorrectSizeOfFullLimitedStack

	| stack pushedObject |
	
	stack := OOLimitedStack with: 1.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack size = 1.
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/3/2021 11:34:15'!
test14FullPushedLimitedStackShouldBeFull

	| stack pushedObject |
	
	stack := OOLimitedStack with: 1.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack isFull.
	! !

!OOLimitedStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 03:59:28'!
test15SizeLimitCantBeNegative

	self should: [ OOLimitedStack with: -1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack negativeSizeErrorDescription ].	! !


!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:08'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOUnlimitedStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:18'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:21'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:23'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:25'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOUnlimitedStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:28'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:30'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOUnlimitedStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:32'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOUnlimitedStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:35'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOUnlimitedStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'IA 11/4/2021 05:06:36'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOUnlimitedStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack sentencesToTest stackWithThreeSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'IA 11/3/2021 08:55:04'!
assertThat: aCollectionOfSentences hasSize: aSize

	self assert: aCollectionOfSentences size equals: aSize.! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'IA 11/3/2021 10:39:56'!
assertThat: aStack isEqualTo: anotherStack
	
	self assertThat: aStack hasSize: anotherStack size.
	
	[ aStack isEmpty ] whileFalse: [self assert: aStack pop equals: anotherStack pop].! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'IA 11/4/2021 05:06:55'!
createSentencesStackWith: aSentencesCollection

	| stackToTest |
	
	stackToTest := OOUnlimitedStack new.
	
	aSentencesCollection do: [ :aSentence | stackToTest push: aSentence].
	
	^ stackToTest.! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'IA 11/3/2021 09:27:22'!
findSentencesWith: aPrefix on: aStack

	| sentenceFinder foundSentences |
		
	sentenceFinder := SentenceFinderByPrefix with: aPrefix on: aStack.
	
	foundSentences := sentenceFinder find.
	
	^ foundSentences.! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'IA 11/4/2021 05:07:01'!
setUp

	emptyStack := OOUnlimitedStack new.
	
	sentencesToTest := OrderedCollection with: 'winter is coming' with: 'winning is everything' with: 'winter is here'.
	
	stackWithThreeSentences := self createSentencesStackWith: sentencesToTest.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 08:40:16'!
test01PrefixCantBeSpaces

	| spaceString |
	
	spaceString := ' '.
		
	self should: [ SentenceFinderByPrefix with: spaceString on: emptyStack]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacesInPrefixErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 08:13:24'!
test02PrefixCantIncludeSpaces
	
	| stringWithSpaces |
	
	stringWithSpaces := 'hello '.

	self should: [ SentenceFinderByPrefix with: stringWithSpaces on: emptyStack]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacesInPrefixErrorDescription ].	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 08:18:45'!
test03PrefixCantBeVoid

	| voidString |
	
	voidString := ''.

	self should: [ SentenceFinderByPrefix with: voidString on: emptyStack]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ].	

		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 09:36:25'!
test04ZeroSentencesFoundOnEmptyStack

	| testingPrefix foundSentences |
	
	testingPrefix := 'Wint'.
		
	foundSentences := self findSentencesWith: testingPrefix on: emptyStack.
	
	self assertThat: foundSentences hasSize: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 10:05:25'!
test05ZeroSentencesFoundWithAPrefixThatIsNotIncludedInAnySentence

	| testingPrefix foundSentences |
	
	testingPrefix := 'Hello'.
	
	foundSentences := self findSentencesWith: testingPrefix on: stackWithThreeSentences.
	
	self assertThat: foundSentences hasSize: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 10:06:17'!
test06SentenceCorrectlyFoundWithPrefixThatIsIncludedInOneSentence
	
	| sentenceInStackWithPrefix testingPrefix foundSentences |
	
	testingPrefix := 'winning'.
	sentenceInStackWithPrefix := 'winning is everything'.
	
	foundSentences := self findSentencesWith: testingPrefix on: stackWithThreeSentences.
	
	self assertThat: foundSentences hasSize: 1.
	self assert: sentenceInStackWithPrefix equals: (foundSentences at: 1).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 10:22:05'!
test07SentencesCorrectlyFoundWithPrefixThatIsIncludedInAllSentences
	
	| testingPrefix foundSentences |
	
	testingPrefix := 'win'.
	
	foundSentences := self findSentencesWith: testingPrefix on: stackWithThreeSentences.
	
	self assertThat: foundSentences hasSize: 3.
	
	sentencesToTest do: [ :aSentence | self assert: foundSentences includes: aSentence].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 10:24:20'!
test08SentenceFinderIsCaseSensitive
	
	| testingPrefix foundSentences |
	
	testingPrefix := 'Win'.
	
	foundSentences := self findSentencesWith: testingPrefix on: stackWithThreeSentences.
	
	self assertThat: foundSentences hasSize: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IA 11/3/2021 10:36:10'!
test09OriginalStackKeepOrderAfterFindSentences

	| testingPrefix foundSentences originalStack |
	
	originalStack := self createSentencesStackWith: sentencesToTest.
	testingPrefix := 'win'.
	
	foundSentences := self findSentencesWith: testingPrefix on: stackWithThreeSentences.
	
	self assertThat: originalStack isEqualTo: stackWithThreeSentences.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackTop stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'IA 11/3/2021 03:06:16'!
size

	^ stackTop sizeToBase.! !

!OOStack methodsFor: 'accesing' stamp: 'IA 11/3/2021 03:17:09'!
top
	
	^ stackTop value.! !



!OOStack methodsFor: 'signal errors' stamp: 'IA 10/30/2021 03:35:00'!
signalStackIsEmpty
	
	self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'stack management' stamp: 'IA 11/3/2021 03:16:18'!
pop
	
	| topToPop |
	
	topToPop := self top. 
	
	stackTop := stackTop elementBelow.
	
	^ topToPop! !

!OOStack methodsFor: 'stack management' stamp: 'IA 11/4/2021 05:00:02'!
push: anElementToPush
	
	self subclassResponsibility.! !


!OOStack methodsFor: 'testing' stamp: 'IA 11/3/2021 03:06:35'!
isEmpty

	^ stackTop isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOLimitedStack category: 'Stack-Exercise'!
OOStack subclass: #OOLimitedStack
	instanceVariableNames: 'maximumSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLimitedStack methodsFor: 'initialization' stamp: 'IA 11/3/2021 11:07:21'!
initializeWith: aSizeLimit

	maximumSize := aSizeLimit.
	stackTop := OOStackBase new.! !


!OOLimitedStack methodsFor: 'signal errors' stamp: 'IA 11/3/2021 11:06:25'!
signalStackIsFull
	
	self error: self class stackFullErrorDescription.! !


!OOLimitedStack methodsFor: 'stack management' stamp: 'IA 11/3/2021 11:28:51'!
push: anElementToPush
	
	(self isFull) ifTrue: [^self signalStackIsFull.].
	
	stackTop := OOStackPushedElement with: anElementToPush over: stackTop.! !


!OOLimitedStack methodsFor: 'testing' stamp: 'IA 11/3/2021 11:28:28'!
isFull

	^ self size = maximumSize.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLimitedStack class' category: 'Stack-Exercise'!
OOLimitedStack class
	instanceVariableNames: ''!

!OOLimitedStack class methodsFor: 'error descriptions' stamp: 'IA 11/4/2021 03:54:57'!
assertThatSizeLimitIsNotNegative: aSizeLimit

	(aSizeLimit negative) ifTrue: [self error: self negativeSizeErrorDescription.].! !

!OOLimitedStack class methodsFor: 'error descriptions' stamp: 'IA 11/4/2021 05:09:14'!
negativeSizeErrorDescription
	
	^ 'Stack limit size can not be negative'! !

!OOLimitedStack class methodsFor: 'error descriptions' stamp: 'IA 11/3/2021 11:01:40'!
stackFullErrorDescription
	
	^ 'Stack is full'! !


!OOLimitedStack class methodsFor: 'instance creation' stamp: 'IA 11/4/2021 03:59:12'!
with: aSizeLimit

	self assertThatSizeLimitIsNotNegative: aSizeLimit.
	
	^ self new initializeWith: aSizeLimit.! !


!classDefinition: #OOUnlimitedStack category: 'Stack-Exercise'!
OOStack subclass: #OOUnlimitedStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOUnlimitedStack methodsFor: 'initialization' stamp: 'IA 11/4/2021 05:00:32'!
initialize
	
	stackTop := OOStackBase new.! !


!OOUnlimitedStack methodsFor: 'stack management' stamp: 'IA 11/4/2021 04:59:20'!
push: anElementToPush
	
	stackTop := OOStackPushedElement with: anElementToPush over: stackTop.! !


!classDefinition: #OOStackTopElement category: 'Stack-Exercise'!
Object subclass: #OOStackTopElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTopElement methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:41:39'!
sizeToBase
	
	^ self subclassResponsibility ! !

!OOStackTopElement methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:42:07'!
value
	
	^ self subclassResponsibility ! !


!OOStackTopElement methodsFor: 'testing' stamp: 'IA 11/3/2021 03:06:42'!
isEmpty
	
	^ self subclassResponsibility ! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackTopElement subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:42:51'!
sizeToBase

	^ 0! !

!OOStackBase methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:42:36'!
value

	self error: OOStack stackEmptyErrorDescription.! !


!OOStackBase methodsFor: 'testing' stamp: 'IA 11/3/2021 03:06:54'!
isEmpty

	^ true.! !


!classDefinition: #OOStackPushedElement category: 'Stack-Exercise'!
OOStackTopElement subclass: #OOStackPushedElement
	instanceVariableNames: 'elementValue elementBelow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackPushedElement methodsFor: 'accesing' stamp: 'IA 11/3/2021 03:10:15'!
elementBelow

	^ elementBelow.! !

!OOStackPushedElement methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:51:36'!
sizeToBase
	
	^ elementBelow sizeToBase + 1.! !

!OOStackPushedElement methodsFor: 'accesing' stamp: 'IA 11/3/2021 02:52:09'!
value
	
	^ elementValue! !


!OOStackPushedElement methodsFor: 'initialization' stamp: 'IA 11/3/2021 03:03:19'!
initializeWith: anElementToPush over: previousElementPushed

	elementValue := anElementToPush.
	elementBelow := previousElementPushed.! !


!OOStackPushedElement methodsFor: 'testing' stamp: 'IA 11/3/2021 03:07:09'!
isEmpty

	^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackPushedElement class' category: 'Stack-Exercise'!
OOStackPushedElement class
	instanceVariableNames: ''!

!OOStackPushedElement class methodsFor: 'instance creation' stamp: 'IA 11/3/2021 03:03:01'!
with: anElementToPush over: previousElementPushed

	^ self new initializeWith: anElementToPush over: previousElementPushed.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'prefix sentencesStack auxiliarStack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'IA 11/3/2021 09:17:52'!
find

	self findSentencesByPrefixOnSentencesStack.
	
	self reverseBackToOriginalStack.
	
	^ foundSentences.! !


!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 09:38:14'!
checkSentenceByPrefixOnTopOfSentencesStack

	self storeSentenceIfItBeginsWithPrefix: sentencesStack top.
	
	self popTopOf: sentencesStack andPushTo: auxiliarStack.! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 09:38:14'!
findSentencesByPrefixOnSentencesStack
	
	self whileStackIsNotEmpty: sentencesStack do: [self checkSentenceByPrefixOnTopOfSentencesStack].
	
	self reverseBackToOriginalStack.
	
	^ foundSentences.! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 06:47:19'!
popTopOf: aStack andPushTo: anotherStack
	
	anotherStack push: aStack pop.! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 06:44:29'!
pushBackOriginalSentence
	
	self popTopOf: auxiliarStack andPushTo: sentencesStack.! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 06:04:40'!
reverseBackToOriginalStack

	self whileStackIsNotEmpty: auxiliarStack do: [self pushBackOriginalSentence].! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 07:10:14'!
storeSentenceIfItBeginsWithPrefix: aSentence

	(aSentence beginsWith: prefix) ifTrue: [foundSentences add: aSentence].! !

!SentenceFinderByPrefix methodsFor: 'find - private' stamp: 'IA 11/3/2021 09:16:31'!
whileStackIsNotEmpty: aStack do: anActionBlock

	[aStack isEmpty] whileFalse: anActionBlock.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'IA 11/4/2021 05:07:14'!
initializeWith: aPrefixToFind on: aSentencesStack

	sentencesStack := aSentencesStack.
	prefix := aPrefixToFind.
	foundSentences := OrderedCollection new.
	auxiliarStack := OOUnlimitedStack new.! !


!SentenceFinderByPrefix methodsFor: 'signal errors' stamp: 'IA 11/3/2021 08:11:45'!
signalEmptyPrefixErrorDescription

	^ self error: SentenceFinderByPrefix emptyPrefixErrorDescription.! !

!SentenceFinderByPrefix methodsFor: 'signal errors' stamp: 'IA 11/3/2021 08:12:02'!
signalSpacesInPrefixErrorDescription

	^ self error: SentenceFinderByPrefix spacesInPrefixErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'IA 11/3/2021 09:05:48'!
with: aPrefixToFind on: aSentencesStack

	self assertThatPrefixIsNotEmpty: aPrefixToFind.
	self assertThatPrefixNotIncludesSpaces: aPrefixToFind.

	^ self new initializeWith: aPrefixToFind on: aSentencesStack.! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IA 11/3/2021 07:43:14'!
assertThatPrefixIsNotEmpty: aPrefix

	(aPrefix isEmpty) ifTrue: [self error: self emptyPrefixErrorDescription.].! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IA 11/3/2021 07:44:04'!
assertThatPrefixNotIncludesSpaces: aPrefix

	(aPrefix includes: $ ) ifTrue: [self error: self spacesInPrefixErrorDescription.].! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IA 11/3/2021 05:09:46'!
emptyPrefixErrorDescription

	^ 'Prefix is void'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IA 11/3/2021 05:11:50'!
spacesInPrefixErrorDescription

	^ 'Prefix has spaces'! !
