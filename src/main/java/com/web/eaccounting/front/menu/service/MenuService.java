package com.web.eaccounting.front.menu.service;

import com.web.eaccounting.front.common.dto.MenuDto;
import com.web.eaccounting.front.menu.mapper.MenuMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class MenuService {

    private final MenuMapper menuMapper;

    public List<MenuDto> getMenuList(String emplNo, String deptCode) {
        return menuMapper.getMenuList(emplNo, deptCode);
    }

    public List<MenuDto> getLeftSubMenuData(String emplNo, String deptCode, String menuId, String lvl) {
        return menuMapper.getLeftSubMenuData(emplNo, deptCode, menuId, lvl);
    }
}
