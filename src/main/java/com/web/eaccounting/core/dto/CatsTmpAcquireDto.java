package com.web.eaccounting.core.dto;

import com.web.eaccounting.core.common.AtomObject;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;

@Slf4j
@Getter
@Setter
@ToString
public class CatsTmpAcquireDto extends AtomObject {
    private Long seq;
    private String dataCode;
    private String companyId;
    private String sendDate;
    private String seqNo;
    private String readFlag;
    private String classGubun;
    private String cardNo;
    private String apprNo;
    private String collNo;
    private String orginCollNo;
    private String slipNo;
    private String apprDate;
    private String purchDate;
    private String purchTime;
    private String currCode;
    private BigDecimal apprTot;
    private BigDecimal acquTot;
    private BigDecimal acquExch;
    private BigDecimal usdAcquTot;
    private BigDecimal convFee;
    private BigDecimal purchTot;
    private String instType;
    private String settDate;
    private String abroad;
    private String purchYn;
    private String merchBizNo;
    private String merchNo;
    private String merchName;
    private String master;
    private String merchTel;
    private String merchZipcode;
    private String merchAddr1;
    private String merchAddr2;
    private String mccName;
    private String mccCode;
    private String partAcquCancYn;
    private String noneApprYn;
    private String servTypeYn;
    private BigDecimal discAmt;
    private BigDecimal currAcquTot;
    private BigDecimal acquFee;
    private BigDecimal apprAmt;
    private BigDecimal vat;
    private BigDecimal tips;
    private String originMerchName;
    private String originMerchBizNo;
    private String bcmccName;
    private String bcmccCode;
    private String membCode;
    private String taxType;
    private String merchCessDate;
    private String taxTypeDate;
    private BigDecimal apprAmt1;
    private BigDecimal vat1;
    private String vatYn;
    private String workDate;
    private String errYn;
    private String trAcq;
    private String fileYn;
    private String erpYn;
    private BigDecimal tips1;
    private String status;
    private String targetEmployee;
    private String statementNo;
    private String docId;
    private String cardCheckGb;
    private String chkCanIpgumdt;
    private BigDecimal bilAmt;
    private BigDecimal savePointAmt;
    private String trDate;
    private String cityEng;
    private String nationEng;

    @Override
    public CatsTmpAcquireDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }
}
