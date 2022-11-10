package com.web.eaccounting.front.login.mapper;

import com.web.eaccounting.front.common.dto.LoginDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Mapper
public interface LoginMapper {
    LoginDto findByEmplNo(String emplNo);
}
