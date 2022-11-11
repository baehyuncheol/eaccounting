package com.web.eaccounting.front.common.entity;


import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.LoginDto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
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
