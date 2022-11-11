package com.web.eaccounting.front.menu.web;

import com.web.eaccounting.front.common.dto.LoginDto;
import com.web.eaccounting.front.common.dto.MenuDto;
import com.web.eaccounting.front.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @RequestMapping(value = "/menu", method = RequestMethod.GET)
    @ResponseBody
    public List<MenuDto> getMenu(HttpServletRequest req, HttpServletResponse res, String gubun)
    {
        List<MenuDto> menuList = new ArrayList<>();
        Map<String,Object> resultMap = new HashMap<>();

        try {
            LoginDto loginVo = (LoginDto) req.getSession().getAttribute("SESSION_USERINFO");

            String deptCode = loginVo.getDeptCode();
            String emplNo = loginVo.getEmplNo();

            menuList = menuService.getMenuList(emplNo, deptCode);
        }
        catch (Exception ex)
        {
            resultMap.put("status", "fail");
            resultMap.put("msg", ex.getMessage());
            log.error("LoginException : {}",ex);
        }

        return menuList;
    }

    @RequestMapping(value = "/menusub", method = RequestMethod.GET)
    @ResponseBody
    public List<MenuDto> getSubMenu(HttpServletRequest req, HttpServletResponse res, @RequestParam String menuId, @RequestParam String lvl)
    {
        List<MenuDto> subMenuList = new ArrayList<>();
        HashMap<String, Object> resultMap = new HashMap<>();

        try
        {
            LoginDto loginVo = (LoginDto) req.getSession().getAttribute("SESSION_USERINFO");

            String deptCode = loginVo.getDeptCode();
            String emplNo = loginVo.getEmplNo();

            subMenuList = menuService.getLeftSubMenuData(emplNo, deptCode, menuId, lvl);
        }
        catch (Exception ex)
        {
            resultMap.put("status", "fail");
            resultMap.put("msg", ex.getMessage());
            log.error("LoginException : {}",ex);
        }

        return subMenuList;
    }


}
