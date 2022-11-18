package com.web.eaccounting.front.common.entity;


import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.ExpenseDto;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Getter
@Setter
@Table(name = "tb_expense", indexes = {
		@Index(name = "tb_expense_ind1", columnList="collNo,apprvNo,cardNo,useDate", unique = false)
	   ,@Index(name = "tb_expense_ind2", columnList="collNo,apprvNo", unique = false)
})
@DynamicUpdate
public class ExpenseEntity extends BaseEntity {

	@EmbeddedId
	private ExpensePK expensePK;

	@Column(length = 20)
	private String deptCode;

	@Column(length = 20)
	private String emplNo;

	@Column(length = 10)
	private String postingDate;

	@Column(length = 10)
	private String useDate;

	@Column(length = 10)
	private String useType;

	@Column(length = 1)
	private String expAdjType;

	@Column(length = 2)
	private String payGb;

	@Column(length = 100)
	private String acctCode;

	@Column(length = 10)
	private String budgetDepartment;

	private BigDecimal useAmt;
	private BigDecimal supplyAmt;
	private BigDecimal vatAmt;

	@Column(length = 200)
	private String dtlRsn;

	@Column(length = 16)
	private String cardNo;

	@Column(length = 20)
	private String apprvNo;

	@Column(length = 100)
	private String bizName;

	@Column(length = 12)
	private String bizNo;

	@Column(length = 100)
	private String bizStatus;

	@Column(length = 3)
	private String acctDtlCode;

	private BigDecimal svcAmt;

	@Column(length = 10)
	private String slipPostingDate;

	@Column(length = 10)
	private String useDateTime;

	@Column(length = 200)
	private String bizAddr;

	@Column(length = 100)
	private String startPlace;

	@Column(length = 100)
	private String destination;

	@Column(length = 100)
	private String transportation;

	@Column(length = 8)
	private String apprSeq;

	@Column(length = 8)
	private String bankCd;

	@Column(length = 32)
	private String collNo;

	@Override
	public ExpenseEntity of(AtomObject source) {
		return super.of(source, this.getClass());
	}

	@Override
	public void update(AtomObject source) {
		ExpenseDto expenseDto = (ExpenseDto)source;

		this.setDeptCode(expenseDto.getDeptCode());
		this.setEmplNo(expenseDto.getEmplNo());
		this.setPostingDate(expenseDto.getPostingDate());
		this.setUseDate(expenseDto.getUseDate());
		this.setUseType(expenseDto.getUseType());
		this.setExpAdjType(expenseDto.getExpAdjType());
		this.setAcctCode(expenseDto.getAcctCode());
		this.setBudgetDepartment(expenseDto.getBudgetDepartment());
		this.setUseAmt(expenseDto.getUseAmt());
		this.setSupplyAmt(expenseDto.getSupplyAmt());
		this.setVatAmt(expenseDto.getVatAmt());
		this.setDtlRsn(expenseDto.getDtlRsn());
		this.setCardNo(expenseDto.getCardNo());
		this.setApprvNo(expenseDto.getApprvNo());
		this.setBizName(expenseDto.getBizName());
		this.setBizNo(expenseDto.getBizNo());
		this.setBizStatus(expenseDto.getBizStatus());
		this.setAcctDtlCode(expenseDto.getAcctDtlCode());
		this.setSvcAmt(expenseDto.getSvcAmt());
		this.setSlipPostingDate(expenseDto.getSlipPostingDate());
		this.setUseDateTime(expenseDto.getUseDateTime());
		this.setBizAddr(expenseDto.getBizAddr());
		this.setDestination(expenseDto.getDestination());
		this.setTransportation(expenseDto.getTransportation());
		this.setApprSeq(expenseDto.getApprSeq());
		this.setBankCd(expenseDto.getBankCd());
		this.setCollNo(expenseDto.getCollNo());
	}
}
