package com.web.eaccounting.front.payDoc.repository;

import com.web.eaccounting.core.entity.AppcEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface PayDocTbAppcRepository extends JpaRepository<AppcEntity, String> {
    public AppcEntity findByPaydocNo(String paydocNo);
    public AppcEntity findByPaydocNoAndEmplNo(String paydocNo, String emplNo);
}