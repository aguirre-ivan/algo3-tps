!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'account portfolio fiftyPesosValueTransaction oneHundredPesosValueTransaction anotherPortfolio anotherAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'setup' stamp: 'IA 11/27/2021 05:25:42'!
setUp

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	fiftyPesosValueTransaction := 50 * peso.
	oneHundredPesosValueTransaction := 100 * peso.! !


!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:47:29'!
test01PortfolioHaveZeroAsBalancedWhenCreated

	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:03:02'!
test02PortfolioIncreasesBalanceAfterRegisteringTransactionsInHisAccounts

	Deposit register: fiftyPesosValueTransaction on: account.
	portfolio addParentRegister: account.
	
	self assert: fiftyPesosValueTransaction equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:12:44'!
test03PortfolioDecreasesBalanceAfterRegisteringTransactionsInHisAccounts

	| balanceExpected |
	
	Deposit register: oneHundredPesosValueTransaction on: account.
	portfolio addParentRegister: account.
	Withdraw register: fiftyPesosValueTransaction on: account.
	
	balanceExpected := oneHundredPesosValueTransaction - fiftyPesosValueTransaction.
	
	self assert: balanceExpected equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:27:18'!
test04APortfolioWithTwoAccountsHasTheCorrectBalance

	| balanceExpected |
	
	portfolio addParentRegister: account.
	portfolio addParentRegister: anotherAccount.
	
	Deposit register: oneHundredPesosValueTransaction on: account.
	Deposit register: fiftyPesosValueTransaction on: anotherAccount.
	
	balanceExpected := oneHundredPesosValueTransaction + fiftyPesosValueTransaction.
	
	self assert: balanceExpected equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:24:04'!
test05PortfolioRegisterIfItsAccountRegisterATransaction
	
	| transaction |
	
	portfolio addParentRegister: account.
	
	transaction := Deposit register: oneHundredPesosValueTransaction on: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:26:27'!
test06PortfolioRegisterIfItsParentPortfolioRegisterATransaction
	
	| transaction |
	
	portfolio addParentRegister: anotherPortfolio.
	anotherPortfolio addParentRegister: account.
	
	transaction := Deposit register: oneHundredPesosValueTransaction on: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:33:58'!
