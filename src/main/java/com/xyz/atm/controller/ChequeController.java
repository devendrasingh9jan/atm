package com.xyz.atm.controller;

import com.xyz.atm.model.Cheque;
import com.xyz.atm.model.User;
import com.xyz.atm.service.ChequeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@Controller
@RequestMapping("cheque")
public class ChequeController {

    @Autowired
    private ChequeService chequeService;

    @PostMapping(value = "/deposit")
    public ResponseEntity<String> deposit(@RequestBody Cheque cheque, HttpSession session, HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if(Objects.nonNull(user)){
            cheque.setDepositedById(user.getId());
            String status = chequeService.deposit(cheque);
            return ResponseEntity.ok(status);
        } else {
            response.sendRedirect("/login");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}
