package com.web.eaccounting.front.admin.service;

import com.web.eaccounting.core.dto.MenuDto;
import com.web.eaccounting.front.admin.mapper.AdminMapper;
import com.web.eaccounting.front.menu.mapper.MenuMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@Transactional
public class AdminService {

    private final AdminMapper adminMapper;

    private final MenuMapper menuMapper;

    @Autowired
    public AdminService(AdminMapper adminMapper, MenuMapper menuMapper)
    {
        this.adminMapper = adminMapper;

        this.menuMapper = menuMapper;
    }

    public List<MenuDto> selectMenus() {

        return menuMapper.selectMenus();
    }

    public ArrayList<MenuDto> selectByMenu(MenuDto tbMenuDto) {
        return menuMapper.selectByMenu(tbMenuDto);
    }

}
