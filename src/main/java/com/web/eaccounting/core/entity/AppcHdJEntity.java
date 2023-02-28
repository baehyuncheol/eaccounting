package com.web.eaccounting.core.entity;


import com.web.eaccounting.core.dto.AppcHdJDto;
import com.web.eaccounting.core.common.AtomObject;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Getter
@Setter
@Table(name = "tb_appc_hd_j")
@DynamicUpdate
public class AppcHdJEntity extends BaseEntity {

	@EmbeddedId
	private AppcHdJPK appcHdJPK;

	@Column(length = 4)
	private String budgetCode;

	@Column(length = 100)
	private String acctCode;

	private BigDecimal totalBudgetAmt;

	private BigDecimal approvalUsedAmt;

	private BigDecimal approvalProgressAmt;

	private BigDecimal budgetBalance;

	private BigDecimal approvalRequestAmt;

	@Column(length = 100)
	private String slipHeader;

	@Column(length = 8)
	private String slipPostingDate;

	@Override
	public AppcHdJEntity of(AtomObject source) {
		return super.of(source, this.getClass());
	}

	@Override
	public void update(AtomObject source) {
		AppcHdJDto appcHdJDto = (AppcHdJDto)source;
		this.setAcctCode(appcHdJDto.getAcctCode());
		this.setBudgetCode(appcHdJDto.getBudgetCode());
		this.setTotalBudgetAmt(appcHdJDto.getTotalBudgetAmt());
		this.setApprovalUsedAmt(appcHdJDto.getApprovalUsedAmt());
		this.setApprovalProgressAmt(appcHdJDto.getApprovalProgressAmt());
		this.setBudgetBalance(appcHdJDto.getBudgetBalance());
		this.setApprovalRequestAmt(appcHdJDto.getApprovalRequestAmt());
		this.setSlipHeader(appcHdJDto.getSlipHeader());
		this.setSlipPostingDate(appcHdJDto.getSlipPostingDate());
	}
}
