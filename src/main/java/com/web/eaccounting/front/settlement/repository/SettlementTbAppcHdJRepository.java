package com.web.eaccounting.front.settlement.repository;

import com.web.eaccounting.front.common.entity.AppcHdJEntity;
import com.web.eaccounting.front.common.entity.AppcHdJPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SettlementTbAppcHdJRepository extends JpaRepository<AppcHdJEntity, AppcHdJPK> {
    void deleteByAppcHdJPKPaydocNo(String paydocNo);
}
