package com.xyz.atm.repository;

import com.xyz.atm.model.Cheque;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChequeRepository extends JpaRepository<Cheque,Long> {
}
