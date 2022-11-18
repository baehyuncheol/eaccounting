package com.web.eaccounting.front.common.entity;


import com.sun.istack.NotNull;
import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.CodeDto;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Getter
@Setter
@Table(name = "tb_code")
@DynamicUpdate
public class CodeEntity extends BaseEntity implements Serializable {

    @EmbeddedId
    private CodePK codePk;

    @NotNull
    @Column(length = 120)
    private String codeName;
    @Column(length = 255)
    private String description;
    private Integer sortSeq;
    @Column(length = 1)
    private String usageInd;
    @Column(length = 50)
    private String filler1;
    @Column(length = 50)
    private String filler2;
    @Column(length = 50)
    private String filler3;
    @Column(length = 50)
    private String filler4;

    @Override
    public CodeEntity of(AtomObject source) {
        return super.of(source, this.getClass());
    }

    @Override
    public void update(AtomObject source) {
        CodeDto codeDto = (CodeDto) source;
        this.setCodeName(codeDto.getCodeName());
        this.setDescription(codeDto.getDescription());
        this.setSortSeq(codeDto.getSortSeq());
        this.setUsageInd(codeDto.getUsageInd());
        this.setFiller1(codeDto.getFiller1());
        this.setFiller2(codeDto.getFiller2());
        this.setFiller3(codeDto.getFiller3());
        this.setFiller4(codeDto.getFiller4());
    }
}