package com.web.eaccounting.front.login.repository;

import com.web.eaccounting.front.common.dto.LoginDto;
import com.web.eaccounting.front.common.entity.LoginEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean
public interface LoginRepository extends JpaRepository<LoginDto, String>{

    public LoginEntity findByEmplNo(String emplNo);

    public LoginEntity findByEmplNoAndEmplPwd(String emplNo, String emplPwd);

    public void save(String emplNo);
}
