package com.web.eaccounting.front.paydoc.service;

import com.web.eaccounting.front.paydoc.repository.PayDocTbAppcRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
public class PayDocService {

    private final PayDocTbAppcRepository payDocTbAppcRepository;


    @Autowired
    public PayDocService(PayDocTbAppcRepository payDocTbAppcRepository) {
        this.payDocTbAppcRepository = payDocTbAppcRepository;
    }
}
