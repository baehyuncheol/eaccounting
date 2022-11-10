package com.web.eaccounting.front.common.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDto {

    private String userID;
    private String userName;
    private String emplNo;
    private String jSessionId;
    private String authorId;

    //부서, 직책, 직급 정보
    private String deptCode;
    private String deptName;
    private String positionCode;
    private String positionName;
    private String titleCode;
    private String titleName;
    private String email;
}