test07PortfolioKnowsItsParentsTransactions
	
	| aTransaction anOtherTransaction portfolioTransactions |
	
	portfolio addParentRegister: account.
	portfolio addParentRegister: anotherAccount.
	
	aTransaction := Deposit register: oneHundredPesosValueTransaction on: account.
	anOtherTransaction := Deposit register: oneHundredPesosValueTransaction on: anotherAccount.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: (portfolioTransactions includes: aTransaction).
	self assert: (portfolioTransactions includes: anOtherTransaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'IA 11/27/2021 05:51:53'!
test08PortfolioRegisterATransferBetweenTwoParentsAccountAndBalanceStillTheSame
	
	| aTransfer |
	
	portfolio addParentRegister: account.
	portfolio addParentRegister: anotherAccount.
	Deposit register: oneHundredPesosValueTransaction on: account.
	
	aTransfer := Transfer from: account to: anotherAccount for: oneHundredPesosValueTransaction.

	self assert: (portfolio hasRegistered: aTransfer depositLeg).
	self assert: (portfolio hasRegistered: aTransfer withdrawLeg).
	self assert: oneHundredPesosValueTransaction equals: (portfolio balance).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account oneHundredPesosValueTransaction fiftyPesosValueTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: oneHundredPesosValueTransaction on: account.
	
	self assert: oneHundredPesosValueTransaction equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: oneHundredPesosValueTransaction on: account.
	Withdraw register: fiftyPesosValueTransaction on: account.
		
	self assert: fiftyPesosValueTransaction equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test04WithdrawValueMustBePositive 
	
	self assert: fiftyPesosValueTransaction equals: (Withdraw register: fiftyPesosValueTransaction on: account) value.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := Deposit register: oneHundredPesosValueTransaction on: account.
	withdraw := Withdraw register: fiftyPesosValueTransaction on: account.
	
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: oneHundredPesosValueTransaction.
	withdraw := Withdraw for: fiftyPesosValueTransaction.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:21:02'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := Deposit register: fiftyPesosValueTransaction on: account.
	
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'setup' stamp: 'IA 11/27/2021 04:21:02'!
setUp

	account := ReceptiveAccount new.
	fiftyPesosValueTransaction := 50 * peso.
	oneHundredPesosValueTransaction := 100 * peso.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'originAccount destinationAccount zeroPesosValueTransaction negativePesosValueTransaction fiftyPesosValueTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'setup' stamp: 'IA 11/27/2021 03:10:36'!
setUp

	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.	
	fiftyPesosValueTransaction := 50 * peso.
	zeroPesosValueTransaction := 0 * peso.
	negativePesosValueTransaction := (-10) * peso.! !


!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 03:10:56'!
test01TransferDecreasesBalanceOfOriginAccountAndIncreasesBalanceOfDestinationAccount

	Transfer from: originAccount to: destinationAccount for: fiftyPesosValueTransaction.

	self assert: fiftyPesosValueTransaction negated equals: originAccount balance.
	self assert:  fiftyPesosValueTransaction equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 02:56:24'!
test02TransferCantBeZero

	self
		should: [ Transfer from: originAccount to: destinationAccount for: zeroPesosValueTransaction. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: zeroPesosValueTransaction equals: originAccount balance.
			self assert: zeroPesosValueTransaction equals: destinationAccount balance.
			self assert: anError messageText equals: Transfer transferValueCantBeZeroErrorDescription. ].! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 02:57:25'!
test03TransferValueCantBeNegative

	self
		should: [ Transfer from: originAccount to: destinationAccount for: negativePesosValueTransaction. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: zeroPesosValueTransaction equals: originAccount balance.
			self assert: zeroPesosValueTransaction equals: destinationAccount balance.
			self assert: anError messageText equals: Transfer transferValueCantBeNegativeErrorDescription. ].! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 03:28:12'!
test04OriginReceptiveAccountKnowsRegisteredTransferWithdrawLeg

	| aTransfer |
	
	aTransfer := Transfer from: originAccount to: destinationAccount for: fiftyPesosValueTransaction.
	
	self assert: (originAccount hasRegistered: (aTransfer withdrawLeg)).! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 03:33:10'!
test05DestinationReceptiveAccountKnowsRegisteredTransferDepositLeg

	| aTransfer |
	
	aTransfer := Transfer from: originAccount to: destinationAccount for: fiftyPesosValueTransaction.
	
	self assert: (destinationAccount hasRegistered: (aTransfer depositLeg)).! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 03:37:51'!
test06ATransferLegKnowsItsContrapartLegAndViceVersa

	| aTransfer aTransferWithdrawLeg aTransferDepositLeg |
	
	aTransfer := Transfer from: originAccount to: destinationAccount for: fiftyPesosValueTransaction.
	aTransferWithdrawLeg := aTransfer withdrawLeg.
	aTransferDepositLeg := aTransfer depositLeg.
	
	self assert: (aTransferWithdrawLeg contrapartLeg) equals: aTransferDepositLeg.
	self assert: (aTransferDepositLeg contrapartLeg) equals: aTransferWithdrawLeg.! !

!TransferTest methodsFor: 'tests' stamp: 'IA 11/27/2021 04:12:41'!
test07ATransferKnowsItsValue

	| aTransfer  |
	
	aTransfer := Transfer from: originAccount to: destinationAccount for: fiftyPesosValueTransaction.
	
	self assert: (aTransfer value) equals: fiftyPesosValueTransaction.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'IA 11/27/2021 02:07:20'!
affectBalance: aBalance

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'value' stamp: 'IA 11/27/2021 03:52:53'!
value 

	^ value.! !


!classDefinition: #NormalTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #NormalTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!NormalTransaction methodsFor: 'initialization' stamp: 'IA 11/27/2021 03:51:57'!
initializeFor: aValue

	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NormalTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
NormalTransaction class
	instanceVariableNames: ''!

!NormalTransaction class methodsFor: 'instance creation' stamp: 'IA 11/27/2021 03:56:47'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
	
	^ transaction.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
NormalTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'IA 11/27/2021 02:09:33'!
affectBalance: aBalance

	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
NormalTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'balance' stamp: 'IA 11/27/2021 02:08:55'!
affectBalance: aBalance

	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'accesing' stamp: 'IA 11/27/2021 03:48:13'!
contrapartLeg

	^ self subclassResponsibility.! !


!TransferTransaction methodsFor: 'initialization' stamp: 'IA 11/27/2021 03:51:26'!
initializeFor: aValue onTransfer: aTransfer.

	value := aValue.
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'IA 11/27/2021 04:02:55'!
for: aValue of: aTransfer

	^ self new initializeFor: aValue onTransfer: aTransfer.! !

!TransferTransaction class methodsFor: 'instance creation' stamp: 'IA 11/27/2021 04:03:55'!
register: aValue on: account of: aTransfer

	| transferTransaction |
	
	transferTransaction := self for: aValue of: aTransfer.
	account register: transferTransaction.
	
	^ transferTransaction.! !


!classDefinition: #DepositLegTransaction category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #DepositLegTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLegTransaction methodsFor: 'accesing' stamp: 'IA 11/27/2021 03:48:41'!
contrapartLeg

	^ transfer withdrawLeg.! !


!DepositLegTransaction methodsFor: 'balance' stamp: 'IA 11/27/2021 03:49:44'!
affectBalance: aBalance

	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLegTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
DepositLegTransaction class
	instanceVariableNames: ''!

!DepositLegTransaction class methodsFor: 'as yet unclassified' stamp: 'IA 11/27/2021 04:02:43'!
for: aValue of: aTransfer

	^ self new initializeFor: aValue onTransfer: aTransfer.! !


!classDefinition: #WithdrawLegTransaction category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #WithdrawLegTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawLegTransaction methodsFor: 'balance' stamp: 'IA 11/27/2021 03:49:50'!
affectBalance: aBalance

	^ aBalance - value.! !


!WithdrawLegTransaction methodsFor: 'accesing' stamp: 'IA 11/27/2021 03:48:50'!
contrapartLeg

	^ transfer depositLeg.! !


!classDefinition: #TransactionsRegister category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransactionsRegister
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransactionsRegister methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:43:01'!
addParentRegister: aRegisterToAdd
	
	^ self subclassResponsibility.! !

!TransactionsRegister methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:46:51'!
addRegistersTo: aTransactionsCollection
	
	^ self subclassResponsibility.! !

!TransactionsRegister methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:45:35'!
balance
	
	^ self subclassResponsibility.! !

!TransactionsRegister methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:45:47'!
hasRegistered: aTransaction
	
	^ self subclassResponsibility.! !

!TransactionsRegister methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:46:31'!
transactions
	
	^ self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
TransactionsRegister subclass: #Portfolio
	instanceVariableNames: 'associateRegisters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:44:22'!
addParentRegister: aRegisterToAdd

	associateRegisters add: aRegisterToAdd.! !

!Portfolio methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:44:22'!
addRegistersTo: aTransactionsCollection

	associateRegisters do: [ :aTransactionRegister |
		aTransactionRegister addRegistersTo: aTransactionsCollection ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:44:22'!
balance
	
	| balance |
	
	balance := 0.
	
	associateRegisters do: [ :aTransactionRegister |
		balance := balance + aTransactionRegister balance ].
	
	^ balance.! !

!Portfolio methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:44:22'!
hasRegistered: aTransaction

	associateRegisters do: [ :aTransactionRegister |
		(aTransactionRegister hasRegistered: aTransaction) ifTrue: [ ^ true. ]
		].
	
	^ false.! !

!Portfolio methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:44:22'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	
	associateRegisters do: [ :aRegisterTransaction |
		aRegisterTransaction addRegistersTo: transactions. ].
	
	^ transactions.! !


!Portfolio methodsFor: 'initialization' stamp: 'IA 11/27/2021 05:44:22'!
initialize
	
	associateRegisters := OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
TransactionsRegister subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'IA 11/27/2021 05:39:22'!
addRegistersTo: aTransactionsCollection

	aTransactionsCollection addAll: transactions.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'IA 11/27/2021 02:10:53'!
balance

	| balance |
	
	balance := 0.

	transactions do: [ :aTransaction |
		balance := aTransaction affectBalance: balance ].
	
	^ balance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'IA 11/27/2021 00:27:10'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'IA 11/27/2021 04:13:15'!
initializeWithAmount: anAmountToTransfer from: anOriginAccount to: aDestinationAccount.

	value := anAmountToTransfer.
	depositLeg := DepositLegTransaction register: anAmountToTransfer on: aDestinationAccount of: self.
	withdrawLeg := WithdrawLegTransaction register: anAmountToTransfer on: anOriginAccount of: self.! !


!Transfer methodsFor: 'accessing' stamp: 'IA 11/27/2021 03:31:47'!
depositLeg

	^ depositLeg.! !

!Transfer methodsFor: 'accessing' stamp: 'IA 11/27/2021 04:13:04'!
value

	^ value.! !

!Transfer methodsFor: 'accessing' stamp: 'IA 11/27/2021 03:28:46'!
withdrawLeg

	^ withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'IA 11/27/2021 02:56:52'!
from: anOriginAccount to: aDestinationAccount for: anAmountToTransfer 

	self assertThatTransferValueIsNotZero: anAmountToTransfer.
	self assertThatTransferValueIsPositive: anAmountToTransfer.

	^ self new initializeWithAmount: anAmountToTransfer from: anOriginAccount to: aDestinationAccount.! !


!Transfer class methodsFor: 'assertions' stamp: 'IA 11/27/2021 02:56:24'!
assertThatTransferValueIsNotZero: aTransferValue
	
	| transferZeroPesos |
	
	transferZeroPesos := 0*peso.

	(aTransferValue = transferZeroPesos) ifTrue: [ self error: self transferValueCantBeZeroErrorDescription. ].! !

!Transfer class methodsFor: 'assertions' stamp: 'IA 11/27/2021 02:56:03'!
assertThatTransferValueIsPositive: aTransferValue
	
	| transferZeroPesos |
	
	transferZeroPesos := 0*peso.

	(aTransferValue < transferZeroPesos) ifTrue: [ self error: self transferValueCantBeNegativeErrorDescription. ].! !


!Transfer class methodsFor: 'signal errors' stamp: 'IA 11/27/2021 02:56:14'!
transferValueCantBeNegativeErrorDescription

	^ 'Error: Transfer value cant be negative!!'.! !

!Transfer class methodsFor: 'signal errors' stamp: 'IA 11/27/2021 02:56:24'!
transferValueCantBeZeroErrorDescription

	^ 'Error: Transfer value cant be zero!!'.! !
