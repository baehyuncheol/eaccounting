package com.web.eaccounting.front.approvalDoc.service;


import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.core.utils.StringUtil;
import com.web.eaccounting.front.approvalDoc.mapper.ApprovalDocMapper;
import com.web.eaccounting.core.dto.CodeDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class ApprovalDocService {

    private final ApprovalDocMapper approvalDocMapper;
    public Map<String, Object> getApprovalData(Map<String, Object> param) {

        int page = Integer.parseInt(String.valueOf(param.get("page")));
        int perPage = Integer.parseInt(String.valueOf(param.get("perPage")));
        String sortColumn = StringUtil.isEmpty(param.get("sortColumn")) ? "" : param.get("sortColumn").toString();
        String sortColumnSnake = StringUtil.camelToSnake(sortColumn);
        String sortAscending = StringUtil.isEmpty(param.get("sortAscending")) ? "" : param.get("sortAscending").toString();
        String sortDirection = sortAscending.equals("true") ? "asc" : "desc";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("apprvStatus", StringUtil.isEmpty(param.get("apprvStatus")) ? "" : param.get("apprvStatus").toString());
        paramMap.put("apprvStatus2", StringUtil.isEmpty(param.get("apprvStatus2")) ? "" : param.get("apprvStatus2").toString());
        paramMap.put("emplNo", StringUtil.isEmpty(param.get("emplNo")) ? "" : param.get("emplNo").toString());
        paramMap.put("purchaseName", StringUtil.isEmpty(param.get("purchaseName")) ? "" : param.get("purchaseName").toString());
        paramMap.put("startDate", StringUtil.isEmpty(param.get("startDate")) ? "" : param.get("startDate").toString());
        paramMap.put("endDate", StringUtil.isEmpty(param.get("endDate")) ? "" : param.get("endDate").toString());
        paramMap.put("searchName", StringUtil.isEmpty(param.get("searchName")) ? "" : param.get("searchName").toString());
        paramMap.put("apprvTitle", StringUtil.isEmpty(param.get("apprvTitle")) ? "" : param.get("apprvTitle").toString());
        paramMap.put("objAcctNo", StringUtil.isEmpty(param.get("objAcctNo")) ? "" : param.get("objAcctNo").toString());
        paramMap.put("searchDate", StringUtil.isEmpty(param.get("searchDate")) ? "" : param.get("searchDate").toString());
        paramMap.put("depthOne", StringUtil.isEmpty(param.get("depthOne")) ? "" : param.get("depthOne").toString());
        paramMap.put("depthTwo", StringUtil.isEmpty(param.get("depthTwo")) ? "" : param.get("depthTwo").toString());
        paramMap.put("depthThree", StringUtil.isEmpty(param.get("depthThree")) ? "" : param.get("depthThree").toString());
        paramMap.put("page", (page - 1) * perPage);
        paramMap.put("perPage", perPage);
        paramMap.put("sortColumn", sortColumnSnake);
        paramMap.put("sortDirection", sortDirection);

        List<CamelCaseMap> contents = approvalDocMapper.getApprovalData(paramMap);
        int totalCount = approvalDocMapper.getApprovalDataCount(paramMap);

        Map<String, Object> pageMap = new HashMap<String, Object>();
        pageMap.put("page", page);
        pageMap.put("totalCount", totalCount);

        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("contents", contents);
        dataMap.put("pagination", pageMap);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("result", true);
        resultMap.put("data", dataMap);

        return resultMap;
    }

    public ArrayList<CodeDto> selectCodeDepth1(CodeDto codeDto) {
        return approvalDocMapper.selectCodeDepth1(codeDto);
    }

    public ArrayList<CodeDto> selectCodeDepth2(CodeDto codeDto) {
        return approvalDocMapper.selectCodeDepth2(codeDto);
    }

    public ArrayList<CodeDto> selectCodeDepth3(CodeDto codeDto) {
        return approvalDocMapper.selectCodeDepth3(codeDto);
    }

}
