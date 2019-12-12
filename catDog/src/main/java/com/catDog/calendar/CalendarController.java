package com.catDog.calendar;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
			
			String startDay=String.format("%04d%02d%02d", syear, smonth, sdate);
			String endDay=String.format("%04d%02d%02d", eyear, emonth, edate);
			Map<String, Object> map=new HashMap<>();
			map.put("startDay", startDay);
			map.put("endDay", endDay);
			map.put("userId", info.getUserId());
			
			List<MyCalendar> list=service.listMonth(map);
			
			String s;
			String [][]days=new String[cal.getActualMaximum(Calendar.WEEK_OF_MONTH)][7];
			
			int cnt;
			for(int i=1; i<week; i++) {
				s=String.format("%04d%02d%02d", syear, smonth, sdate);
				days[0][i-1]="<span class='textDate preMonthDate' data-date='"+s+"' > "+sdate+"</span>";
				
				cnt=0;
				for(MyCalendar dto:list) {
					int sd8=Integer.parseInt(dto.getStartDate());
					int sd4=Integer.parseInt(dto.getStartDate().substring(4));
					int ed8=-1;
					if(dto.getEndDate()!=null) {
						ed8=Integer.parseInt(dto.getEndDate());
					}
					int cn8=Integer.parseInt(s);
					int cn4=Integer.parseInt(s.substring(4));
					
					if(cnt==4) {
						days[0][i-1]+="<span class='calendarMore' data-date='"+s+"' >"+"more..."+"</span>";
						break;
					}
				}
				sdate++;
			}
			
			int row, n=0;
			
			jump:
				for(row=0; row<days.length; row++) {
					for(int i=week-1; i<7; i++) {
						n++;
						s=String.format("%04d%02d%02d", year, month, n);
						
						if(i==0) {
							days[row][i]="<span class='textDate sundayDate' data-date='"+s+"' >"+n+"</span>";
						} else if(i==6) {
							days[row][i]="<span class='textDate saturdayDate' data-date='"+s+"' >"+n+"</span>";
						} else {
							days[row][i]="<span class='textDate nowDate' data-date='"+s+"' >"+n+"</span>";
						}
						
						cnt=0;
						for(MyCalendar dto:list) {
							int sd8=Integer.parseInt(dto.getStartDate());
							int sd4=Integer.parseInt(dto.getStartDate().substring(4));
							int ed8=-1;
							if(dto.getEndDate()!=null) {
								ed8=Integer.parseInt(dto.getEndDate());
							}
							int cn8=Integer.parseInt(s);
							int cn4=Integer.parseInt(s.substring(4));
							
							if(cnt==4) {
								days[row][i]+="<span class='calendarMore' data-date='"+s+"' >"+"more..."+"</span>";
								break;
							}
						}
						if(n==cal.getActualMaximum(Calendar.DATE)) {
							week=i+1;
							break jump;
						}
					}
					week=1;
				}
			
			if(week!=7) {
				n=0;
				for(int i=week; i<7; i++) {
					n++;
					s=String.format("%04d%02d%02d", eyear, emonth, n);
					days[row][i]="<span class='textDate nextMonthDate' data-date='"+s+"' >"+n+"</span>";
					
					cnt=0;
					for(MyCalendar dto:list) {
						int sd8=Integer.parseInt(dto.getStartDate());
						int sd4=Integer.parseInt(dto.getStartDate().substring(4));
						int ed8=-1;
						if(dto.getEndDate()!=null) {
							ed8=Integer.parseInt(dto.getEndDate());
						}
						int cn8=Integer.parseInt(s);
						int cn4=Integer.parseInt(s.substring(4));
						
						if(cnt==4) {
							days[row][i]+="<span class='calendarMore' data-date='"+s+"' > "+"more..."+"</span>";
							break;
						}
					}
				}
			}
			
			String today=String.format("%04d%02d%02d", todayYear, todayMonth, todayDate);
			
			model.addAttribute("year", year);
			model.addAttribute("month", month);
			model.addAttribute("todayYear", todayYear);
			model.addAttribute("todayMonth", todayMonth);
			model.addAttribute("todayDate", todayDate);
			model.addAttribute("today", today);
			model.addAttribute("days", days);
			
		} catch (Exception e) {
		}
		return ".calendar.month";
	}
	
	@RequestMapping(value="/calendar/day")
	public String day(@RequestParam(name="eventNum", defaultValue="0") int eventNum, 
					  @RequestParam(name="date", defaultValue="") String date,
					  HttpSession session, Model model) {
		
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			Calendar cal=Calendar.getInstance();
			
			String today=String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DATE));
			if(date.length()==0 || ! Pattern.matches("^\\d{8}$", date)) {
				date=today;
			}
			int year=Integer.parseInt(date.substring(0, 4));
			int month=Integer.parseInt(date.substring(4, 6));
			int day=Integer.parseInt(date.substring(6));
			
			cal.set(year, month-1, day);
			year=cal.get(Calendar.YEAR);
			month=cal.get(Calendar.MONTH)+1;
			day=cal.get(Calendar.DATE);
			
			cal.set(year, month-1, 1);
			int week=cal.get(Calendar.DAY_OF_WEEK);
			
			date=String.format("%04d%02d%02d", year, month, day);
			Map<String, Object> map=new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("date", date);
			List<MyCalendar> list=service.listDay(map);
			
			MyCalendar dto=null;
			if(eventNum!=0) {
				dto=service.readCalendar(eventNum);
			}
			if(dto==null&&list.size()>0) {
				dto=service.readCalendar(list.get(0).getEventNum());
			}
			
			Calendar cal2=(Calendar)cal.clone();
			cal2.add(Calendar.MONTH, -1);
			cal2.set(Calendar.DATE, 1);
			String preMonth=String.format("%04d%02d%02d", cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH)+1, cal2.get(Calendar.DATE));
			
			cal2.add(Calendar.MONTH, 2);
			String nextMonth=String.format("%04d%02d%02d", cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH)+1, cal2.get(Calendar.DATE));
			
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
			
			String s;
			String [][]days=new String[cal.getActualMaximum(Calendar.WEEK_OF_MONTH)][7];
			
			for(int i=1; i<week; i++) {
				s=String.format("%04d%02d%02d", syear, smonth, sdate);
				days[0][i-1]="<span class='textDate preMonthDate' data-date='"+s+"' >"+sdate+"</span>";
				sdate++;
			}
			int row, n=0;
			jump:
			for(row=0; row<days.length; row++) {
				for(int i=week-1; i<7; i++) {
					n++;
					s=String.format("%04d%02d%02d", year, month, n);
					
					if(i==0) {
						days[row][i]="<span class='textDate sundayDate' data-date='"+s+"' >"+n+"</span>";
					} else if(i==6) {
						days[row][i]="<span class='textDate saturdayDate' data-date='"+s+"' >"+n+"</span>";
					} else {
						days[row][i]="<span class='textDate nowDate' data-date='"+s+"' >"+n+"</span>";
					}
					if(n==cal.getActualMaximum(Calendar.DATE)) {
						week=i+1;
						break jump;
					}
				}
				week=1;
			}
			
			if(week!=7) {
				n=0;
				for(int i=week; i<7; i++) {
					n++;
					s=String.format("%04d%02d%02d", eyear, emonth, n);
					days[row][i]="<span class='textDate nextMonthDate' data-date='"+s+"' >"+n+"</span>";
				}
			}
			model.addAttribute("year", year);
			model.addAttribute("month", month);
			model.addAttribute("day", day);
			model.addAttribute("date", date);
			model.addAttribute("today", today);
			model.addAttribute("preMonth", preMonth);
			model.addAttribute("nextMonth", nextMonth);
			
			model.addAttribute("days", days);
			model.addAttribute("dto", dto);
			model.addAttribute("list", list);
			
		} catch (Exception e) {
		}
		return ".calendar.day";
	}
	
	@RequestMapping(value="/calendar/year")
	public String year(@RequestParam(name="year", defaultValue="0") int year, Model model) {
		try {
			Calendar cal=Calendar.getInstance();
			int y=cal.get(Calendar.YEAR);
			
			int todayYear=cal.get(Calendar.YEAR);
			String today=String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DATE));
			
			if(year<1900)
				year=y;
			String days[][][] = new String[12][6][7];
			int row, col, month_of_day;
			String s;
			for(int m = 1; m<=12; m++) {
			cal.set(year, m-1, 1);
			row=0;
			col = cal.get(Calendar.DAY_OF_WEEK)-1;
			month_of_day=cal.getActualMaximum(Calendar.DATE);
			for(int i=1; i<=month_of_day; i++) {
				s=String.format("%04d%02d%02d", year, m, i);
				
				if(col==0) {
					days[m-1][row][col]="<span class='textDate sundayDate' data-date='"+s+"' >"+i+"</span>";
				} else if(col==6) {
					days[m-1][row][col]="<span class='textDate satuedayDate' data-date='"+s+"' >"+i+"</span>";
				} else {
					days[m-1][row][col]="<span class='textDate nowDate' data-date='"+s+"' >"+i+"</span>";
				}
				col++;
				if(col > 6) {
					col = 0;
					row++;
				}
			}
			}
			model.addAttribute("year", year);
			
			model.addAttribute("todayYear", todayYear);
			model.addAttribute("today", today);
			model.addAttribute("days", days);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return ".calendar.year";
	}
	
	@RequestMapping(value="/calendar/insert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSubmit(MyCalendar dto, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setNum(info.getMemberIdx());
			service.insertCalendar(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/calendar/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(MyCalendar dto, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.updateCalendar(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/calendar/delete")
	public String delete(@RequestParam int eventNum, @RequestParam String date, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("eventNum", eventNum);
			service.deleteCalendar(map);
		} catch (Exception e) {
		}
		return "redirect:/calendar/dat?date="+date;
	}
}
