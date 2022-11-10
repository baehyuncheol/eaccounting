package com.web.eaccounting.front;

import com.web.eaccounting.front.login.LoginDto;
import com.web.eaccounting.front.menu.MenuDto;
import org.apache.catalina.filters.ExpiresFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {

    @GetMapping("/")
    public Object login(ModelAndView modelAndView, HttpServletRequest request) {
        LoginDto loginVo = (LoginDto) request.getSession().getAttribute("SESSION_USERINFO");
        if (loginVo != null) {
            return "redirect:/main";
        }
        modelAndView.setViewName("center:login");
        modelAndView.addObject("login","true");
        return modelAndView;
    }

    @GetMapping("/main")
    public Object main(ModelAndView modelAndView, HttpServletRequest request)
    {
        LoginDto loginVo = (LoginDto) request.getSession().getAttribute("SESSION_USERINFO");
        if (loginVo == null) {
            return "redirect:/";
        }

        //세션에 있는 값을 사용한다.
        String deptCode = loginVo.getUserID();
        String emplNo = loginVo.getEmplNo();

        //List<MenuDto> mainList = payDocService.getBodyMenuData(emplNo, deptCode);

        modelAndView.addObject("sideHiddden","true");
        modelAndView.setViewName("default:main");
        return modelAndView;
    }
}
