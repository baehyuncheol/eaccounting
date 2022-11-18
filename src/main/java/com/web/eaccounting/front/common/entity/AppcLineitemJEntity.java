package com.web.eaccounting.front.common.entity;


import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.AppcLineitemJDto;
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
@Table(name = "tb_appc_lineitem_j")
@DynamicUpdate
public class AppcLineitemJEntity extends BaseEntity {

	@EmbeddedId
	private AppcLineitemJPK appcLineitemJPK;

	@Column(length = 1)
	private String drCrInd;

	@Column(length = 4)
	private String budgetCode;

	@Column(length = 100)
	private String acctCode;

	private BigDecimal slipCurrencyAmt;

	private BigDecimal localCurrencyAmt;

	private BigDecimal slipCurrencyTax;

	@Column(length = 100)
	private String purchaseCode;

	@Column(length = 1)
	private String paymethod;

	@Column(length = 100)
	private String slipText;

	@Override
	public AppcLineitemJEntity of(AtomObject source) {
		return super.of(source, this.getClass());
	}

	@Override
	public void update(AtomObject source) {
		AppcLineitemJDto appcLineitemJDto= (AppcLineitemJDto)source;
		this.setDrCrInd(appcLineitemJDto.getDrCrInd());
		this.setBudgetCode(appcLineitemJDto.getBudgetCode());
		this.setAcctCode(appcLineitemJDto.getAcctCode());
		this.setSlipCurrencyAmt(appcLineitemJDto.getSlipCurrencyAmt());
		this.setSlipCurrencyTax(appcLineitemJDto.getSlipCurrencyTax());
		this.setLocalCurrencyAmt(appcLineitemJDto.getLocalCurrencyAmt());
		this.setPurchaseCode(appcLineitemJDto.getPurchaseCode());
		this.setPaymethod(appcLineitemJDto.getPaymethod());
		this.setSlipText(appcLineitemJDto.getSlipText());
	}
}
