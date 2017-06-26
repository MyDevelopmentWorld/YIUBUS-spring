package com.co.kr.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.co.kr.vo.BusMapBean;
import com.co.kr.vo.BusScheduleBean;
import com.co.kr.vo.BusStopBean;
import com.co.kr.vo.BusStopRoadViewBean;
import com.co.kr.vo.BusStopWithBusBean;
import com.co.kr.vo.NewLocationBean;
import com.co.kr.vo.NoticeBean;
import com.co.kr.vo.StaticBusInfoBean;
import com.co.kr.vo.ViewCountBean;

	

@Repository
public class YbusDao {
	
    String namespace = "com.co.kr.dao.YbusMapper.";
    
    @Autowired
    SqlSessionTemplate session;

    
    public List<NoticeBean> getNotice(){
    	return session.selectList(namespace + "getNotice");
    }
    
    
    public StaticBusInfoBean getBusInfo(String busId){
    	return session.selectOne(namespace + "getBusInfo",busId);
    }
    
    public List<BusScheduleBean> getBusSchedule(String type){
    	return session.selectList(namespace + "getBusSchedule",type);
    }
    
    
    public BusStopRoadViewBean getBsLoadView(String bsrpk){
    	return session.selectOne(namespace + "getBsLoadView",bsrpk);
    }
    
    public void setLocation(NewLocationBean location){
    	session.update(namespace + "updateIsNew",location);
    	session.insert(namespace + "setLocation",location);
    }
    
    public ViewCountBean getViewCount(String pagename){
    	return session.selectOne(namespace + "getViewCount",pagename);
    }
    
    public void insertViewCount(String pagename){
    	session.insert(namespace + "insertViewCount",pagename);
    } 
    
    public void updateViewCount(String vpk){
    	session.update(namespace + "updateViewCount",vpk);
    } 
    
    public List<BusStopWithBusBean> getBusStopWithBus(String line){
    	return session.selectList(namespace + "getBusStopWithBus",line);
    }
    
    public List<BusMapBean> getBusMap(String line){
    	return session.selectList(namespace + "getBusMap",line);
    }
    
    public List<BusStopBean> getCircleBusStop(String bpk){
    	return session.selectList(namespace + "getCircleBusStop",bpk);
    }
    
    public String getBusTurn(String bpk){
    	return session.selectOne(namespace + "getBusTurn",bpk);
    } 
    
    public void updateIsTurn(HashMap<String, Object>map){
    	session.update(namespace + "updateIsTurn",map);
    }
}
