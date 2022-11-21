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
    @Column(updatable = false, length = 32)
    private String insertId;

    @Column(updatable = false)
    private LocalDateTime insertDate;

    @Column(length = 32)
    private String updateId;

    private LocalDateTime updateDate;

    public abstract void update(AtomObject paramAtomObject);


}
