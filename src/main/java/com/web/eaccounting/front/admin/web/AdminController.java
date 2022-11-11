package com.web.eaccounting.front.admin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

    @GetMapping("/config/menuManagement")
    public ModelAndView menuSampleView(ModelAndView modelAndView) {
        modelAndView.setViewName("default:admin/menuManagement");
        return modelAndView;
    }
}
