package com.cdwoo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cdwoo.dao.EnMonitorDao;

@Service
public class EnMonitorServiceImpl implements EnMonitorService {
    @Autowired
    private EnMonitorDao enMonitorDao;
    public Object getLatestInfo() {
        return enMonitorDao.getLatestInfo();
    }
}
