package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class ExpenseDto extends AtomObject {

    private String paydocNo;
    private String paydocSeq;
    private String deptCode;
    private String emplNo;
    private String postingDate;
    private String useDate;
    private String useType;
    private String expAdjType;
    private String acctCode;
    private String budgetDepartment;
    private BigDecimal useAmt;
    private BigDecimal supplyAmt;
    private BigDecimal vatAmt;
    private String dtlRsn;
    private String cardNo;
    private String apprvNo;
    private String bizName;
    private String bizNo;
    private String bizStatus;
    private String acctDtlCode;
    private BigDecimal svcAmt;
    private String slipPostingDate;
    private String useDateTime;
    private String bizAddr;
    private String startPlace;
    private String destination;
    private String transportation;
    private String apprSeq;
    private String bankCd;
    private String collNo;

    private String acctName;
    private String budgetCode;
    private String budgetCodeName;

    @Override
    public ExpenseDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
