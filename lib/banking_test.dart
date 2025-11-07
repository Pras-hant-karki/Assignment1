import 'bank.dart';

void main() {
  Bank bank = Bank();

  var acc1 = SavingsAccount("S001", "Aktar Javed", 1000);
  var acc2 = CheckingAccount("C001", "Bablu Bhikari", 500);
  var acc3 = PremiumAccount("P001", "Chacha Choudhary", 20000);

  bank.addAccount(acc1);
  bank.addAccount(acc2);
  bank.addAccount(acc3);

  // Transactions
  acc1.withdraw(200);
  acc1.withdraw(100);
  acc1.withdraw(50);
  acc1.withdraw(10); // exceeds limit

  acc2.withdraw(600); // overdraft
  acc3.withdraw(5000);

  // Deposits
  acc1.deposit(300);
  acc2.deposit(200);
  acc3.deposit(1000);

  // Transfer
  bank.transfer("S001", "C001", 100);

  // Apply monthly interest
  bank.applyMonthlyInterest();

  // Show all accounts
  bank.showAllAccounts();
}
