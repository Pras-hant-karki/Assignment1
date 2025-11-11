import 'package:assignment_dart/bank_account.dart';

void main() {
  final bank = Bank();

  final s = SavingsAccount('SA-001', 'Aktar', 1100);
  final c = CheckingAccount('CA-001', 'Bablu', 100);
  final p = PremiumAccount('PA-001', 'Chacha', 18000);

  bank.createAccount(s);
  bank.createAccount(c);
  bank.createAccount(p);

  s.withdraw(400); 
  s.withdraw(200); 
  s.calculateInterest(); 

  c.withdraw(150); 
  c.deposit(300);  

  p.withdraw(6000); 
  p.withdraw(4000); 
  p.calculateInterest(); 

  bank.transfer('SA-001', 'CA-001', 300); 

  bank.generateReport();
}