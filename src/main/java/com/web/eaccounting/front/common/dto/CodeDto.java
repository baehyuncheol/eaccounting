package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Setter
@Getter
public class CodeDto extends AtomObject {

    private String codeKind;
    private String code;
    private String codeName;
    private String description;
    private int sortSeq;
    private String usageInd;
    private String filler1;
    private String filler2;
    private String filler3;
    private String filler4;
    private String insertId;
    private LocalDateTime insertDate;
    private String updateId;
    private LocalDateTime updateDate;

    private List<CodeDto> CodeDtoList;

    @Override
    public CodeDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
