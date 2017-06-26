package com.co.kr.util;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.co.kr.dao.YbusDao;
import com.co.kr.vo.BusMapBean;
import com.co.kr.vo.BusScheduleBean;
import com.co.kr.vo.BusStopBean;
import com.co.kr.vo.BusStopRoadViewBean;
import com.co.kr.vo.BusStopWithBusBean;
import com.co.kr.vo.NewLocationBean;
import com.co.kr.vo.NoticeBean;
import com.co.kr.vo.StaticBusInfoBean;
import com.co.kr.vo.ViewCountBean;

@Service
public class ServiceUtil {
	@Autowired
	YbusDao dao;

    public List<NoticeBean> getNotice(){
    	return dao.getNotice();
    }
    
    public StaticBusInfoBean getBusInfo(String busId){
    	return dao.getBusInfo(busId);
    }

    public List<BusScheduleBean> getBusSchedule(String type){
    	return dao.getBusSchedule(type);
    }
    
    public BusStopRoadViewBean getBsLoadView(String bsrpk){
    	return dao.getBsLoadView(bsrpk);
    }
    
    public void setLocation(NewLocationBean location){
    	dao.setLocation(location);
    }
    
    public ViewCountBean getViewCount(String pagename){
    	return dao.getViewCount(pagename);
    }
    
    public void insertViewCount(String pagename){
    	dao.insertViewCount(pagename);
    }
    
    public void updateViewCount(String vpk){
    	dao.updateViewCount(vpk);
    }
    
    public List<BusStopWithBusBean> getBusStopWithBus(String line){
    	return dao.getBusStopWithBus(line);
    }
    public List<BusMapBean> getBusMap(String line){
    	return dao.getBusMap(line);
    }
    
    public List<BusStopBean> getCircleBusStop(String bpk){
    	return dao.getCircleBusStop(bpk);
    }
    
    public String getBusTurn(String bpk){
    	return dao.getBusTurn(bpk);
    }
    
    public void updateIsTurn(HashMap<String, Object>map){
    	dao.updateIsTurn(map);
    }
    
    
}