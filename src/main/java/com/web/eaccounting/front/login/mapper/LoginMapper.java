package com.web.eaccounting.front.login.mapper;

import com.web.eaccounting.core.dto.LoginDto;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface LoginMapper {
    LoginDto findByEmplNo(String emplNo);
}
