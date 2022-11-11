package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;

@Slf4j
@Getter
@Setter
@ToString
public class LoginDto extends AtomObject {

    private String userID;
    private String userName;
    private LocalDateTime lastLoginTime;
    private String emplNo;
    private String jSessionId;
    private String authorId;
    private LocalDateTime updateDatetime;

    @Override
    public LoginDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
