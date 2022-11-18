package com.web.eaccounting.front.approvalDoc.web;


import com.web.eaccounting.front.approvalDoc.service.ApprovalDocService;
import com.web.eaccounting.front.common.dto.CodeDto;
import com.web.eaccounting.front.common.entity.CodeEntity;
import com.web.eaccounting.front.paydoc.service.PayDocService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/approvalDoc")
public class ApprovalDocController {

    private final ApprovalDocService approvalDocService;

    private final PayDocService payDocService;

    @GetMapping(value = "/list")
    public Map<String, Object> getApprovalData(@RequestParam Map<String, Object> param){
        return approvalDocService.getApprovalData(param);
    }

    @GetMapping(value = "/depth1")
    public ArrayList<CodeDto> selectCodeDepth1(CodeDto codeDto) {
        return approvalDocService.selectCodeDepth1(codeDto);
    }

    @GetMapping(value = "/depth2")
    public ArrayList<CodeDto> selectCodeDepth2(CodeDto codeDto) {
        return approvalDocService.selectCodeDepth2(codeDto);
    }

    @GetMapping(value = "/depth3")
    public ArrayList<CodeDto> selectCodeDepth3(CodeDto codeDto) {
        return approvalDocService.selectCodeDepth3(codeDto);
    }

    //작성중 문서
    /*
    @GetMapping("/writing")
    public ModelAndView writingDocView(ModelAndView modelAndView, HttpServletRequest req) {
        List<CodeEntity> codeDepthOneList = payDocService.getCommonCode("1412");
        modelAndView.addObject("codeDepthOneList", codeDepthOneList);
        modelAndView.setViewName("default:approvalDoc/writingDoc");

        return modelAndView;
    }

    //결재 진행중 문서
    @GetMapping("/payment")
    public ModelAndView paymentDocView(ModelAndView modelAndView) {
        List<CodeEntity> codeDepthOneList = payDocService.getCommonCode("1412");
        modelAndView.addObject("codeDepthOneList", codeDepthOneList);
        modelAndView.setViewName("default:approvalDoc/paymentDoc");

        return modelAndView;
    }

    //결재 완료된 문서
    @GetMapping("/paymentEnd")
    public ModelAndView paymentEndDocView(ModelAndView modelAndView) {
        List<CodeEntity> codeDepthOneList = payDocService.getCommonCode("1412");
        modelAndView.addObject("codeDepthOneList", codeDepthOneList);
        modelAndView.setViewName("default:approvalDoc/paymentEndDoc");

        return modelAndView;
    }
*/
}
