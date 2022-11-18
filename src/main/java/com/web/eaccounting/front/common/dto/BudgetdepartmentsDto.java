package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BudgetdepartmentsDto extends AtomObject {

    private String code;
    private String name;
    private String businessArea;
    private Integer sortSequence;
    public BudgetdepartmentsDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
