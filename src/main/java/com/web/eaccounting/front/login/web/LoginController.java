package com.web.eaccounting.front.login.web;

import java.util.HashMap;
import java.util.Map;

import com.web.eaccounting.front.login.service.LoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(@RequestParam Map<String, String> params, HttpServletRequest req,
                                     HttpServletResponse res) {
        Map<String,Object> resultMap = new HashMap<>();
        try {
            resultMap =	loginService.loginUser(params,req,res);
        } catch (Exception ex) {
            resultMap.put("status", "fail");
            resultMap.put("msg", ex.getMessage());
            log.error("LoginException : {}",ex);
        }

        return resultMap;
    }

}
