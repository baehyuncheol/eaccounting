package com.web.eaccounting.front.paydoc.repository;

import com.web.eaccounting.front.common.entity.CodeEntity;
import com.web.eaccounting.front.common.entity.CodePK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PayDocTbCodeRepository extends JpaRepository<CodeEntity, CodePK> {
    public List<CodeEntity> findByCodePk_CodeKind_AndUsageInd(String codeKind, String usageInd);
}
