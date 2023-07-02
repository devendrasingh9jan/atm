package com.xyz.atm.service;

import com.xyz.atm.exception.ResourceNotFound;
import com.xyz.atm.model.*;
import com.xyz.atm.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class AccountService {
    private final CustomerRepository customerRepository;
    private final AccountRepository accountRepository;
    private final TransactionRepository transactionRepository;

    @Autowired
    public AccountService(CustomerRepository customerRepository,
                       AccountRepository accountRepository,
                       TransactionRepository transactionRepository) {
        this.customerRepository = customerRepository;
        this.accountRepository = accountRepository;
        this.transactionRepository = transactionRepository;
    }

    private static final DecimalFormat decfor = new DecimalFormat("0.00");

    public Double getAccountSummary(Long userId) {
        Long accountId = getCustomerId(userId);
        Double currentBalance = 0.00;
        Optional<Account> accountOptional = accountRepository.findByCustomerId(accountId);
        if (accountOptional.isPresent()) {
            currentBalance = accountOptional.get().getBalance();
        }
        String formatted = decfor.format(currentBalance);
        return Double.valueOf(formatted);
    }

    public List<TransactionView> getAccountStatement(Long userId) {
        Long customerId = getCustomerId(userId);
        Optional<Account> accountOptional = accountRepository.findByCustomerId(customerId);
        List<TransactionView> transactions = null;
        if (accountOptional.isPresent()) {
            Account account = accountOptional.get();
            Long accountId = account.getId();
            transactions = transactionRepository.findAllByAccountId(accountId);
        }
        return transactions;
    }



    private Long getCustomerId(Long userId) {
        Optional<Customer> customerOptional = customerRepository.findByUserId(userId);
        Long accountId = null;
        if (customerOptional.isPresent()) {
            accountId = customerOptional.get().getId();
        }
        return accountId;
    }
}
