package com.web.eaccounting.front.common.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Data
@Embeddable
public class CodePK implements Serializable {
    @Column(length = 4)
    private String codeKind;

    @Column(length = 20)
    private String code;

}
