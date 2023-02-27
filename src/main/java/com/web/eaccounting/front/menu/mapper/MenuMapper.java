package com.web.eaccounting.front.menu.mapper;

import com.web.eaccounting.front.common.dto.MenuDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface MenuMapper {

    List<MenuDto> getMenuList (String emplNo, String deptCode);

    List<MenuDto> getLeftSubMenuData(String emplNo, String deptCode, String menuId, String lvl);

    List<MenuDto> selectMenus();

    ArrayList<MenuDto> selectByMenu(MenuDto tbMenuDto);
}
