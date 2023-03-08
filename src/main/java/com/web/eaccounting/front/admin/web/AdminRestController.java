package com.web.eaccounting.front.admin.web;


import com.web.eaccounting.core.dto.MenuDto;
import com.web.eaccounting.front.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminRestController {

    private final AdminService adminService;

    @GetMapping(value = "/menus")
    public List<MenuDto> selectMenus(){
        return adminService.selectMenus();
    }

    @GetMapping(value = "/getMenu")
    public ArrayList<MenuDto> selectByMenu(MenuDto tbMenuDto) {
        return adminService.selectByMenu(tbMenuDto);
    }
}
