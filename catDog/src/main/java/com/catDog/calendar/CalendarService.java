package com.catDog.calendar;

import java.util.List;
import java.util.Map;

public interface CalendarService {
	public void insertCalendar(MyCalendar dto) throws Exception;
	
	public List<MyCalendar> listMonth(Map<String, Object> map) throws Exception;
	public List<MyCalendar> listDay(Map<String, Object> map) throws Exception;
	
	public MyCalendar readCalendar(int eventNum) throws Exception;
	
	public void updateCalendar(MyCalendar dto) throws Exception;
	public void deleteCalendar(Map<String, Object> map) throws Exception;
}
