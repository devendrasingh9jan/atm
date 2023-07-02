package com.xyz.atm.service;

import com.xyz.atm.model.Account;
import com.xyz.atm.model.Cheque;
import com.xyz.atm.model.Customer;
import com.xyz.atm.model.Transaction;
import com.xyz.atm.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
public class ChequeService {

    private final AccountRepository accountRepository;
    private final TransactionRepository transactionRepository;
    private final ChequeRepository chequeRepository;

    private final CustomerRepository customerRepository;

    @Autowired
    public ChequeService(ChequeRepository chequeRepository, AccountRepository accountRepository,
                      TransactionRepository transactionRepository, CustomerRepository customerRepository) {
        this.chequeRepository = chequeRepository;
        this.accountRepository = accountRepository;
        this.transactionRepository = transactionRepository;
        this.customerRepository = customerRepository;
    }
    public String deposit(Cheque cheque) {
        Optional<Customer> customerFromOptional = customerRepository.findByUserId(cheque.getDepositedById());
        if (customerFromOptional.isPresent()) {
            Customer customer = customerFromOptional.get();
            Optional<Account> accountFromOptional = accountRepository.findByCustomerId(customer.getId());
            Optional<Account> accountToOptional = accountRepository.findById(cheque.getAccountId());
            if (accountFromOptional.isPresent() && accountToOptional.isPresent()) {
                Account accountFrom = accountFromOptional.get();
                Account accountTo = accountToOptional.get();
                if (accountFrom.getBalance() > 0 && cheque.getCheckAmount() > 0 && accountFrom.getBalance() >= cheque.getCheckAmount()) {
                    cheque.setCheckDate(new Date());
                    cheque.setCustomer(customer);
                    Double updatedDebitBalance = accountFrom.getBalance() - cheque.getCheckAmount();
                    accountFrom.setBalance(updatedDebitBalance);
                    Transaction transactionDebit = new Transaction();
                    transactionDebit.setDate(new Date());
                    transactionDebit.setTransactionType("Debit");
                    transactionDebit.setAmount(cheque.getCheckAmount());
                    transactionDebit.setAccount(accountFrom);
                    transactionRepository.save(transactionDebit);
                    Double updatedCreditBalance = accountTo.getBalance() + cheque.getCheckAmount();
                    accountTo.setBalance(updatedCreditBalance);
                    Transaction transactionCredit = new Transaction();
                    transactionCredit.setDate(new Date());
                    transactionCredit.setTransactionType("Credit");
                    transactionCredit.setAmount(cheque.getCheckAmount());
                    transactionCredit.setAccount(accountTo);
                    transactionRepository.save(transactionCredit);
                    accountRepository.save(accountTo);
                    chequeRepository.save(cheque);
                    return cheque.getCheckAmount() + " Deposited";
                } else {
                    return "Insufficient balance.";
                }
            } else {
                return "User doesn't have any account";
            }
        }
        return "User doesn't exist";
    }
}
