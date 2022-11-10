package com.web.eaccounting.front.common;

import com.web.eaccounting.front.login.LoginDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Component
public class SessionUtil {


    /**
     * Session 객체 조회
     *
     * @param req
     * @param key
     * @return
     * @throws Exception
     */
    public static Object get(HttpServletRequest req, String key) {

        Object obj = null;
        HttpSession session = null;
        session = req.getSession(false);
        if(session != null){
            if (session.isNew()) {
                log.debug("Session isNew true");
            } else {
                log.debug("Session isNew false");
            }
            obj = (Object) session.getAttribute(key);
        }
        log.debug("## obj " + obj);
        return obj;

    }

    /**
     * Session 객체로 Login된 ID return
     *
     * @param req
     * @return
     */
    public static String getLoginId(HttpServletRequest req) {

        LoginDto adminUser = null;
        HttpSession session = null;
        session = req.getSession(false);

        String adminId = null;
        if(session != null){
            if (session.isNew()) {
                log.debug("Session isNew true");
            } else {
                log.debug("Session isNew false");
            }
            adminUser = (LoginDto) session.getAttribute(AdminConst.SESSION_NAME);

            if (adminUser != null) {
                adminId = adminUser.getEmplNo();
            }
        }
        return adminId;
    }


    /**
     * Session 객체 등록
     *
     * @param req
     * @param key
     * @param obj
     * @throws Exception
     */
    public static void put(HttpServletRequest req, String key, Object obj) {

        HttpSession session = null;
        session = req.getSession(true);
        if (session.isNew()) {
            log.debug("Session isNew true");
        } else {
            log.debug("Session isNew false");
        }
        session.setAttribute(key, obj);

    }

    /**
     * Session 객체 삭제
     *
     * @param req
     * @param key
     * @throws Exception
     */
    public static void remove(HttpServletRequest req, String key) {

        HttpSession session = null;
        session = req.getSession(false);
        if (session != null) {
            if (session.isNew()) {
                log.debug("Session isNew true");
            } else {
                log.debug("Session isNew false");
            }
            session.removeAttribute(key);
        }

    }

    /**
     * Session 종료 (logout 시 처리)
     *
     * @param req
     * @throws Exception
     */
    public static void invalidate(HttpServletRequest req) throws Exception {

        HttpSession session = null;
        session = req.getSession(false);
        if (session != null) {
            if (session.isNew()) {
                log.debug("Session isNew true");
            } else {
                log.debug("Session isNew false");
            }
            session.invalidate();
        }
    }

    public static LoginDto getUserInfo(HttpServletRequest request){
        LoginDto info = (LoginDto)request.getSession().getAttribute("SESSION_USERINFO");
        return info == null? new LoginDto():info;
    }
}