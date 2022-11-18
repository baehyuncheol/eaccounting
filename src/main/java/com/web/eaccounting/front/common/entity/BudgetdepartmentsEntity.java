package com.web.eaccounting.front.common.entity;


import com.web.eaccounting.front.common.AtomObject;
import com.web.eaccounting.front.common.dto.BudgetdepartmentsDto;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@Table(name = "tb_budgetdepartments")
public class BudgetdepartmentsEntity extends BaseEntity{
    @Id
    @Column(length = 4)
    private String code;

    @Column(length = 200)
    private String name;

    @Column(length = 4)
    private String businessArea;

    @Column(length = 10)
    private Integer sortSequence;

    @Override
    public BudgetdepartmentsEntity of(AtomObject source) {
        return super.of(source, this.getClass());
    }

    @Override
    public void update(AtomObject source) {
        BudgetdepartmentsDto budgetdepartmentsDto = (BudgetdepartmentsDto) source;
        this.setName(budgetdepartmentsDto.getName());
        this.setBusinessArea(budgetdepartmentsDto.getBusinessArea());
        this.setSortSequence(budgetdepartmentsDto.getSortSequence());
    }

}
