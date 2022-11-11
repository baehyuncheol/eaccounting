package com.web.eaccounting.front.login.service;


import com.web.eaccounting.front.common.CookieManager;
import com.web.eaccounting.front.common.SessionUtil;
import com.web.eaccounting.front.common.dto.LoginDto;
import com.web.eaccounting.front.login.mapper.LoginMapper;
import com.web.eaccounting.front.login.repository.LoginRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class LoginService {

   // private final LoginRepository loginRepository;
    private final LoginMapper mapper;

    @Autowired
    public LoginService(LoginMapper  mapper) {
        //this.loginRepository = loginRepository;
        this.mapper = mapper;
    }

    public Map<String, Object> loginUser(Map<String, String> params, HttpServletRequest httpSvltReq, HttpServletResponse httpSvltRes) throws Exception {
        log.debug("######################################################################123123");
        Map<String, Object> returnMap = new HashMap<>();
        String jSession = CookieManager.getCookieValue(httpSvltReq,"JSESSIONID");

        String userId = params.get("id");

        LoginDto userInfo = mapper.findByEmplNo(userId);

        if( userInfo == null) {
            returnMap.put("status", "fail");
            // 존재하지않는 아이디
            returnMap.put("msg", "존재하지 않는 사용자 입니다.");
            return  returnMap;
        }

        LoginDto loginVo = SessionUtil.getUserInfo(httpSvltReq);;
        loginVo.setEmplNo(userId);
        loginVo.setJSessionId(jSession);
        loginVo.setUserName(userInfo.getUserName());
        loginVo.setAuthorId("1");
        adminInfoSetSessionAttr(loginVo, httpSvltReq);

        String userPw = (String)params.get("password");

        log.debug("userId==>"+userId);
        log.debug("userPw==>"+userPw);

        returnMap.put("status", "success");
        returnMap.put("msg", "로그인 성공!");
        returnMap.put("returnUrl", params.get("returnUrl"));

        return  returnMap;
    }

    public void adminInfoSetSessionAttr(LoginDto loginDto, HttpServletRequest httpSvltReq) throws Exception {
        httpSvltReq.getSession().setAttribute("SESSION_USERINFO", loginDto);
        httpSvltReq.getSession().setAttribute("userId", loginDto.getEmplNo());
        httpSvltReq.getSession().setMaxInactiveInterval(60 * 60 * 60);
    }
}
