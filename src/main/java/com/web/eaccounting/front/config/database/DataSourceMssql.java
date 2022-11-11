package com.web.eaccounting.front.config.database;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.transaction.ChainedTransactionManager;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.HashMap;

@Configuration
@MapperScan(value="com.web.eaccounting.**.**.mapper", sqlSessionFactoryRef="mssqlSqlSessionFactory")
@EnableTransactionManagement
@EnableJpaRepositories(
        entityManagerFactoryRef = "mssqlEntityManagerFactory",
        transactionManagerRef = "mssqlTransactionManager",
        basePackages = "com.web.eaccounting.**.**.repository")
public class DataSourceMssql {
    @Qualifier("mssqlDataSource")
    private final DataSource mssqlDataSource;

    @Autowired
    public DataSourceMssql(DataSource mssqlDataSource) {
        this.mssqlDataSource = mssqlDataSource;
    }



    @Primary
    @Bean(name = "mssqlSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Autowired@Qualifier("mssqlDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sessionFactoryBean.setMapperLocations(resolver.getResources("classpath:/sqlmap/*.xml"));
        //sessionFactoryBean.setConfigLocation(resolver.getResource("classpath:/sqlmap/sqlmap-config.xml"));
        return sessionFactoryBean.getObject();
    }


    @Primary
    @Bean(name = "mssqlSqlSessionTemplate")
    public SqlSessionTemplate sqlSessionTemplate(@Autowired@Qualifier("mssqlSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    @Primary
    @Bean(name = "mssqlEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean mssqlEntityManagerFactory() {
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(mssqlDataSource);
        //em.setPackagesToScan("com.gsitm.eAccounting.**.**.model");
        em.setPackagesToScan( new String[] {"com.web.eaccounting.**.**.entity"});
        em.setPersistenceUnitName("mssql");
        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        em.setJpaVendorAdapter(vendorAdapter);
        HashMap<String, Object> properties = new HashMap<>();
        //properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
        properties.put("hibernate.dialect", "org.hibernate.dialect.SQLServer2012Dialect");
        properties.put("hibernate.show-sql", "true");
        properties.put("hibernate.hbm2ddl.auto", "none");
        properties.put("hibernate.format_sql", "true");
        properties.put("hibernate.physical_naming_strategy" , "org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy");

        em.setJpaPropertyMap(properties);
        return em;
    }

    @Primary
    @Bean("mssqlTransactionManager")
    public PlatformTransactionManager mssqlTransactionManager() {

        JpaTransactionManager jpaTransactionManager = new JpaTransactionManager();
        jpaTransactionManager.setEntityManagerFactory(mssqlEntityManagerFactory().getObject());

        // MYBATIS transactionManager
        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(mssqlDataSource);

        // creates chained transaction manager
        ChainedTransactionManager transactionManager = new ChainedTransactionManager(jpaTransactionManager, dataSourceTransactionManager);

        return transactionManager;
    }
}
