package com.web.eaccounting.front.settlement.service;


import com.web.eaccounting.core.entity.*;
import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.core.utils.DateUtil;
import com.web.eaccounting.core.utils.SessionUtil;
import com.web.eaccounting.core.utils.StringUtil;
import com.web.eaccounting.core.dto.AppcLineitemJDto;
import com.web.eaccounting.core.dto.CatsTmpAcquireDto;
import com.web.eaccounting.front.payDoc.repository.PayDocTbAppcRepository;
import com.web.eaccounting.front.settlement.mapper.SettlementMapper;
import com.web.eaccounting.front.settlement.repository.SettlementTbAppcHdJRepository;
import com.web.eaccounting.front.settlement.repository.SettlementTbAppcLineItemJRepository;
import com.web.eaccounting.front.settlement.repository.SettlementTbExpenseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class SettlementService{

    private final SettlementMapper settlementMapper;
    private final PayDocTbAppcRepository payDocTbAppcRepository;
    private final SettlementTbAppcHdJRepository settlementTbAppcHdJRepository;
    private final SettlementTbAppcLineItemJRepository settlementTbAppcLineItemJRepository;
    private final SettlementTbExpenseRepository settlementTbExpenseRepository;

    public List<CamelCaseMap> selectCardTransfers(Map<String, Object> param) {
        param.put("currentDate", DateUtil.getCurrentDate());

        return settlementMapper.selectCardTransfers(param);
    }

    public List<CamelCaseMap> selectAccounts(Map<String, Object> param) {
        param.put("currentDate", DateUtil.getCurrentDate());

        return settlementMapper.selectAccounts(param);
    }

    public List<CamelCaseMap> selectCardUseLists(Map<String, Object> param, HttpServletRequest req) {
        String loginId = SessionUtil.getLoginId(req);

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("emplNo", loginId);
        paramMap.put("cardNo", StringUtil.isEmpty(param.get("cardNo")) ? "" : param.get("cardNo").toString());
        paramMap.put("dateFrom", StringUtil.isEmpty(param.get("dateFrom")) ? "" : param.get("dateFrom").toString());
        paramMap.put("dateTo", StringUtil.isEmpty(param.get("dateTo")) ? "" : param.get("dateTo").toString());
        paramMap.put("status", StringUtil.isEmpty(param.get("status")) ? "" : param.get("status").toString());
        paramMap.put("paydocNo", StringUtil.isEmpty(param.get("paydocNo")) ? "" : param.get("paydocNo").toString());

        return settlementMapper.selectCardUseLists(paramMap);
    }

    public void updateTargetEmployee(List<CatsTmpAcquireDto> tbCatsTmpAcquireDtoList) {
        for(CatsTmpAcquireDto dto : tbCatsTmpAcquireDtoList){
            settlementMapper.updateTargetEmployee(dto);
        }
    }

    public void insertSettleCard(Map<String, Object> paramMap) {
        String paydocNo = paramMap.get("paydocNo").toString();
        String loginId = paramMap.get("loginId").toString();
        String flag = paramMap.get("flag").toString();

        deleteSettleCard(paydocNo);

        Map<String, Object> appc = (Map<String, Object>) paramMap.get("appc");
        List<Map<String, Object>> appcHd = (List<Map<String, Object>>) paramMap.get("appcHd");
        List<Map<String, Object>> expenseList = (List<Map<String, Object>>) paramMap.get("expense");

        BigDecimal totalAmt = appcHd.stream()
                .map(x -> new BigDecimal(x.get("requestamt").toString()))    // map
                .reduce(BigDecimal.ZERO, BigDecimal::add);      // reduce

        AppcEntity appcEntity = new AppcEntity();
        appcEntity.setPaydocNo(paydocNo);
        appcEntity.setTransPatternCode(appc.get("transPatternCode").toString());
        appcEntity.setDocType(appc.get("docType").toString());
        appcEntity.setApprvStatus("1A");
        appcEntity.setApprvTitle(appc.get("apprvTitle").toString());
        appcEntity.setEmplNo(appc.get("emplNo").toString());
        appcEntity.setDeptCode(appc.get("deptCode").toString());
        appcEntity.setDeptName(appc.get("deptName").toString());
        appcEntity.setPositionName(appc.get("positionName").toString());
        appcEntity.setTotalAmt(totalAmt);
        appcEntity.setPaydocCreateDate(LocalDateTime.now());
        appcEntity.setInsertId(loginId);
        appcEntity.setInsertDate(LocalDateTime.now());
        appcEntity.setUpdateId(loginId);
        appcEntity.setUpdateDate(LocalDateTime.now());

        if("S".equals(flag)) {
            appcEntity.setApprvReqTime(LocalDateTime.now());
        }

        payDocTbAppcRepository.save(appcEntity);

        int a = 1;
        for(Map<String, Object> map : appcHd) {
            String paydocSeq = map.get("paydocSeq").toString();

            AppcHdJPK appcHdJPK = new AppcHdJPK();
            appcHdJPK.setPaydocNo(paydocNo);
            appcHdJPK.setPaydocSeq(paydocSeq);
            AppcHdJEntity appcHdJEntity = new AppcHdJEntity();
            appcHdJEntity.setAppcHdJPK(appcHdJPK);
            appcHdJEntity.setAcctCode(map.get("acctCode").toString());
            appcHdJEntity.setTotalBudgetAmt(new BigDecimal(map.get("totalamount")==null? "0" : map.get("totalamount").toString()));
            appcHdJEntity.setApprovalUsedAmt(new BigDecimal(map.get("usedamount")==null? "0" : map.get("usedamount").toString()));
            appcHdJEntity.setApprovalProgressAmt(new BigDecimal(map.get("noapprovedamount")==null? "0" : map.get("noapprovedamount").toString())); //TODO - SAP 인터페이스 결재진행금액 추가시 수정
            appcHdJEntity.setApprovalRequestAmt(new BigDecimal(map.get("requestamt")==null? "0" : map.get("requestamt").toString()));
            appcHdJEntity.setBudgetBalance(new BigDecimal(map.get("balance")==null? "0" : map.get("balance").toString()));
            appcHdJEntity.setBudgetCode(map.get("budgetCode").toString());
            appcHdJEntity.setSlipPostingDate(StringUtil.getDeleteChar(appc.get("slipPostingDate").toString(), "-"));
            appcHdJEntity.setInsertId(loginId);
            appcHdJEntity.setInsertDate(LocalDateTime.now());
            appcHdJEntity.setUpdateId(loginId);
            appcHdJEntity.setUpdateDate(LocalDateTime.now());

            settlementTbAppcHdJRepository.save(appcHdJEntity);

            AppcLineitemJPK appcLineitemJPKH = new AppcLineitemJPK();
            appcLineitemJPKH.setPaydocNo(paydocNo);
            appcLineitemJPKH.setPaydocSeq(paydocSeq);
            appcLineitemJPKH.setSlipItemNo("001");

            AppcLineitemJEntity appcLineitemJEntityH = new AppcLineitemJEntity();
            appcLineitemJEntityH.setAppcLineitemJPK(appcLineitemJPKH);
            appcLineitemJEntityH.setDrCrInd("H"); //대
            appcLineitemJEntityH.setBudgetCode(map.get("budgetCode").toString());
            //appcLineitemJEntityH.setAcctCode(map.get("acctCode").toString());
            appcLineitemJEntityH.setAcctCode("2121120"); //미지급금:법인개별카드(2121120)
            appcLineitemJEntityH.setSlipCurrencyAmt(new BigDecimal(map.get("requestamt")==null? "0" : map.get("requestamt").toString()));
            appcLineitemJEntityH.setSlipCurrencyTax(new BigDecimal(map.get("vat1")==null? "0" : map.get("vat1").toString()));
            appcLineitemJEntityH.setInsertId(loginId);
            appcLineitemJEntityH.setInsertDate(LocalDateTime.now());
            appcLineitemJEntityH.setUpdateId(loginId);
            appcLineitemJEntityH.setUpdateDate(LocalDateTime.now());

            settlementTbAppcLineItemJRepository.save(appcLineitemJEntityH);

            AppcLineitemJPK appcLineitemJPKS = new AppcLineitemJPK();
            appcLineitemJPKS.setPaydocNo(paydocNo);
            appcLineitemJPKS.setPaydocSeq(paydocSeq);
            appcLineitemJPKS.setSlipItemNo("002");

            AppcLineitemJEntity appcLineitemJEntityS = new AppcLineitemJEntity();
            appcLineitemJEntityS.setAppcLineitemJPK(appcLineitemJPKS);
            appcLineitemJEntityS.setDrCrInd("S"); //차
            appcLineitemJEntityS.setBudgetCode(map.get("budgetCode").toString());
            appcLineitemJEntityS.setAcctCode(map.get("acctCode").toString());
            appcLineitemJEntityS.setSlipCurrencyAmt(new BigDecimal(map.get("requestamt")==null? "0" : map.get("requestamt").toString()));
            appcLineitemJEntityS.setSlipCurrencyTax(new BigDecimal(map.get("vat1")==null? "0" : map.get("vat1").toString()));
            appcLineitemJEntityS.setInsertId(loginId);
            appcLineitemJEntityS.setInsertDate(LocalDateTime.now());
            appcLineitemJEntityS.setUpdateId(loginId);
            appcLineitemJEntityS.setUpdateDate(LocalDateTime.now());

            settlementTbAppcLineItemJRepository.save(appcLineitemJEntityS);

            a++;
        }

        int b = 1;
        for(Map<String, Object> map : expenseList) {
            String paydocSeq = map.get("paydocSeq").toString();

            ExpensePK expensePK = new ExpensePK();
            expensePK.setPaydocNo(paydocNo);
            expensePK.setPaydocSeq(paydocSeq);
            expensePK.setSubSeqNo(b);

            ExpenseEntity expenseEntity = new ExpenseEntity();
            expenseEntity.setExpensePK(expensePK);
            expenseEntity.setDeptCode(appc.get("deptCode").toString());
            expenseEntity.setEmplNo(appc.get("emplNo").toString());
            expenseEntity.setPostingDate(StringUtil.getDeleteChar(appc.get("slipPostingDate").toString(), "-"));
            expenseEntity.setUseDate(StringUtil.getDeleteChar(map.get("apprDate").toString(), "-"));
            expenseEntity.setUseType(map.get("useType").toString());
            expenseEntity.setExpAdjType(appc.get("expAdjType").toString());
            expenseEntity.setAcctCode(map.get("acctCode").toString());
            expenseEntity.setBudgetDepartment(map.get("budgetCode").toString());
            expenseEntity.setUseAmt(new BigDecimal(map.get("purchTot").toString()));
            expenseEntity.setSupplyAmt(new BigDecimal(map.get("apprAmt1").toString()));
            expenseEntity.setVatAmt(new BigDecimal(map.get("vat1").toString()));
            expenseEntity.setDtlRsn(map.get("dtlRsn").toString());
            expenseEntity.setCardNo(map.get("cardNo").toString());
            expenseEntity.setApprvNo(map.get("apprNo").toString());
            expenseEntity.setBizName(map.get("merchName").toString());
            expenseEntity.setBizNo(map.get("merchBizNo").toString());
            expenseEntity.setBizStatus(map.get("mccName").toString());
            //expenseEntity.setAcctDtlCode();
            expenseEntity.setSvcAmt(new BigDecimal(map.get("tips").toString()));
            expenseEntity.setSlipPostingDate(StringUtil.getDeleteChar(appc.get("slipPostingDate").toString(), "-"));
            expenseEntity.setUseDateTime(map.get("purchTime").toString());
            expenseEntity.setBizAddr(map.get("merchAddr1").toString());
            //expenseEntity.setDestination();
            //expenseEntity.setTransportation();
            //expenseEntity.setApprSeq();
            expenseEntity.setBankCd(map.get("trAcq").toString());
            expenseEntity.setCollNo(map.get("collNo").toString());
            expenseEntity.setInsertId(loginId);
            expenseEntity.setInsertDate(LocalDateTime.now());
            expenseEntity.setUpdateId(loginId);
            expenseEntity.setUpdateDate(LocalDateTime.now());

            settlementTbExpenseRepository.save(expenseEntity);

            //카드매입테이블 상태 결재진행중(2)으로 업데이트
            map.put("status", "2");
            settlementMapper.updateCardStatus(map);

            b++;
        }
    }

    public List<CamelCaseMap> getAppcHdJList(String paydocNo) {

        return settlementMapper.getAppcHdJList(paydocNo);
    }

    public List<AppcLineitemJDto> getAppcLineitemJList(String paydocNo) {

        return settlementMapper.getAppcLineitemJList(paydocNo);
    }

    public List<CamelCaseMap> getExpenseList(String paydocNo) {

        return settlementMapper.getExpenseList(paydocNo);
    }

    public void deleteSettleCard(String paydocNo) {

        //카드매입테이블 상태 미정산(1)으로 업데이트
        List<ExpenseEntity> tbExpenseEntityList = settlementTbExpenseRepository.findByExpensePKPaydocNo(paydocNo);
        for(ExpenseEntity entity : tbExpenseEntityList) {
            Map<String, Object> map = new HashMap<>();
            map.put("cardNo", entity.getCardNo());
            map.put("apprDate", entity.getUseDate());
            map.put("apprNo", entity.getApprvNo());
            map.put("collNo", entity.getCollNo());
            map.put("status", "1");
            settlementMapper.updateCardStatus(map);
        }

        settlementTbAppcHdJRepository.deleteByAppcHdJPKPaydocNo(paydocNo);
        settlementTbAppcLineItemJRepository.deleteByAppcLineitemJPKPaydocNo(paydocNo);
        settlementTbExpenseRepository.deleteByExpensePKPaydocNo(paydocNo);
    }

    public List<BudgetdepartmentsEntity> selectBudgetdept() {

        return settlementMapper.selectBudgetdept();
    }

    public int cardStatusCheck(String paydocNo) {
        //카드매입테이블 상태 체크
        List<ExpenseEntity> tbExpenseEntityList = settlementTbExpenseRepository.findByExpensePKPaydocNo(paydocNo);
        int count = 0;
        for(ExpenseEntity entity : tbExpenseEntityList) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("cardNo", entity.getCardNo());
            paramMap.put("apprNo", entity.getApprvNo());

            List<CamelCaseMap> list = settlementMapper.getCollNo(paramMap);

            Map<String, Object> map = new HashMap<>();
            map.put("cardNo", entity.getCardNo());
            map.put("apprDate", entity.getUseDate());
            map.put("apprNo", entity.getApprvNo());
            map.put("collNo", list.get(0).get("collNo").toString());
            count += settlementMapper.cardStatusCheck(map);
        }
        return count;
    }

    public void updateIH(String paydocNo, HttpServletRequest req) {
        String loginId = SessionUtil.getLoginId(req);

        Map<String, Object> appcMap = new HashMap<>();
        appcMap.put("paydocNo", paydocNo);
        //appcMap.put("apprvStatus", "II");
        appcMap.put("apprvStatus", "1X");
        appcMap.put("updateUser", loginId);

        settlementMapper.updateTbAppcStatus(appcMap);
        settlementMapper.updateExpenseData(appcMap);
    }

    public List<CamelCaseMap> getCollNo(Map<String, Object> param) {

        return settlementMapper.getCollNo(param);
    }
}
