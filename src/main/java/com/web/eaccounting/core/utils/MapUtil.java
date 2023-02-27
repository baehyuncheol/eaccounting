package com.gsitm.eaccounting.core.utils;

import com.gsitm.eaccounting.core.mybatis.type.CamelCaseMap;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Slf4j
public class MapUtil {

    public static Object getObject(Map<String, Object> optionData, String key) {
        Object returnObj = optionData.get(key);
        return returnObj;
    }

    public static String getString(Map<String, Object> optionData, String key) {
        Object returnObj = optionData.get(key);
        if (returnObj == null) {
            return "";
        } else {
            return (String) returnObj;
        }

    }

    public static Long getLong(Map<String, Object> optionData, String key) {
        Object returnObj = optionData.get(key);
        if (returnObj == null) {
            return null;
        } else {
            return Long.valueOf((String) returnObj);
        }

    }

    /**
     * @param map 변환할 문자
     * @return 키값을 소문자로 변환한 맵
     */

    public static String mapToJson(Map<String, Object> map) {
        JSONObject json = new JSONObject();
        try {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                // json.addProperty(key, value);
                json.put(key, value);
            }
        } catch (JSONException e) {
            log.debug(e.toString());
        }
        return json.toString();
    }

    public static JSONObject getJsonStringFromMap( Map<String, Object> map )
    {
        JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
        }
        return jsonObject;
    }

    public static CamelCaseMap toMap(JSONObject object) throws JSONException {
        CamelCaseMap map = new CamelCaseMap();
        Iterator<String> keysItr = object.keys();
        while(keysItr.hasNext()) {
            String key = keysItr.next();
            Object value = object.get(key);
            if(value instanceof JSONArray) {
                value = toList((JSONArray) value);
            }
            else if(value instanceof JSONObject) {
                value = toMap((JSONObject) value);
            }
            map.put(key, value);
        }
        return map;
    }
    public static List<Object> toList(JSONArray array) throws JSONException {
        List<Object> list = new ArrayList<Object>();
        for(int i = 0; i < array.length(); i++) {
            Object value = array.get(i);
            if(value instanceof JSONArray) {
                value = toList((JSONArray) value);
            }
            else if(value instanceof JSONObject) {
                value = toMap((JSONObject) value);
            }
            list.add(value);
        }
        return list;
    }
}