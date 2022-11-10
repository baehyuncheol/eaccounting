package com.web.eaccounting.front.login;


import com.web.eaccounting.front.common.CookieManager;
import com.web.eaccounting.front.common.SessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class LoginService {

    @Autowired
    public LoginMapper mapper;

    public Map<String, Object> loginUser(Map<String, String> params, HttpServletRequest httpSvltReq, HttpServletResponse httpSvltRes) throws Exception {
        log.debug("######################################################################123123");
        Map<String, Object> returnMap = new HashMap<>();
        String jSession = CookieManager.getCookieValue(httpSvltReq,"JSESSIONID");

        String userId = params.get("id");

        LoginDto userInfo = mapper.selectEmp(userId);

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
