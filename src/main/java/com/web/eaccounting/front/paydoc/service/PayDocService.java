package com.web.eaccounting.front.paydoc.service;

import com.web.eaccounting.core.entity.CodeEntity;
import com.web.eaccounting.front.paydoc.repository.PayDocTbAppcRepository;
import com.web.eaccounting.front.paydoc.repository.PayDocTbCodeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional
public class PayDocService {

    private final PayDocTbAppcRepository payDocTbAppcRepository;
    private final PayDocTbCodeRepository payDocTbCodeRepository;

    @Autowired
    public PayDocService(PayDocTbAppcRepository payDocTbAppcRepository, PayDocTbCodeRepository payDocTbCodeRepository) {
        this.payDocTbAppcRepository = payDocTbAppcRepository;
        this.payDocTbCodeRepository = payDocTbCodeRepository;
    }

    //공통코드 가져오기..
    public List<CodeEntity> getCommonCode(String codeKind)  {
        return payDocTbCodeRepository.findByCodePk_CodeKind_AndUsageInd(codeKind,"Y");
    }

}
