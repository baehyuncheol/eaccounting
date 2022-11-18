package com.web.eaccounting.front.settlement.web;


import com.web.eaccounting.front.settlement.service.SettlementService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/settlement")
public class SettlementController {

    private final SettlementService settlementService;

    //private final PayDocService payDocService;

    //private final SapService sapService;
}
