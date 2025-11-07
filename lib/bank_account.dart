// abstraction + encapsulation + inheritance + polymorphism
abstract class BankAccount {
  // private fields (encapsulation)
  String _accountNumber;
  String _accountHolder;
  double _balance;

  // constructor
  BankAccount(this._accountNumber, this._accountHolder, this._balance);

  // getters and setters
  String get getAccountNumber => _accountNumber;
  String get getAccountHolder => _accountHolder;
  double get getBalance => _balance;

  set setBalance(double balance) {
    _balance = balance;
  }

  // abstract methods (abstraction)
  void withdraw(double amount);
  void deposit(double amount);

  // concrete method
  void displayAccountInfo() {
    print('Account: $_accountNumber | Holder: $_accountHolder | Balance: $_balance');
  }
}
