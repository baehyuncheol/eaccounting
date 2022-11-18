package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class AppcLineitemJDto extends AtomObject {

    private String paydocNo;
    private String paydocSeq;
    private String slipItemNo;
    private String drCrInd;
    private String budgetCode;
    private String acctCode;
    private BigDecimal slipCurrencyAmt;
    private BigDecimal localCurrencyAmt;
    private BigDecimal slipCurrencyTax;
    private String purchaseCode;
    private String paymethod;
    private String slipText;

    private String acctName;
    private String budgetCodeName;

    @Override
    public AppcLineitemJDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
