package com.web.eaccounting.core.dto;

import com.web.eaccounting.core.common.AtomObject;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class MenuDto extends AtomObject {

    private String menuId;
    private String menuName;
    private String menuIdUp;
    private String menuFullcode;
    private String menuUrl;
    private String menuIdUpName;
    private String menuIconCss;
    private Integer sortSeq;
    private String usageInd;

    //01 : main만, 02: left만 , 03: header만 04 :main, left둘다 나중에 공통코드에 추가...
    //현재까지 셋다 나오는 경우는 없음..ㅡㅡ;;
    private String filter1;

    private String authorYn;
    private String lev;
    private String leafYn;
    private String subAuthorMenuId;

    private String text;

    private List<MenuDto> tbMenuDtoList;

    @Override
    public MenuDto of(AtomObject source) {
        return super.of(source, this.getClass());
    }

}
