package com.catDog.calendar;

import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.customer.SessionInfo;

@Controller("calendar.calendarController")
public class CalendarController {
	@Autowired
	private CalendarService service;
	
	@RequestMapping(value="/calendar/month")
	public String month(@RequestParam(name="year", defaultValue="0") int year,
						@RequestParam(name="month", defaultValue="0") int month,
						HttpSession session, Model model) {
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			Calendar cal=Calendar.getInstance();
			int y=cal.get(Calendar.YEAR);
			int m=cal.get(Calendar.MONTH)+1;
			int todayYear=y;
			int todayMonth=m;
			int todayDate=cal.get(Calendar.DATE);
			
			if(year==0)
				year=y;
			if(month==0)
				month=m;
			
			cal.set(year, month-1, 1);
			year=cal.get(Calendar.YEAR);
			month=cal.get(Calendar.MONTH)+1;
			int week=cal.get(Calendar.DAY_OF_WEEK);
			
			Calendar scal=(Calendar)cal.clone();
			scal.add(Calendar.DATE, -(week-1));
			int syear=scal.get(Calendar.YEAR);
			int smonth=scal.get(Calendar.MONTH)+1;
			int sdate=scal.get(Calendar.DATE);
			
			Calendar ecal=(Calendar)cal.clone();
			ecal.add(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			ecal.add(Calendar.DATE, 7-ecal.get(Calendar.DAY_OF_WEEK));
			int eyear=ecal.get(Calendar.YEAR);
			int emonth=ecal.get(Calendar.MONTH)+1;
			int edate=ecal.get(Calendar.DATE);
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return ".calendar.month";
	}
	
	public String day() {
		return ".calendar.day";
	}
	
	public String year() {
		return ".calendar.year";
	}
	
	public Map<String, Object> insertSubmit() {
		return null;
	}
	
	public Map<String, Object> updateSubmit() {
		return null;
	}
	
	public String delete() {
		return null;
	}
}
