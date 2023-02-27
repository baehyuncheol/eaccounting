package com.web.eaccounting.front.approvalDoc.mapper;


import com.web.eaccounting.front.common.dto.AppcDto;
import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.front.common.dto.CodeDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface ApprovalDocMapper {
    List<CamelCaseMap> getApprovalData(Map<String, Object> paramMap);

    Integer getApprovalDataCount(Map<String, Object> paramMap);

    ArrayList<CodeDto> selectCodeDepth1(CodeDto codeDto);
    ArrayList<CodeDto> selectCodeDepth2(CodeDto codeDto);
    ArrayList<CodeDto> selectCodeDepth3(CodeDto codeDto);

    int updateByStatus(AppcDto appcDto);
    int updateByMtype(AppcDto appcDto);
    int updateByKtype(Map<String, Object> map);


}