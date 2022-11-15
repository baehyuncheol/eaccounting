package com.web.eaccounting.front.login.repository;

import com.web.eaccounting.front.common.dto.LoginDto;
import com.web.eaccounting.front.common.entity.LoginEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;


public interface LoginRepository extends JpaRepository<LoginEntity, String>{

    public LoginEntity findByEmplNo(String emplNo);

    public void save(String emplNo);
}
