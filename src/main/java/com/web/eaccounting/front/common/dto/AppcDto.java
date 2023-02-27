package com.web.eaccounting.front.common.dto;

import com.web.eaccounting.front.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Setter
@Getter
public class AppcDto extends AtomObject {
    private String paydocNo;
    private String transPatternCode;
    private String docType;
    private String apprvStepApplyMethod;
    private String apprvStatus;
    private String apprvTitle;
    private String apprvReqOpn;
    private String emplNo;
    private String deptCode;
    private String positionName;
    private String deptName;
    private String email;
    private String coCode;
    private String acctYear;
    private LocalDateTime paydocCreateDate;
    private LocalDateTime apprvReqTime;
    private LocalDateTime apprvCompleteTime;
    private String apprvFlowResult;
    private String ebill;
    private String apprvStepCode;
    private String purchaseCode;
    private String purchaseName;
    private BigDecimal totalAmt;
    private String paydocNoRefund;
    private String transCurrency;
    private String office;
    private String addtionalStepCode;
    private String paydocNoMinus;
    private String sendDateEmail;
    private String insertId;
    private LocalDateTime insertDate;
    private int lastAppSetSeq;
    private String adjSdate;
    private String adjEdate;
    private String contSeq;
    private String contNo;
    private String contName;
    private String contDt;
    private BigDecimal contAmt;
    private String slipStatus;
    private String objAcctNo;
    private String epDocid;

    @Override
    public AppcDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
