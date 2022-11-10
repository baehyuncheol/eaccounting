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
}
