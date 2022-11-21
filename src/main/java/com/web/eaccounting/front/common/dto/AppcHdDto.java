package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class AppcHdDto extends AtomObject {
    private String paydocNo;
    private String slip12Code;
    private String coCode11;
    private String slipPattern;
    private String evdDate;
    private String slipNo1;
    private String acctYear;
    private String rcvAcctYear;
    private String slipPostingDate;
    private String acctTerm;
    private String slipHeader;
    private String transCurrency;
    private BigDecimal exchangeRate;
    private String exchangeDate;
    private String poNo;
    private String mmdocNo;
    private String mmdocYear;
    private BigDecimal serialNo;
    private String revSlipNo;




    @Override
    public AppcHdDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }

}
