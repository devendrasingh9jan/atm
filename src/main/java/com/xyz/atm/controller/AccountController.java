package com.xyz.atm.controller;

import com.xyz.atm.model.User;
import com.xyz.atm.repository.TransactionView;
import com.xyz.atm.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("account")
public class AccountController {
    @Autowired
    private AccountService accountService;

    @GetMapping("/")
    public String home(){
        return "account";
    }

    @GetMapping(value = "/summary")
    public ResponseEntity<Double> viewAccountSummary(HttpSession session, HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Double accountSummary = accountService.getAccountSummary(user.getId());
            return ResponseEntity.ok(accountSummary);
        } else {
            response.sendRedirect("/login");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }


    @GetMapping(value = "/statement")
    public ResponseEntity<List<TransactionView>> viewAccountStatement(HttpSession session, HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if(Objects.nonNull(user)){
            List<TransactionView> accountStatement = accountService.getAccountStatement(user.getId());
            return ResponseEntity.ok(accountStatement);
        } else {
            response.sendRedirect("/login");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

}
