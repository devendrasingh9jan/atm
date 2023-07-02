package com.xyz.atm.service;

import com.xyz.atm.model.Account;
import com.xyz.atm.model.Customer;
import com.xyz.atm.model.Transaction;
import com.xyz.atm.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xyz.atm.repository.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ATMService {
    private final CustomerRepository customerRepository;
    private final AccountRepository accountRepository;
    private final TransactionRepository transactionRepository;

    @Autowired
    public ATMService(CustomerRepository customerRepository, AccountRepository accountRepository,
                          TransactionRepository transactionRepository) {
        this.customerRepository = customerRepository;
        this.accountRepository = accountRepository;
        this.transactionRepository = transactionRepository;
    }
    
    public String fastCashWithdrawal(Long userId, int selectedAmountIndex) {
        // Define a list of pre-defined withdrawal amounts
        List<Double> withdrawalAmounts = Arrays.asList(500.0,1000.0,2000.0,5000.0,10000.0,20000.0);
        // Get the selected amount from the list based on the index
        Double selectedAmount = withdrawalAmounts.get(selectedAmountIndex);
        Optional<Customer> customerOptional = customerRepository.findByUserId(userId);
        if (customerOptional.isPresent()) {
            Customer customer = customerOptional.get();
            Optional<Account> accountOptional = accountRepository.findByCustomerId(customer.getId());
            if (accountOptional.isPresent()) {
                Account account = accountOptional.get();
                if (account.getBalance()>0 && selectedAmount>0 && account.getBalance()>= selectedAmount) {
                    Double updatedBalance = account.getBalance() - selectedAmount;
                    account.setBalance(updatedBalance);
                    Transaction transactionCustomer = new Transaction();
                    transactionCustomer.setDate(new Date());
                    transactionCustomer.setTransactionType("Debit");
                    transactionCustomer.setAmount(selectedAmount);
                    transactionCustomer.setAccount(account);
                    transactionRepository.save(transactionCustomer);
                    accountRepository.save(account);
                    return selectedAmount + " withdrawn";
                } else {
                    return "Insufficient balance.";
                }
            } else {
                return "User doesn't have any account";
            }

        }
        return "";
    }

    public String withdrawCash(Long userId, Double amount) {
        Optional<Customer> customerOptional = customerRepository.findByUserId(userId);
        if (customerOptional.isPresent()) {
            Customer customer = customerOptional.get();
            Optional<Account> accountOptional = accountRepository.findByCustomerId(customer.getId());
            if (accountOptional.isPresent()) {
                Account account = accountOptional.get();
                if (account.getBalance()>0 && amount >0 && account.getBalance()>= amount) {
                    Double updatedBalance = account.getBalance() - amount;
                    account.setBalance(updatedBalance);
                    Transaction transactionCustomer = new Transaction();
                    transactionCustomer.setDate(new Date());
                    transactionCustomer.setTransactionType("Debit");
                    transactionCustomer.setAmount(amount);
                    transactionCustomer.setAccount(account);
                    transactionRepository.save(transactionCustomer);
                    accountRepository.save(account);
                    return amount + " withdrawn";
                } else {
                    return "Insufficient balance.";
                }
            } else {
                return "User doesn't have any account";
            }

        }
        return "";
    }

    
}
