package com.web.eaccounting.core.config.interceptor;

import com.web.eaccounting.core.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Enumeration;

@Slf4j
@Component
public class LoginInterceptor extends HandlerInterceptorAdapter implements SecurityInvocation{

    @Override
    public int getOrder() {
        return 0;
    }

    // preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        Object obj = session.getAttribute("SESSION_USERINFO");

        String retUri = request.getRequestURI();
        StringBuffer sb = new StringBuffer();
        // 키값을 나열한다.
        Enumeration querySet = request.getParameterNames();
        while(querySet.hasMoreElements()) {
            String key = (String)querySet.nextElement();
            String value = request.getParameter(key);
            sb.append(key).append("=").append(value);
            sb.append("&");
        }
        String queryStr = sb.toString();
        if(queryStr != null && !"".equals(queryStr)) {
            queryStr = "?" + queryStr.substring(0, queryStr.length()-1);
        }
        else {
            queryStr = StringUtil.nvl(queryStr, "");
        }
        String returnStr = retUri + queryStr;

        //log.debug("쿠키값 가져오기==>"+ CookieManager.getCookieValue(request, "java_emp_id"));
        //CookieManager.setCookieValue(response, "java_emp_id",3600,"2");

        log.debug("obj====>로그인정보 있는지 확인.."+obj);
        if ( obj == null ){

            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            // ajax 호출인지 아닌지 판단해서 ajax호출이면 500에러를 발생시킴.

            if( !"XMLHttpRequest".equals(request.getHeader("x-requested-with")))
                response.sendRedirect("/loginView?returnUrl="+ URLEncoder.encode(returnStr,"utf-8") );
            else
                response.sendError(501);

            return false; // 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
        }

        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
        return true;
    }

    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }
}
