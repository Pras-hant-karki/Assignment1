import 'package:assignment_dart/bank_account.dart';

void main() {
  final bank = Bank();

  final s = SavingsAccount('SA-001', 'Aktar Javed', 1100);
  final c = CheckingAccount('CA-001', 'Bablu Panwadi', 100);
  final p = PremiumAccount('PA-001', 'Chacha Choudhry', 18000);

  bank.createAccount(s);
  bank.createAccount(c);
  bank.createAccount(p);

  s.withdraw(400); // OK: leaves 600 >= 500
  s.withdraw(200); // Fails: would leave 400 < 500
  s.calculateInterest(); // +2% on current balance

  c.withdraw(150); // Goes negative → overdraft fee applied
  c.deposit(300);  // Back positive

  p.withdraw(6000); // OK: leaves 9000? No—fails (min is 10,000)
  p.withdraw(4000); // OK: leaves 11000
  p.calculateInterest(); // +5%

  bank.transfer('SA-001', 'CA-001', 300); // Only deposits if withdrawal succeeds

  bank.generateReport();
}