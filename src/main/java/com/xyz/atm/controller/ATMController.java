package com.xyz.atm.controller;

import com.xyz.atm.model.User;
import com.xyz.atm.service.ATMService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@Controller
@RequestMapping("/atm")
public class ATMController {

    @Autowired
    private ATMService atmService;

    @GetMapping("/")
    String withdraw() {
        return "withdraw";
    }

    @GetMapping("/withdraw")
    public ResponseEntity<String> withdrawCash(@RequestParam Double amount, HttpSession session, HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if(Objects.nonNull(user)){
            String status = atmService.withdrawCash(user.getId(), amount);
            return ResponseEntity.ok(status);
        } else {
            response.sendRedirect("/login");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
    
    @GetMapping("/fast-withdraw")
    public ResponseEntity<String> fastCashWithdraw(@RequestParam Integer selectedAmountIndex, HttpSession session, HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("user");
        if(Objects.nonNull(user)){
            String status = atmService.fastCashWithdrawal(user.getId(), selectedAmountIndex);
            return ResponseEntity.ok(status);
        } else {
            response.sendRedirect("/login");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

}
