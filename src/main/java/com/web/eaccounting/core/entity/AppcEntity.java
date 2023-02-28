package com.web.eaccounting.core.entity;

import com.sun.istack.NotNull;
import com.web.eaccounting.core.common.AtomObject;
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
public class AppcEntity extends BaseEntity {
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

    @Column(length = 8000)
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

    @Override
    public <D> AtomObject of(AtomObject paramAtomObject) {
        return null;
    }

    @Override
    public void update(AtomObject paramAtomObject) {

    }
}