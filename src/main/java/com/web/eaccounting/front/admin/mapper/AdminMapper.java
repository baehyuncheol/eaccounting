package com.web.eaccounting.front.admin.mapper;

import com.web.eaccounting.core.dto.MenuDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {

    List<MenuDto> selectMenus();
}
