package com.web.eaccounting.front.common.entity;



import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@Setter
@MappedSuperclass
public abstract class BaseEntity extends AtomObject {
    @Column(updatable = false, length = 10)
    private String createUser;

    @Column(updatable = false)
    private LocalDateTime createDatetime;

    @Column(length = 10)
    private String updateUser;

    private LocalDateTime updateDatetime;

    public abstract void update(AtomObject paramAtomObject);


}
