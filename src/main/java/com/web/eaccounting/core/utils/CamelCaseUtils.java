package com.web.eaccounting.core.utils;

import com.web.eaccounting.core.mybatis.type.CamelCaseMap;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;

import java.lang.reflect.Field;

@Slf4j
public class CamelCaseUtils {

    /**
     *
     * @param name
     * @return
     */
    public static String convertUnderscoreNameToPropertyName(String name) {
        StringBuilder result = new StringBuilder();
        String[] names;
        String fristPart;
        String secondPart;
        int i = 0;
        name = name.toLowerCase();
        names = name.split("_");

        if (names.length == 1) {
            return name.toLowerCase();
        }

        for (String word : names) {
            i++;
            if (i == 1) {
                result.append(word.toLowerCase());
                continue;
            }

            fristPart = word.substring(0, 1);
            result.append(fristPart.toUpperCase());
            secondPart = word.substring(1, word.length());
            result.append(secondPart);
        }
        return result.toString();
    }


    public static Object convertObject(CamelCaseMap camelCaseMap, Class<?> clazz) {

        Object object = null;
        Object value;
        try {
            object = clazz.newInstance();
            for (Field field : clazz.getDeclaredFields()) {
                value = camelCaseMap.get(field.getName());
                if (value == null) {
                    continue;
                }

                try {
                    BeanUtils.setProperty(object, field.getName(), value);
                } catch (Exception e) {
                	log.error(ExceptionUtils.getMessage(e));
                }

            }
        } catch (Exception ex) {
        	log.error(ExceptionUtils.getMessage(ex));
        }

        return object;
    }


    public static CamelCaseMap convertMap(Object object) {

        CamelCaseMap camelCaseMap = new CamelCaseMap();
        Object value = null;
        try {
            Class<?> clazz = object.getClass();
            for (Field field : clazz.getDeclaredFields()) {
                try {
                    value = BeanUtils.getProperty(object,field.getName());
                } catch (NoSuchMethodException e) {
                    continue;
                }

                camelCaseMap.putPlain(field.getName(), value);
            }
        } catch (Exception ex) {
        	log.error(ExceptionUtils.getMessage(ex));
        }

        return camelCaseMap;
    }
}
