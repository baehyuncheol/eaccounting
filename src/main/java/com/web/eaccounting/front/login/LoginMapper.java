package com.web.eaccounting.front.login;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface LoginMapper {
    LoginDto selectEmp(String UserId);
}
