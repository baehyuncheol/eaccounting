package com.web.eaccounting.core.dto;

import com.web.eaccounting.core.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class AppcHdJDto extends AtomObject {

    private String paydocNo;
    private String paydocSeq;
    private String budgetCode;
    private String acctCode;
    private BigDecimal totalBudgetAmt;
    private BigDecimal approvalUsedAmt;
    private BigDecimal approvalProgressAmt;
    private BigDecimal budgetBalance;
    private BigDecimal approvalRequestAmt;
    private String slipHeader;
    private String slipPostingDate;

    private String acctName;
    private String budgetCodeName;

    @Override
    public AppcHdJDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
