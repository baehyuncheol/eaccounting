package com.web.eaccounting.front.common.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Data
@Embeddable
public class AppcLineitemJPK implements Serializable {

    @Column(length = 15)
    private String paydocNo;

    @Column(length = 3)
    private String paydocSeq;

    @Column(length = 3)
    private String slipItemNo;
}

