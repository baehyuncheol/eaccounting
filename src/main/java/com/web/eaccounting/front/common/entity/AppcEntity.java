package com.web.eaccounting.front.common.entity;

import com.sun.istack.NotNull;
import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.AppcDto;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "tb_appc", indexes = {
        @Index(name = "tb_appc_ind1", columnList="ebill", unique = false)
        ,  @Index(name = "tb_appc_ind2", columnList="emplNo,transPatternCode,apprvTitle,paydocCreateDate", unique = false)
        ,  @Index(name = "tb_appc_ind3", columnList="emplNo,transPatternCode,purchaseName,paydocCreateDate", unique = false)

})
@DynamicUpdate
public class AppcEntity extends BaseEntity{
    @Id
    @Column(length = 15)
    private String paydocNo;

    @NotNull
    @Column(length = 8)
    private String transPatternCode;

    @Column(length = 3)
    private String docType;

    @Column(length = 1)
    private String apprvStepApplyMethod;

    @Column(length = 3)
    private String apprvStatus;

    @Column(length = 100)
    private String apprvTitle;

    @Column(length = 255)
    private String apprvReqOpn;

    @Column(length = 7)
    private String emplNo;

    @Column(length = 20)
    private String deptCode;

    @Column(length = 50)
    private String positionName;

    @Column(length = 60)
    private String deptName;

    @Column(length = 200)
    private String email;

    @Column(length = 4)
    private String coCode;

    @Column(length = 4)
    private String acctYear;

    private LocalDateTime paydocCreateDate;
    private LocalDateTime apprvReqTime;
    private LocalDateTime apprvCompleteTime;

    @Column(length=8000)
    private String apprvMessage;

    @Column(length = 1000)
    private String apprvFlowResult;

    @Column(length = 50)
    private String ebill;

    @Column(length = 7)
    private String apprvStepCode;

    @Column(length = 30)
    private String purchaseCode;

    @Column(length = 40)
    private String purchaseName;

    private BigDecimal totalAmt;

    @Column(length = 11)
    private String paydocNoRefund;

    @Column(length = 4)
    private String transCurrency;
    @Column(length = 4)
    private String office;

    @Column(length = 20)
    private String addtionalStepCode;

    @Column(length = 11)
    private String paydocNoMinus;

    @Column(length = 8)
    private String sendDateEmail;

    @Column(length = 32)
    private String insertId;

    private LocalDateTime insertDate;

    private int lastAppSetSeq;

    @Column(length = 8)
    private String adjSdate;

    @Column(length = 8)
    private String adjEdate;

    @Column(length = 10)
    private String contSeq;

    @Column(length = 20)
    private String contNo;

    @Column(length = 500)
    private String contName;

    @Column(length = 8)
    private String contDt;

    private BigDecimal contAmt;

    @Column(length = 32)
    private String objAcctNo;

    @Column(length = 1)
    private String slipStatus;

    @Column(length = 20)
    private String epDocid;

    @Override
    public AppcEntity of(AtomObject source) {
        return super.of(source, this.getClass());
    }

    @Override
    public void update(AtomObject source) {
        AppcDto appcDto = (AppcDto)source;
        this.setTransPatternCode(appcDto.getTransPatternCode());
        this.setDocType(appcDto.getDocType());
        this.setApprvStepApplyMethod(appcDto.getApprvStepApplyMethod());
        this.setApprvStatus(appcDto.getApprvStatus());
        this.setApprvTitle(appcDto.getApprvTitle());
        this.setApprvReqOpn(appcDto.getApprvReqOpn());
        this.setEmplNo(appcDto.getEmplNo());
        this.setDeptCode(appcDto.getDeptCode());
        this.setPositionName(appcDto.getPositionName());
        this.setDeptName(appcDto.getDeptName());
        this.setEmail(appcDto.getEmail());
        this.setCoCode(appcDto.getCoCode());
        this.setAcctYear(appcDto.getAcctYear());
        this.setPaydocCreateDate(appcDto.getPaydocCreateDate());
        this.setApprvReqTime(appcDto.getApprvReqTime());
        this.setApprvCompleteTime(appcDto.getApprvCompleteTime());
        this.setApprvFlowResult(appcDto.getApprvFlowResult());
        this.setApprvStepCode(appcDto.getApprvStepCode());
        this.setPurchaseCode(appcDto.getPurchaseCode());
        this.setPurchaseName(appcDto.getPurchaseName());
        this.setTotalAmt(appcDto.getTotalAmt());
        this.setPaydocNoRefund(appcDto.getPaydocNoRefund());
        this.setTransCurrency(appcDto.getTransCurrency());
        this.setOffice(appcDto.getOffice());
        this.setAddtionalStepCode(appcDto.getAddtionalStepCode());
        this.setPaydocNoMinus(appcDto.getPaydocNoMinus());
        this.setSendDateEmail(appcDto.getSendDateEmail());
        this.setLastAppSetSeq(appcDto.getLastAppSetSeq());
        this.setAdjSdate(appcDto.getAdjSdate());;
        this.setAdjEdate(appcDto.getAdjEdate());
        this.setContSeq(appcDto.getContSeq());
        this.setContNo(appcDto.getContNo());
        this.setContName(appcDto.getContName());
        this.setContDt(appcDto.getContDt());
        this.setObjAcctNo(appcDto.getObjAcctNo());
        this.setEpDocid(appcDto.getEpDocid());
    }
}
