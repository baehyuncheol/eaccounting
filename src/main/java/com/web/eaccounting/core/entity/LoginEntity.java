package com.web.eaccounting.core.entity;


import com.web.eaccounting.core.common.AtomObject;
import com.web.eaccounting.core.dto.LoginDto;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@DynamicUpdate
public class LoginEntity extends BaseEntity{

    @Id
    @Column(length = 10)
    private String userID;

    /*@Column(length = 256)
    private String emplPwd;*/

    @Column(length = 10)
    private String userName;
    @Column(length = 10)
    private String emplNo;
    @Column(length = 10)
    private String jSessionId;
    @Column(length = 10)
    private String authorId;


    @CreationTimestamp
    private LocalDateTime lastLoginTime;

    @Override
    public LoginEntity of(AtomObject source) {
        return super.of(source, this.getClass());
    }

    @Override
    public void update(AtomObject source) {
        LoginDto td = (LoginDto)source;
        //this.setEmplPwd(td.getEmplPwd());
        this.setLastLoginTime(LocalDateTime.now());
    }
}
