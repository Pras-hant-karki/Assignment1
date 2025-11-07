// -------------------------------------
// Abstract Base Class
// -------------------------------------
abstract class BankAccount {
  String _accNumber;
  String _accName;
  double _balance;
  List<String> _transactions = []; // ✅ Transaction history

  BankAccount({
    required String accNumber,
    required String accName,
    required double balance,
  })  : _accNumber = accNumber,
        _accName = accName,
        _balance = balance {
    _transactions.add("Account created with initial balance \$$_balance");
  }

  // Getters and Setters
  String get accountNumber => _accNumber;
  String get holderName => _accName;
  double get balance => _balance;

  void updateBalance(double newAmount) {
    _balance = newAmount;
  }

  // Abstract methods
  void withdraw(double amount);
  void deposit(double amount);

  // Transaction tracking
  void recordTransaction(String description) {
    _transactions.add(description);
  }

  void showTransactions() {
    print("\nTransaction history for $_accName ($_accNumber):");
    for (var t in _transactions) {
      print(" - $t");
    }
  }

  // Display info
  void displayInfo() {
    print("--------------------------");
    print("Account Number: $_accNumber");
    print("Account Holder: $_accName");
    print("Balance: \$${_balance.toStringAsFixed(2)}");
  }
}

// -------------------------------------
// Interest Interface
// -------------------------------------
abstract class InterestBearing {
  void calculateInterest();
}

// -------------------------------------
// Savings Account
// -------------------------------------
class SavingsAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 500;
  static const double _interestRate = 0.02;
  int _withdrawalCount = 0;
  static const int _withdrawalLimit = 3;

  SavingsAccount({
    required super.accNumber,
    required super.accName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$${amount.toStringAsFixed(2)}");
      print("\$$amount deposited into Savings Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (_withdrawalCount >= _withdrawalLimit) {
      print("Withdrawal limit reached for this month.");
      return;
    }
    if (balance - amount < _minBalance) {
      print("Cannot withdraw: Must maintain at least \$$_minBalance.");
      return;
    }

    updateBalance(balance - amount);
    _withdrawalCount++;
    recordTransaction("Withdraw \$${amount.toStringAsFixed(2)}");
    print("\$$amount withdrawn from Savings Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    recordTransaction("Interest of \$${interestAmt.toStringAsFixed(2)} added");
    print("Interest of \$${interestAmt.toStringAsFixed(2)} applied.");
  }
}

// -------------------------------------
// Checking Account
// -------------------------------------
class CheckingAccount extends BankAccount {
  static const double _overdraftFee = 35;

  CheckingAccount({
    required super.accNumber,
    required super.accName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$${amount.toStringAsFixed(2)}");
      print("\$$amount deposited into Checking Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
      return;
    }

    updateBalance(balance - amount);
    if (balance < 0) {
      updateBalance(balance - _overdraftFee);
      recordTransaction("Overdraft fee of \$$_overdraftFee charged");
      print("\$$_overdraftFee overdraft fee applied.");
    }

    recordTransaction("Withdrew \$${amount.toStringAsFixed(2)}");
    print("\$$amount withdrawn from Checking Account.");
  }
}

// -------------------------------------
// Premium Account
// -------------------------------------
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 10000;
  static const double _interestRate = 0.05;

  PremiumAccount({
    required super.accNumber,
    required super.accName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$${amount.toStringAsFixed(2)}");
      print("\$$amount deposited into Premium Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < _minBalance) {
      print("Minimum balance of \$$_minBalance required.");
      return;
    }

    updateBalance(balance - amount);
    recordTransaction("Withdrew \$${amount.toStringAsFixed(2)}");
    print("\$$amount withdrawn from Premium Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    recordTransaction("Interest of \$${interestAmt.toStringAsFixed(2)} added");
    print("Interest of \$${interestAmt.toStringAsFixed(2)} applied.");
  }
}

// -------------------------------------
// (a) Student Account — New Class
// -------------------------------------
class StudentAccount extends BankAccount {
  static const double _maxBalance = 5000;

  StudentAccount({
    required super.accNumber,
    required super.accName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (balance + amount > _maxBalance) {
      print("Cannot deposit: Maximum balance of \$$_maxBalance reached.");
      return;
    }

    updateBalance(balance + amount);
    recordTransaction("Deposited \$${amount.toStringAsFixed(2)}");
    print("\$$amount deposited into Student Account.");
  }

  @override
  void withdraw(double amount) {
    if (amount > balance) {
      print("Insufficient balance.");
      return;
    }

    updateBalance(balance - amount);
    recordTransaction("Withdrew \$${amount.toStringAsFixed(2)}");
    print("\$$amount withdrawn from Student Account.");
  }
}

// -------------------------------------
// Bank Class
// -------------------------------------
class Bank {
  final List<BankAccount> _accounts = [];

  void createBankAccount(BankAccount account) {
    _accounts.add(account);
    print("Bank account ${account.accountNumber} created successfully.");
  }

  BankAccount? findAccount(String accountNumber) {
    for (var account in _accounts) {
      if (account.accountNumber == accountNumber) {
        return account;
      }
    }
    return null;
  }

  void transfer(String fromAcc, String toAcc, double amount) {
    var from = findAccount(fromAcc);
    var to = findAccount(toAcc);

    if (from == null || to == null) {
      print("One or both accounts not found.");
      return;
    }
    if (from.balance < amount) {
      print("Insufficient funds for transfer.");
      return;
    }

    from.withdraw(amount);
    to.deposit(amount);

    from.recordTransaction("Transferred \$${amount.toStringAsFixed(2)} to ${to.accountNumber}");
    to.recordTransaction("Received \$${amount.toStringAsFixed(2)} from ${from.accountNumber}");

    print("Transfer of \$$amount from ${from.accountNumber} to ${to.accountNumber} completed.");
  }

  // (b) Apply interest to all interest-bearing accounts
  void applyMonthlyInterest() {
    for (var acc in _accounts) {
      if (acc is InterestBearing) {
        acc.calculateInterest();
      }
    }
    print("Monthly interest applied to all eligible accounts.");
  }

  void generateReport() {
    print("\n======= BANK REPORT =======");
    for (var acc in _accounts) {
      acc.displayInfo();
    }
  }
}

// -------------------------------------
// Main Function
// -------------------------------------
void main() {
  var bank = Bank();

  var savings = SavingsAccount(accNumber: "SS6990A35100", accName: "Aktar Javed", balance: 3000);
  var checking = CheckingAccount(accNumber: "C234CC60000", accName: "Bablu Panwadi", balance: 1000);
  var premium = PremiumAccount(accNumber: "P456TM678330", accName: "Chacha Choudhry", balance: 17000);
  var student = StudentAccount(accNumber: "STV997300189", accName: "David Putra", balance: 1100);

  bank.createBankAccount(savings);
  bank.createBankAccount(checking);
  bank.createBankAccount(premium);
  bank.createBankAccount(student);

  // Transactions
  savings.deposit(200);
  savings.withdraw(100);
  checking.withdraw(1200);
  premium.calculateInterest();
  student.deposit(4200);
  student.withdraw(100);

  // Apply monthly interest to all interest-bearing accounts
  bank.applyMonthlyInterest();

  // Transfer money
  bank.transfer("P456", "S123", 500);

  // Reports
  bank.generateReport();

  // View transaction history
  savings.showTransactions();
  premium.showTransactions();
  student.showTransactions();
}