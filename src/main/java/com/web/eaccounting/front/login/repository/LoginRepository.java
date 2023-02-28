package com.web.eaccounting.front.login.repository;

import com.web.eaccounting.core.entity.LoginEntity;
import org.springframework.data.jpa.repository.JpaRepository;


public interface LoginRepository extends JpaRepository<LoginEntity, String>{

    public LoginEntity findByEmplNo(String emplNo);

    public void save(String emplNo);
}
