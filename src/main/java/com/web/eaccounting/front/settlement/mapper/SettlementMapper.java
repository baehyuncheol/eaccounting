package com.web.eaccounting.front.settlement.mapper;


import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.core.dto.AppcLineitemJDto;
import com.web.eaccounting.core.dto.CatsTmpAcquireDto;
import com.web.eaccounting.core.entity.BudgetdepartmentsEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SettlementMapper {

    List<CamelCaseMap> selectCardTransfers(Map<String, Object> param);

    List<CamelCaseMap> selectAccounts(Map<String, Object> param);

    List<CamelCaseMap> selectCardUseLists(Map<String, Object> paramMap);

    void updateTargetEmployee(CatsTmpAcquireDto dto);

    List<CamelCaseMap> getAppcHdJList(String paydocNo);

    List<AppcLineitemJDto> getAppcLineitemJList(String paydocNo);

    List<CamelCaseMap> getExpenseList(String paydocNo);

    List<BudgetdepartmentsEntity> selectBudgetdept();

    void updateCardStatus(Map<String, Object> map);

    void updateExpenseStatus(Map<String, Object> map);

    int cardStatusCheck(Map<String, Object> map);

    List<CamelCaseMap> getCollNo(Map<String, Object> param);

    void updateTbAppcStatus(Map<String, Object> map);

    void updateExpenseData(Map<String, Object> map);
}
