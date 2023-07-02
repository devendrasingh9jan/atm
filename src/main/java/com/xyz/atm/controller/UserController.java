package com.xyz.atm.controller;


import com.xyz.atm.model.Customer;
import com.xyz.atm.model.User;
import com.xyz.atm.repository.UserRepository;
import com.xyz.atm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/")
    public String home(){
        return "login";
    }

    @GetMapping("login")
    String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        User user = userRepository.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            // Authentication successful
            session.setAttribute("user", user);
            return "redirect:/account/";
        } else {
            // Authentication failed
            model.addAttribute("error", "Invalid credentials");
            return "login";
        }
    }


    @GetMapping(value = "registration")
    public ModelAndView register(@ModelAttribute("user") User user) {
        return new ModelAndView("registration", "user", new User());
    }

    @PostMapping("register")
    public String registerUser(@ModelAttribute("customer") Customer customer) {
        userService.saveUser(customer);
        return "redirect:/login";
    }

    @GetMapping("forgetPassword")
    public String forgetPassword() {
        return "forgetPassword";
    }
    @PostMapping("forgetPassword/user")
    public ModelAndView getUsername(@ModelAttribute("user") User user) {
        boolean userExists = userService.isUserExists(user.getUsername());
        if (!userExists){
            throw new IllegalArgumentException("User does not exist");
        }
        return new ModelAndView("changePassword","email",user.getUsername());
    }

    @GetMapping("changePassword/user")
    public ModelAndView changePass() throws Exception {
        return new ModelAndView("changePassword");
    }

    @PostMapping("/changePassword")
    public String changePass(@ModelAttribute("user") User user) {
        boolean userExists = userService.isUserExists(user.getUsername());
        if (userExists){
            userService.updateUser(user);
        }else {
            throw new IllegalArgumentException("User does not exist");
        }
        return "redirect:/login";
    }

    @GetMapping(value = "logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        session.invalidate();
        return "redirect:/login";
    }

    @RequestMapping(value = "/loginError", method = RequestMethod.GET)
    public String loginError(ModelMap model) {
        model.addAttribute("error", "true");
        return "login";

    }

}