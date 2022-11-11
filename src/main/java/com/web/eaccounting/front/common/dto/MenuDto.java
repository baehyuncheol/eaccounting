package com.web.eaccounting.front.common.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuDto {

    private String menuId;
    private String menuName;
    private String menuIdUp;
    private String menuFullcode;
    private String menuUrl;
    private Integer sortSeq;
    private String usageInd;

    private String authorYn;
    private String lev;
    private String leafYn;
    private String subAuthorMenuId;

}
