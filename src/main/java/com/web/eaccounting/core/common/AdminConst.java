package com.web.eaccounting.core.common;

public class AdminConst {

    /**
     * 로그인 URL
     */
    public static final String LOGIN_URL = "/admin/loginView";
    public static final String MAIN_URL = "/";
    /**
     * 세션 KEY
     */
    public static final String SESSION_NAME = "SESSION_USERINFO";

    /**
     * 정렬 KEY 값
     */
    public static final int SORT_DEFAULT_SIZE_10 = 10;
    public static final String INDUSTRY_SORT_KEY = "seqId";
    public static final String SERVICE_SORT_KEY = "seqId";
    public static final String CASE_SORT_KEY = "caseSeqId";
    public static final String PR_SORT_KEY = "prSeqId";
    public static final String PR_CLIP_SORT_KEY = "prClipSeqId";
    public static final String PR_DOC_SORT_KEY = "prDocSeqId";
    public static final String POPUP_SORT_KEY = "popupSeqId";
    public static final String DIST_SORT_KEY = "distSeqId";

    /**
     * AdminUser 정렬 KEY 값
     */
    public static final String ADMIN_USER_SORT_KEY = "cretDtm";

    /**
     * Sales 정렬 KEY 값
     */
    public static final String SALES_SORT_KEY = "saleUserSeqId";

    /**
     * Consult 정렬 KEY 값
     */
    public static final String CONSULT_SORT_KEY = "seqId";

    /**
     * Inquiry 정렬 KEY 값
     */
    public static final String INQUIRY_SORT_KEY = "seqId";

    /**
     * Terms 정렬 KEY 값
     */
    public static final String TERMS_SORT_KEY = "termsSeqId";
}
