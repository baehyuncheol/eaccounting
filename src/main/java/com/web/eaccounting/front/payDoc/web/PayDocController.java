package com.web.eaccounting.front.payDoc.web;

import com.web.eaccounting.core.dto.LoginDto;
import com.web.eaccounting.core.entity.CodeEntity;
import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import com.web.eaccounting.core.utils.StringUtil;
import com.web.eaccounting.front.menu.service.MenuService;
import com.web.eaccounting.front.payDoc.service.PayDocService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/payDoc")
public class PayDocController {

    private final PayDocService payDocService;

    private final MenuService menuService;

    //private final SapService sapService;

    @RequestMapping(value = "/payDoc", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView paydocPage(ModelAndView modelAndView, HttpServletRequest req) {

        LoginDto loginVo = (LoginDto) req.getSession().getAttribute("SESSION_USERINFO");

        String menuId = StringUtil.nvl(req.getParameter("menuId"), "");
        String paydocNo = StringUtil.nvl(req.getParameter("paydocNo"), "");

        //paydocNo가 값이 있으면 수정 없으면 신규..

        //세션에 있는 값을 사용한다.
        String deptCode = loginVo.getDeptCode();
        String emplNo = loginVo.getEmplNo();
        String authorId = loginVo.getAuthorId();

        //3. 증빙구분 (공통코드 : 1709)
        List<CodeEntity> codeEvdList = payDocService.getCommonCode("1709");

        //6. 통화종류 (공통코드 : 1700) 기본값은 KRW
        List<CodeEntity> codeCurrencyList = payDocService.getCommonCode("1700");

        //7. 지급방법은 tb_paymentmethods
        List<String> list = new ArrayList<String>();
        list.add("9");
        list.add("F");
/*        *//* 임시 주석 처리 우선 페이지 처리만
        //8.세금코드 가져오기 tb_vatgroups
        //List<TbVatgroupsEntity> vatgroupsList = payDocService.getVatgroupsList();
        List<CodeEntity> vatgroupsList = payDocService.getCommonCode("1720");

        OrgBudgetMapEntity orgbudgetmap = payDocService.getTbOrgBudgetMapEntity(deptCode);
        List<BudgetdepartmentsEntity> budgetList = payDocService.getBudgetDepartments();

        //10. 계정코드 조회

        if ("".equals(paydocNo)) {
            //신규..
            /* 가져와야 할 리스트 정리
            --------------------------------------------------------------------------------
            1. menuId를 가지고 전표유형코드를 가져와야함..
            2. 전표유형코드를 가지고 전표유형명을 가져온다.
            3. menuId를 가지고 NaviName 가져오기.
            4. 증빙구분 (공통코드 : 1709)
            5. 세금계산서 팝업은 모두 ajax로 작업 될것임..
            6. 거래처 팝업도 마찬가지로 ajax로 작업..
            7. 통화종류 (공통코드 : 1700) 기본값은 KRW
            8. 지급방법은 tb_paymentmethods
            //기타증빙
            D, F, 1, 9
            //세금계산서
            F, 9
            //원천세
            F, 9
            증빙 구분에 따른 값이 보이는것이므로 F, 9만 보이면 될듯...
            9.세금코드 가져오기 tb_vatgroups
            10.계정코드 조회
            11.코스트센터 조회
            12.즐겨찾기 가져오기..
            *//*
            //1. 전표유형 코드를 가져오기...
            CatEntity cat = payDocService.getCatEntity(menuId);

            AccountsEntity account = payDocService.getAccountsEntity(cat.getAcctCode());

            //2. NaviName 가져오기..
            CamelCaseMap naviMap = payDocService.getNaviName(menuId);

            //menuId를 가지고 즐겨찾기 가져오기..
            FavoritPK favoritPK = new FavoritPK();
            favoritPK.setTransPatternCode(cat.getTransPatternCode());
            favoritPK.setEmplNo(emplNo);
            FavoritEntity favorit = payDocService.getFavorit(favoritPK, menuId);

            if ("B".equals(cat.getDocType()) || "C".equals(cat.getDocType())) {
                //임차보증금 구분(공통코드 : 1713)
                List<CodeEntity> codeGubunList = payDocService.getCommonCode("1713");
                modelAndView.addObject("codeGubunList", codeGubunList);
            } else if ("D".equals(cat.getDocType()) || "E".equals(cat.getDocType())) {
                //임차보증금 구분(공통코드 : 1714)
                List<CodeEntity> codeGubunList = payDocService.getCommonCode("1714");
                modelAndView.addObject("codeGubunList", codeGubunList);
            } else if ("V".equals(cat.getDocType())) {
                //11. 은행코드 (공통코드 : 1709)
                List<CodeEntity> codeBankList = payDocService.getCommonCode("1010");
                codeBankList = codeBankList.stream().sorted((a, b) -> a.getSortSeq() - b.getSortSeq()).filter(a -> a.getUsageInd().equals("Y")).collect(Collectors.toList());

                //12. 구매처그룹
                List<CodeEntity> codePurchaseGroupList = payDocService.getCommonCode("1710");

                modelAndView.addObject("codeBankList", codeBankList);
                modelAndView.addObject("codePurchaseGroupList", codePurchaseGroupList);
            } else if ("G".equals(cat.getDocType()) || "H".equals(cat.getDocType())) {
                //13. 원천세코드
                List<CodeEntity> whCodeList = payDocService.getCommonCode("1110");
                modelAndView.addObject("whCodeList", whCodeList);
            } else if ("P".equals(cat.getDocType())) {
                //(공통코드 : 1712)
                List<CodeEntity> ivCodeList = payDocService.getCommonCode("1712");
                modelAndView.addObject("ivCodeList", ivCodeList);
            } else if ("L".equals(cat.getDocType())) {
                //가지급금 구분(공통코드 : 1711)
                List<CodeEntity> codePaymentList = payDocService.getCommonCode("1711");
                modelAndView.addObject("codePaymentList", codePaymentList);

                list.clear();
                list.add("1");
                list.add("F");
            } else if ("R".equals(cat.getDocType())) {
                list.clear();
                list.add("D");
                list.add("F");
                list.add("1");
                list.add("9");
            }

            //modelandview로 데이터 전달...
            modelAndView.addObject("cat", cat);
            modelAndView.addObject("account", account);
            modelAndView.addObject("naviMap", naviMap);
            modelAndView.addObject("menuId", menuId);
            modelAndView.addObject("favorit", favorit);
        } else {
            //수정...
            //일단 내가 등록한것인지 아닌지 체크한다..
            TbAppcEntity appcEntity = new TbAppcEntity();
            //admin권한을 가진 사용자의 경우....모든 문서를 다 볼수 있음..
            if ("1".equals(authorId) || "2".equals(authorId))
                appcEntity = payDocService.getAppcAuth(paydocNo, emplNo, authorId);
            else
                appcEntity = payDocService.getAppcAuth(paydocNo, emplNo, authorId);

            if (appcEntity != null) {
                //1. 전표유형 코드를 가져오기...
                TbCatEntity cat = payDocService.getTbCatEntity(appcEntity.getMenuId());

                TbAccountsEntity account = payDocService.getTbAccountsEntity(cat.getAcctCode());

                //2. NaviName 가져오기..
                CamelCaseMap naviMap = payDocService.getNaviName(appcEntity.getMenuId());

                //menuId를 가지고 즐겨찾기 가져오기..
                FavoritPK favoritPK = new FavoritPK();
                favoritPK.setTransPatternCode(cat.getTransPatternCode());
                favoritPK.setEmplNo(emplNo);
                FavoritEntity favorit = payDocService.getFavorit(favoritPK, appcEntity.getMenuId());

                modelAndView.addObject("paydocNo", paydocNo);
                modelAndView.addObject("cat", cat);
                modelAndView.addObject("account", account);
                modelAndView.addObject("naviMap", naviMap);
                modelAndView.addObject("menuId", appcEntity.getMenuId());
                modelAndView.addObject("appcEntity", appcEntity);
                modelAndView.addObject("favorit", favorit);

                if ("B".equals(appcEntity.getDocType()) || "C".equals(appcEntity.getDocType())) {
                    //임대보증금 구분 (공통코드 : 1713)
                    List<CodeEntity> codeGubunList = payDocService.getCommonCode("1713");
                    modelAndView.addObject("codeGubunList", codeGubunList);
                } else if ("D".equals(appcEntity.getDocType()) || "E".equals(appcEntity.getDocType())) {
                    //임차보증금 구분 (공통코드 : 1714)
                    List<CodeEntity> codeGubunList = payDocService.getCommonCode("1714");
                    modelAndView.addObject("codeGubunList", codeGubunList);
                } else if ("V".equals(appcEntity.getDocType())) {
                    //11. 은행코드 (공통코드 : 1709)
                    List<CodeEntity> codeBankList = payDocService.getCommonCode("1010");
                    codeBankList = codeBankList.stream().sorted((a, b) -> a.getSortSeq() - b.getSortSeq()).filter(a -> a.getUsageInd().equals("Y")).collect(Collectors.toList());

                    //12. 구매처그룹
                    List<CodeEntity> codePurchaseGroupList = payDocService.getCommonCode("1710");

                    modelAndView.addObject("codeBankList", codeBankList);
                    modelAndView.addObject("codePurchaseGroupList", codePurchaseGroupList);
                } else if ("G".equals(appcEntity.getDocType()) || "H".equals(appcEntity.getDocType())) {
                    //13. 원천세코드
                    List<CodeEntity> whCodeList = payDocService.getCommonCode("1110");
                    modelAndView.addObject("whCodeList", whCodeList);
                } else if ("P".equals(cat.getDocType())) {
                    //(공통코드 : 1712)
                    List<CodeEntity> ivCodeList = payDocService.getCommonCode("1712");
                    modelAndView.addObject("ivCodeList", ivCodeList);
                } else if ("L".equals(cat.getDocType())) {
                    //가지급금 구분(공통코드 : 1711)
                    List<CodeEntity> codePaymentList = payDocService.getCommonCode("1711");
                    modelAndView.addObject("codePaymentList", codePaymentList);

                    list.clear();
                    list.add("1");
                    list.add("F");
                } else if ("R".equals(cat.getDocType())) {
                    list.clear();
                    list.add("D");
                    list.add("F");
                    list.add("1");
                    list.add("9");
                }
            } else {
                throw new BaseException("해당 문서를 조회할 권한이 없습니다.");
            }
        }

        List<PaymentmethodsEntity> paymentMethodsList = payDocService.getPaymentmethod(list);

        modelAndView.addObject("budgetList", budgetList);
        modelAndView.addObject("codeEvdList", codeEvdList);
        modelAndView.addObject("orgbudgetmap", orgbudgetmap);
        modelAndView.addObject("codeCurrencyList", codeCurrencyList);
        modelAndView.addObject("paymentMethodsList", paymentMethodsList);
        modelAndView.addObject("vatgroupsList", vatgroupsList);
        modelAndView.addObject("budgetList", budgetList);*/

        //오늘날짜 가져오기..
        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd");
        Calendar time = Calendar.getInstance();
        String todayDate = format1.format(time.getTime());
        modelAndView.addObject("todayDate", todayDate);


        modelAndView.setViewName("default:payDoc/payDoc");

        return modelAndView;
    }
/*
    @RequestMapping(value = "/paydoc/paymentmethod", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<TbPaymentmethodsEntity> getPaymentmethod(String menuId, String evdGb) {
        List<String> paymentList = new ArrayList<String>();
        List<TbPaymentmethodsEntity> paymentMethodsList = null;

        //접대비인경우 현금 추가..
        if( "074".equals(menuId)) {
            if ("01".equals(evdGb)) {
                paymentList.clear();
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            } else if ("02".equals(evdGb)) {
                //기타증빙 선택했을 시(code : "02", P타입만 "03")
                paymentList.clear();
                paymentList.add("1"); //현금
                paymentList.add("D"); //사내-F/B(경비)
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            } else if ("03".equals(evdGb)) {
                //기타증빙 선택했을 시(code : "02", P타입만 "03")
                paymentList.clear();
                paymentList.add("1"); //현금
                paymentList.add("D"); //사내-F/B(경비)
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            }
        } else {
            //접대비 이외의 일반비용인 경우..
            if ("01".equals(evdGb)) {
                paymentList.clear();
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            } else if ("02".equals(evdGb)) {
                //기타증빙 선택했을 시(code : "02", P타입만 "03")
                paymentList.clear();
                paymentList.add("D"); //사내-F/B(경비)
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            } else if ("03".equals(evdGb)) {
                //기타증빙 선택했을 시(code : "02", P타입만 "03")
                paymentList.clear();
                paymentList.add("D"); //사내-F/B(경비)
                paymentList.add("F"); //사외-F/B
                paymentList.add("9"); //상계
            }
        }

        paymentMethodsList = payDocService.getPaymentmethod(paymentList);

        return paymentMethodsList;
    }

    @RequestMapping(value = "/paydoc/businesspartners", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Page<TbBusinesspartnersEntity> getBusinessPartners(@RequestParam Map<String, String> params, HttpServletRequest req,
                                                              HttpServletResponse res, @PageableDefault(size = 10, sort = "cardCode") Pageable pageRequest) {
        String vendorSearch = (String) params.get("vendorSearch");
        String txtSearch = (String) params.get("txtSearch");
        String groupCode = (String) params.get("groupCode");

        return payDocService.getBusinessPartnersList(vendorSearch, txtSearch, groupCode, pageRequest);
    }

    @RequestMapping(value = "/paydoc/businessallpartners", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Page<TbBusinesspartnersEntity> getBusinessAllPartners(@RequestParam Map<String, String> params, HttpServletRequest req,
                                                                 HttpServletResponse res, @PageableDefault(size = 10, sort = "cardCode") Pageable pageRequest) {
        String vendorSearch = (String) params.get("vendorSearch");
        String txtSearch = (String) params.get("txtSearch");
        String groupCode = (String) params.get("groupCode");

        return payDocService.getBusinessAllPartnersList(vendorSearch, txtSearch, groupCode, pageRequest);
    }

    @RequestMapping(value = "/paydoc/taxbill", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Page<TbTblbillDetailEntity> getTaxbill(@RequestParam Map<String, Object> params, HttpServletRequest req,
                                                  HttpServletResponse res, @PageableDefault(size = 10, sort = "strcustno") Pageable pageRequest) {

        return payDocService.getTaxbillList(params, pageRequest);
    }

    @RequestMapping(value = "/paydoc/taxbillmybatis", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> getTaxbillMybatis(@RequestParam Map<String, Object> params) {

        return payDocService.getTaxbillMybatisList(params);
    }

    @RequestMapping(value = "/paydoc/favorit", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> insertdeleteFavorit(TbFavoritDto favoritDto, HttpServletRequest req, HttpServletResponse res) throws Exception {
        TbLoginDto loginVo = (TbLoginDto) req.getSession().getAttribute("SESSION_USERINFO");
        String flag = favoritDto.getFlag();

        Map<String, Object> returnMap = new HashMap<>();

        payDocService.insertDeleteFavorit(favoritDto, loginVo, flag);

        returnMap.put("status", "success");
        returnMap.put("msg", "등록 삭제 성공!");

        return returnMap;
    }


    @RequestMapping(value = "/paydoc/ebillcheck", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> getEbillCheck(String ebill, String paydocNo) {
        int cnt = payDocService.getEbillCheck(ebill, paydocNo);

        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("count", cnt);

        return returnMap;
    }

    @RequestMapping(value = "/paydoc/vendorcheck", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> getVendorCheck(String vendorReg, String cardType) {
        int cnt = payDocService.getVendorCheck(vendorReg, cardType);

        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("count", cnt);

        return returnMap;
    }

    @RequestMapping(value = "/paydoc/account", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Page<TbAccountsEntity> getAccount(@RequestParam Map<String, Object> params, HttpServletRequest req,
                                             HttpServletResponse res, @PageableDefault(size = 10, sort = "acctCode") Pageable pageRequest) {
        String sAccount = (String) params.get("sAccount");
        String txtSearch = (String) params.get("txtSearch");

        return payDocService.getAccountList(sAccount, txtSearch, pageRequest);
    }

    @RequestMapping(value = "/paydoc/accountbudgetcenter", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public TbAccountsEntity getAccountBudgetCenter(@RequestParam Map<String, Object> params, HttpServletRequest req,
                                                   HttpServletResponse res, String acctCode) {
        return payDocService.getAccount(acctCode);
    }

    @RequestMapping(value = "/paydoc/accountmybatis", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> getAccountMybatis(@RequestParam Map<String, Object> params) {
        return payDocService.getAccountMabatisList(params);
    }

    @RequestMapping(value = "/paydoc/budgetdept", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Page<TbBudgetdepartmentsEntity> getBudgetDept(@RequestParam Map<String, Object> params, HttpServletRequest req,
                                                         HttpServletResponse res, @PageableDefault(size = 10, sort = "code") Pageable pageRequest) {
        String sBudgetDept = (String) params.get("sBudgetDept");
        String txtSearch = (String) params.get("txtSearch");

        return payDocService.getBudgetDeptList(sBudgetDept, txtSearch, pageRequest);
    }

    @RequestMapping(value = "/paydoc/exchangeRate", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public CamelCaseMap exchangeRate(@RequestParam MultiValueMap<String, String> paramMap) {

        return sapService.exchangeRate(paramMap);
    }

    @RequestMapping(value = "/paydoc/taxbillpopup", method = {RequestMethod.GET})
    public ModelAndView getTaxbillPopup(ModelAndView modelAndView, @RequestParam Map<String, Object> params, HttpServletRequest req,
                                        HttpServletResponse res) {

        TbTblbillDetailEntity tblbillDetailEntity = payDocService.getTaxbillDetailPopup(params);
        List<TbTblbillSubEntity> tblbillSubEntityList = payDocService.getTaxbillSubPopupList(params);

        modelAndView.addObject("tblbillDetailEntity", tblbillDetailEntity);
        modelAndView.addObject("tblbillSubEntityList", tblbillSubEntityList);
        //위수탁세금계산서는 jsp를 분리했음..ㅡㅡ;;
        //심과장님 오픈직전이라 이해해주세요 ㅋㅋ
        if( "03".equals( tblbillDetailEntity.getTypeCd().substring(2)) ) {
            modelAndView.setViewName("popup:popup/taxbillPopup2");
        }else {
            modelAndView.setViewName("popup:popup/taxbillPopup");
        }

        return modelAndView;
    }

    @RequestMapping(value = "/paydoc/bpbankaccount", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public TbBusinesspartnersDto getBPBankAccount(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse res) {
        String vatRegNum = (String) params.get("vatRegNum");

        return payDocService.getBPBankAccount(vatRegNum);
    }
    */
}
