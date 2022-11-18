package com.web.eaccounting.front.settlement.repository;


import com.web.eaccounting.front.common.entity.AppcLineitemJEntity;
import com.web.eaccounting.front.common.entity.AppcLineitemJPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SettlementTbAppcLineItemJRepository extends JpaRepository<AppcLineitemJEntity, AppcLineitemJPK> {

    void deleteByAppcLineitemJPKPaydocNo(String paydocNo);
}
