package com.cdwoo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cdwoo.service.EnMonitorService;
import com.cdwoo.utils.PropertiesUtil;

@Controller
@RequestMapping("/en_monitor")
public class EnMonitorController {
    @Autowired
    private EnMonitorService enMonitorService;

    @ResponseBody
    @RequestMapping("/index")
    public Object index(HttpServletRequest request) {
        System.out.println(PropertiesUtil.get(request.getServletContext().getRealPath("/")+"/WEB-INF/classes/com/cdwoo/conf/constants/constants.properties","test"));
        return enMonitorService.getLatestInfo();
    }
}
