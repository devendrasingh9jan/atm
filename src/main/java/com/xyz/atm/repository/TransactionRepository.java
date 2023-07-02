package com.xyz.atm.repository;

import com.xyz.atm.model.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction,Long> {

    List<TransactionView> findAllByAccountId(Long accountId);
}
