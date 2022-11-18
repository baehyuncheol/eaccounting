package com.web.eaccounting.front.settlement.repository;



import com.web.eaccounting.front.common.entity.ExpenseEntity;
import com.web.eaccounting.front.common.entity.ExpensePK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SettlementTbExpenseRepository extends JpaRepository<ExpenseEntity, ExpensePK> {
    void deleteByExpensePKPaydocNo(String paydocNo);

    List<ExpenseEntity> findByExpensePKPaydocNo(String paydocNo);
}
