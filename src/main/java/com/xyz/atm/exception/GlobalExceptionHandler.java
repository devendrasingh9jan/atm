package com.xyz.atm.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.view.RedirectView;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ResourceNotFound.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public RedirectView handleResourceNotFoundException(ResourceNotFound ex) {
        RedirectView redirectView = new RedirectView("/error");
        redirectView.addStaticAttribute("error", ex.getMessage());
        return redirectView;
    }
}
