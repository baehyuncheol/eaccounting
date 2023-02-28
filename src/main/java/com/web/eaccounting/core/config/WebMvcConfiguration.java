package com.web.eaccounting.core.config;

import com.web.eaccounting.core.config.interceptor.SecurityInvocation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Slf4j
@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {

    private static final String[] EXCLUDE_PATHS = {
            "",
            "/",
            "/login",
            "/autologin",
            "/logout",
            "/loginView",
            "/error",
            "/error/**",
            "/assets/**",
            "/assets/**/**",
            "/components/**",
            "/components/**/**",
            "/fonts/**",
            "/fonts/**/**",
            "/images/**",
            "/images/**/**",
            "/js/**",
            "/js/**/**",
            "/css/**",
            "/css/**/**",
            "/views/**",
            "/views/**/**",
            "/sample/**",
            "/paydoc/taxbillpopup"/*세금계산서 팝업*/
    };

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**").addResourceLocations("classpath:/static/");
    }

    @Configuration
    public static class SecurityConfiguration implements WebMvcConfigurer {
        private List<SecurityInvocation> securityInvocations;

        @Autowired
        public SecurityConfiguration(List<SecurityInvocation> securityInvocations) {
            this.securityInvocations = securityInvocations;
        }

        @Override
        public void addInterceptors(InterceptorRegistry registry) {
            for (SecurityInvocation securityInvocation : securityInvocations) {
                //log.info("securityInvocation==>"+securityInvocation);
                registry.addInterceptor((HandlerInterceptor) securityInvocation)
                        .excludePathPatterns(EXCLUDE_PATHS);
            }
        }
    }
}