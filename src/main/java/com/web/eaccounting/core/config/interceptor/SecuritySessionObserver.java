/*
package com.web.eaccounting.core.config.interceptor;

import com.gsitm.eaccounting.core.dto.TbLogDto;
import com.gsitm.eaccounting.core.dto.TbLoginDto;
import com.gsitm.eaccounting.core.mybatis.type.CamelCaseMap;
import com.gsitm.eaccounting.core.utils.StringUtil;
import com.gsitm.eaccounting.front.login.service.LoginService;
import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.front.login.service.LoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.file.AccessDeniedException;
import java.util.Enumeration;

@Component
@Slf4j
public class SecuritySessionObserver extends HandlerInterceptorAdapter implements SecurityInvocation {

    private final LoginService loginService;

    @Autowired
    public SecuritySessionObserver (LoginService loginService)
    {
        this.loginService = loginService;
    }

    @Override
    public int getOrder() {
        return 1;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        Object obj = session.getAttribute("SESSION_USERINFO");
        if ( obj == null ){
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            response.sendRedirect("/loginView");
            return false;
        }

        if( !"XMLHttpRequest".equals(request.getHeader("x-requested-with")))
        {
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

            log.info("returnStr==>"+returnStr);

            TbLoginDto loginDto = (TbLoginDto)obj;
            TbLogDto logDto = new TbLogDto();

            logDto.setEmplNo(loginDto.getEmplNo());
            logDto.setRequestUrl(returnStr);

            //어떤 사용자가 어떤 url에 접근했는지 로그 찍음...
            loginService.insertLog(logDto);
            //현재 URL 체크하여 접근가능한 권한인지 체크한다.

            //현재 URL, 사번, 부서코드를 가지고 해당 페이지에 권한이 있는지 체크한다.
            CamelCaseMap caseMap = loginService.getAuthor(loginDto.getEmplNo(), loginDto.getDeptCode(), request.getRequestURI());

            String menuId = request.getParameter("menuId");
            log.info("menu_id0000===========>" + menuId);

            if( caseMap != null ) {
                if( "Y".equals(caseMap.getString("authorYn")) )
                {
                    //디비에서 가져온 menuId의 값이 ""빈값이면 request.getParameter로 가져온 menuId의 값으로 대체함..
                    //request로 가져온 menuId의 값도 null이나 빈값이면 prgm 에 있는 권한으로 처리한다.
                    menuId = !"".equals(caseMap.getString("menuId"))?caseMap.getString("menuId") : menuId;

                    if( menuId != null && !"".equals(menuId) )
                    {
                        CamelCaseMap caseMapWithMenuId = loginService.getAuthorWithMenuId(loginDto.getEmplNo(), loginDto.getDeptCode(),menuId);
                        if( caseMapWithMenuId != null) {
                            log.info("caseMapWithMenuId=====>" + caseMapWithMenuId.getString("authorYn"));
                            if( "N".equals(caseMapWithMenuId.getString("authorYn"))){
                                throw new AccessDeniedException("권한이 없습니다.");
                            }
                        } else {
                            log.info("##################");
                            log.info("menu권한없음~~~~~~~~");
                            log.info("##################");
                            throw new AccessDeniedException("권한이 없습니다.");
                        }
                    }
                }
                else{
                    log.info("##################");
                    log.info("menu권한N없음~~~~~~~~");
                    log.info("##################");
                    throw new AccessDeniedException("권한이 N없습니다.");
                }
            }
            else
            {
                //최후에는 이전페이지로 이동하는 로직을 구현해야함...
                log.info("##################");
                log.info("menu2222권한없음~~~~~~~~");
                log.info("##################");
                //throw new AccessDeniedException("권한이 없습니다.");
            }
        }
        else
        {
            log.info("##################");
            log.info("ajax 호출은 제외....");
            log.info("##################");
        }

        return true;
    }
}
*/