abstract class BankAccount {
  final String _accNumber;
  String _accName;
  double _balance;

  BankAccount(this._accNumber, this._accName, this._balance);

  void withdraw(double amount);
  
  void deposit(double amount);
  
  void displayAccountInfo() {
    print('Account Number: $_accNumber');
    print('Account Holder Name: $_accName');
    print('Balance: $_balance');
  }
  String get accNumber {
    return _accNumber;
  } 
 
  set accName(String name) {
    _accName = name;
  }
  
  set balance(double amount) {
    _balance = amount;
  }
  
}

// List<String> _transactions = [];

// void recordTransaction(String message) {
//   _transactions.add(message);
// }

// void showTransactions() {
//   print('Transactions for $_accName:');
//   for (var t in _transactions) print('- $t');
// }

class SavingsAccount extends BankAccount {
  final  double _minimumBalance = 500.0;
  final  double _interestRate = 0.02;
  final  int _withdrawalLimit = 3;
  int _withdrawalsThisMonth = 0;

  SavingsAccount(super._accNumber, super._accName, super._balance);

  @override
  void withdraw(double amount) {
    if (_withdrawalsThisMonth >= _withdrawalLimit) {
      print('Withdrawal limit reached for this month.');
      return;
    }
    if (_balance - amount < _minimumBalance) {
      print('Cannot withdraw. Minimum balance requirement of \\ $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    _withdrawalsThisMonth++;
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }

  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print('Interest of \\$interest added. New balance: \\$_balance');
  }
} 

class CheckingAccount extends BankAccount {
  static const double _overdraftFee = 35.0;

  CheckingAccount(super._accNumber, super._accName, super._balance);

  @override
  void withdraw(double amount) {
    _balance -= amount;
    if (_balance < 0) {
      _balance -= _overdraftFee;
      print('Overdraft! An overdraft fee of \$$_overdraftFee has been applied.');
    }
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }
}

class PremiumAccount extends BankAccount {
  final double _minimumBalance = 10000.0;
  final double _interestRate = 0.05;

  PremiumAccount(super._accNumber, super._accName, super._balance);

  @override
  void withdraw(double amount) {
    if (_balance - amount < _minimumBalance) {
      print('Cannot withdraw. Minimum balance requirement of \\ $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }

  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print('Interest of \\$interest added. New balance: \\$_balance');
  }
}
// class StudentAccount extends BankAccount {
//   final double _maxBalance = 5000.0;

//   StudentAccount(super._accNumber, super._accName, super._balance);

//   @override
//   void deposit(double amount) {
//     if (_balance + amount > _maxBalance) {
//       print('Cannot exceed max balance of \$$_maxBalance');
//       return;
//     }
//     _balance += amount;
//     print('Deposited \$amount. New balance: \$$_balance');
//   }

//   @override
//   void withdraw(double amount) {
//     if (amount > _balance) {
//       print('Insufficient funds.');
//       return;
//     }
//     _balance -= amount;
//     print('Withdrew \$amount. New balance: \$$_balance');
//   }
// }


class Bank {
  final Map<String, BankAccount> _accounts = {};

  void createAccount(BankAccount account) {
    _accounts[account.accNumber] = account;
    print('Account created: ${account.accNumber}');
  }

  BankAccount? findAccount(String accNumber) {
    return _accounts[accNumber];
  }

  void transfer(String fromaccNumber, String toaccNumber, double amount) {
    BankAccount? fromAccount = findAccount(fromaccNumber);
    BankAccount? toAccount = findAccount(toaccNumber);

  
// void applyMonthlyInterest() {
//   _accounts.forEach((_, account) {
//     if (account is SavingsAccount) account.calculateInterest();
//     if (account is PremiumAccount) account.calculateInterest();
//   });
//   print('Monthly interest applied to all interest-bearing accounts.');
// }
    if (fromAccount == null || toAccount == null) {
      print('One or both accounts not found.');
      return;
    }

    fromAccount.withdraw(amount);
    toAccount.deposit(amount);
    print('Transferred \\$amount from $fromaccNumber to $toaccNumber');
  }

  void generateReport() {
    print('Bank Accounts Report:');
    _accounts.forEach((accNumber, account) {
      account.displayAccountInfo();
     
    });
  }
}