package com.web.eaccounting.front.admin.web;

import com.web.eaccounting.front.admin.service.AdminService;
import com.web.eaccounting.front.common.dto.MenuDto;
import com.web.eaccounting.front.login.service.LoginService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AdminWebController {

    private final AdminService adminService;

    @RequestMapping("/admin/menuManagement")
    public ModelAndView menuSampleView(ModelAndView modelAndView) {
        modelAndView.setViewName("default:admin/menuManagement");
        return modelAndView;
    }

    //그리드 트리
    @GetMapping
    @RequestMapping("/admin/menuManagement/tree")
    public ModelAndView menuManagementView(ModelAndView modelAndView) {
        modelAndView.setViewName("default:menuManagement/menuManagementGridTree");
        return modelAndView;
    }
}
