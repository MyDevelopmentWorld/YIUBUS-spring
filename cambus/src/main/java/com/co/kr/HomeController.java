package com.co.kr;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.co.kr.logic.LocationLogic;
import com.co.kr.util.ServiceUtil;
import com.co.kr.vo.BusScheduleBean;
import com.co.kr.vo.BusStopBean;
import com.co.kr.vo.NewLocationBean;
import com.co.kr.vo.ViewCountBean;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	ServiceUtil service;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/*공지사항을 가지고 옴*/
	@RequestMapping(value = "ybus/jsp/getMainInfo.do", method = RequestMethod.GET)
	public String getMainInfo(Model model) {

		// System.out.println(service.getNotice());
		model.addAttribute("notice", service.getNotice());
		return "ybus/jsp/main";
	}
	
	//안드로이드 초기 실행시 해당 기기가 어느 곳과 데이터통신할지에 대한 정보
	@RequestMapping(value = "ybus/exchangeJson/getBsList.do", method = RequestMethod.POST)
	public ModelAndView getBsList(@RequestParam(value="busId") String busId) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sendBusInfo");
		modelAndView.addObject("businfo",service.getBusInfo(busId));
		return modelAndView;
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "ybus/jsp/BusSchedule.do")
	public String getBusSchedule(Model model,@RequestParam(value="bscType")String bscType) {
		
		//오늘이 주말인지 아닌지 판단하여 넘어온 bscType과 비교하기 위함
        String weekResult = "week";
        Calendar calendar = Calendar.getInstance();
        //SUNDAY:1 SATURDAY:7
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        if (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY) {
        	weekResult = "weekend";
        }
        
		String type="";
		String bscName="";
		String beforeTime="08:00";
		String currentTime="";
		String nextTime="";
		
		if(bscType.equals("week")){
			//type = "semester#week";
			type = "vacation#week";
			bscName = "(방학중)평일 시간표";
		}else if(bscType.equals("weekend")){
			//type = "semester#weekend";
			type = "vacation#week";
			bscName = "(방학중)주말 시간표";
		}
		
		List<BusScheduleBean>list = service.getBusSchedule(type);
		
		for(BusScheduleBean b : list){
			
			nextTime = b.getBctime();
	        SimpleDateFormat sdf = new SimpleDateFormat("H:mm"); //H는 시간 형식이 24
	        
	        Time current = new Time(System.currentTimeMillis());//현재시간
	        Time before = new Time(System.currentTimeMillis());//이전시간
	        Time next = new Time(System.currentTimeMillis());//다음시간
	        //System.currentTimeMillis() 시스템 시간을 얻어온다.
	        
	        before.setHours(Integer.parseInt(beforeTime.split(":")[0]));
	        before.setMinutes(Integer.parseInt(beforeTime.split(":")[1]));
	        
	        next.setHours(Integer.parseInt(nextTime.split(":")[0]));
	        next.setMinutes(Integer.parseInt(nextTime.split(":")[1]));
	        
	        long gap = (next.getTime() - current.getTime())/60000;
	        
	        if(weekResult.equals(bscType)){
		        //0:해당사항없음 1:버스가 5분이상 남았을때 2:버스가 5분이하 또는 해당시간일때
		        if(current.equals(next)){//디비에서 가져온 시간과 현재시간이 같으면 
		        	 b.setCurrentBsc("2");
		        }else{
		            if(current.after(before) && current.before(next)){
		            	if(gap<=9){//시간이 9분안쪽으로 남았을때
		            		b.setCurrentBsc("2");
		            	}
		            	else{//그 외에 시간이 얼마 정도 남아있을경우
		            		b.setCurrentBsc("1");
		            	}
			        }
			        else{
			        	b.setCurrentBsc("0");
			        }
		        }
	        }else{
	        	b.setCurrentBsc("0");
	        }
	        
	        beforeTime = nextTime;
		}
		
		model.addAttribute("bsclist",list);
		model.addAttribute("bscName",bscName);
		return "ybus/jsp/busSchedule";
	}

	//2차 배포
	@RequestMapping(value = "ybus/jsp/bsLoadView.do", method = RequestMethod.GET)
	public String bsLoadView(Model model,@RequestParam(value="bsrpk") String bsrpk) {
		model.addAttribute("bsRoadviewList", service.getBsLoadView(bsrpk));
		return "ybus/jsp/bsLoadView";
	}
	
	//타임라인
	@RequestMapping(value = "ybus/jsp/circlebus.do", method = RequestMethod.GET)
	public String getCirclebus(Model model,@RequestParam(value="line")String line) {
		model.addAttribute("timeLine", service.getBusStopWithBus(line));
		return "ybus/jsp/timeLine";
	}
	
	//타임라인(노란버스)
		@RequestMapping(value = "ybus/jsp/yellowbus.do", method = RequestMethod.GET)
		public String getYellowBus(Model model,@RequestParam(value="line")String line) {
			model.addAttribute("timeLine", service.getBusStopWithBus(line));
			return "ybus/jsp/timeLineForYellow";
		}
	
	//안드로이드에서 전송한 데이터를 처리하기 위한 로직
	@RequestMapping(value = "ybus/exchangeJson/setLocation.do", method = RequestMethod.POST)
	public String setLocation(Model model,@ModelAttribute(value="location") NewLocationBean location) throws Exception {
		
		HashMap<String, Object>turnMap = new HashMap<String, Object>();
		double shortest; //타임라인에 띄웠으면 하는 정류장과의 최소거리를 적어주면됨 -> 1500M내만 체크
		String shortestAbpk="-1";
		List<BusStopBean>uplist = new ArrayList<BusStopBean>();
		List<BusStopBean>downlist = new ArrayList<BusStopBean>();
		List<BusStopBean>list = service.getCircleBusStop(location.getBpk()); //현재 버스의 정류장 리스트 가져옴
		String isturn = service.getBusTurn(location.getBpk()); //현재 버스가 상행인지 하행인지 가져옴 1:상행 -1:하행
		String line = list.get(0).getLine();
		LocationLogic locationLogic = new LocationLogic();
		
		//시내순환 로직
		if(line.equals("circle")){
			shortest=1500.0;	
			
			for(BusStopBean b:list){
				if(b.getUpdown().equals("up")){ //상행선인 경우 상행선 리스트만 뽑기
					uplist.add(b);
				}else{ //하행선인 경우 하행선 리스트만 뽑기
					downlist.add(b);
				}
			}
			
			if(isturn.equals("1")){
				//현 버스의 상행 여부에 따라 해당 리스트끼리 비교
				for(int i=0;i<uplist.size();i++){
					double blat = Double.parseDouble(location.getBlat());
					double blng = Double.parseDouble(location.getBlng());
					double alat = Double.parseDouble(uplist.get(i).getAblat());
					double alng = Double.parseDouble(uplist.get(i).getAblng());
					if(shortest>=locationLogic.distance(blat,blng,alat,alng)){
						shortest = locationLogic.distance(blat,blng,alat,alng);
						shortestAbpk = uplist.get(i).getAbpk();
						if(shortestAbpk.equals(uplist.get(uplist.size()-1).getAbpk())){//상행의 마지막 정류장일때 해당버스를 하행으로 바꿈
							turnMap.put("bpk", location.getBpk());
							turnMap.put("isturn", "-1");
							
							service.updateIsTurn(turnMap);
						}
					}
				}
				//System.out.println("셔틀버스 로직실행"+shortestAbpk);
			}else{
				//현 버스의 하행 여부에 따라 해당 리스트끼리 비교
				for(int i=0;i<downlist.size();i++){
					double blat = Double.parseDouble(location.getBlat());
					double blng = Double.parseDouble(location.getBlng());
					double alat = Double.parseDouble(downlist.get(i).getAblat());
					double alng = Double.parseDouble(downlist.get(i).getAblng());
					if(shortest>locationLogic.distance(blat,blng,alat,alng)){
						shortest = locationLogic.distance(blat,blng,alat,alng);
						shortestAbpk = downlist.get(i).getAbpk();
						if(shortestAbpk.equals(downlist.get(downlist.size()-1).getAbpk())){//상행의 마지막 정류장일때 해당버스를 하행으로 바꿈
							turnMap.put("bpk", location.getBpk());
							turnMap.put("isturn", "1");
							
							service.updateIsTurn(turnMap);
						}
					}
				}
				//System.out.println("셔틀버스 로직실행"+shortestAbpk);
			}
			
		//노란버스 로직
		}else if(line.equals("yellow")){
			
			shortest=1500.0;
			
			for(int i=0;i<list.size();i++){
				double blat = Double.parseDouble(location.getBlat());
				double blng = Double.parseDouble(location.getBlng());
				double alat = Double.parseDouble(list.get(i).getAblat());
				double alng = Double.parseDouble(list.get(i).getAblng());
				if(shortest>=locationLogic.distance(blat,blng,alat,alng)){
					shortest = locationLogic.distance(blat,blng,alat,alng);
					shortestAbpk = list.get(i).getAbpk();
				}
			}
			//System.out.println("노랭버스 로직실행"+shortestAbpk);
		}
		
		location.setAbpk(shortestAbpk);
		
		service.setLocation(location);
		return "ybus/exchangeJson/success";
	}
	
	//해당 클릭 디비에 넣기
	@RequestMapping(value = "ybus/jsp/viewCount.do", method = RequestMethod.POST)
	public String viewCount(Model model,@RequestParam(value="pagename")String pagename) {
		
		//클릭한 페이지와 오늘날짜로 레코드가있나 조회
		ViewCountBean bean = service.getViewCount(pagename);
		if(bean==null){
			//insert
			service.insertViewCount(pagename);
		}else{
			//update
			service.updateViewCount(bean.getVpk());
		}
		
		return "ybus/exchangeJson/success";
	}
	
	//지도에 띄울 버스들 위치 가져오기
	@RequestMapping(value = "ybus/exchangeJson/getPositions.do", method = RequestMethod.POST)
	public ModelAndView getPositions(Model modele,@RequestParam(value="line")String line) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("busmap", service.getBusMap(line));
		modelAndView.setViewName("busMapJson");
		return modelAndView;
	}	
}
