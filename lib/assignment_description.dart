//Banking System OOP Challenge
// Problem Statement
// Design and implement a banking system in Dart that demonstrates all four pillars of ObjectOriented Programming. The system should support multiple account types with different
// rules and behaviors.
// Requirements
// 1. Create an abstract base class BankAccount that includes:
// • Private fields for account number, account holder name, and balance
// • Abstract methods for withdraw() and deposit()
// • A method to display account information
// • Proper encapsulation with getters/setters
// 2. Implement three types of accounts that inherit from BankAccount:
// SavingsAccount:
// • Minimum balance requirement of $500
// • 2% interest calculation method
// • Withdrawal limit of 3 transactions per month
// CheckingAccount:
// • No minimum balance
// • $35 overdraft fee if balance goes below $0
// • No withdrawal limits
// PremiumAccount:
// • Minimum balance of $10,000
// • 5% interest calculation
// • Unlimited free withdrawals
// 3. Create an interface/abstract class InterestBearing for accounts that earn interest
// 4. Implement a Bank class that can:
// • Create new accounts
// • Find accounts by account number
// • Transfer money between accounts
// • Generate reports of all accounts
// Expected Implementation Structure
// The complete implementation code is provided as a reference. Students should study this
// structure and understand how each OOP principle is demonstrated.
// Questions to Answer
// 1. Identify and explain how each OOP principle is demonstrated in this code:
// a) Where is encapsulation used and why?
// b) How does inheritance help in this design?
// c) Give examples of polymorphism in action
// d) What role does abstraction play?
// 2. Extend the system by adding:
// a) A StudentAccount class with no fees and a maximum balance of $5,000
// b) A method to calculate and apply monthly interest to all interest-bearing accounts
// c) Transaction history tracking for each account
// 3. Refactor suggestion: How would you improve the error handling and validation in
// this system?