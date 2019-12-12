package com.catDog.calendar;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("calendar.calendarService")
public class CalendarServiceImpl implements CalendarService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertCalendar(MyCalendar dto) throws Exception {
		try {
			dto.setStartDate(dto.getStartDate().replaceAll("-", ""));
			dto.setEndDate(dto.getEndDate().replaceAll("-", ""));
			dto.setStartTime(dto.getStartTime().replaceAll("-", ""));
			dto.setEndTime(dto.getEndTime().replaceAll("-", ""));
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
				dto.setEndDate("");
			dao.insertData("calendar.insert", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<MyCalendar> listMonth(Map<String, Object> map) throws Exception {
		List<MyCalendar> list=null;
		try {
			list=dao.selectList("calendar.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public List<MyCalendar> listDay(Map<String, Object> map) throws Exception {
		List<MyCalendar> list=null;
		try {
			list=dao.selectList("calendar.listDay", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public MyCalendar readCalendar(int eventNum) throws Exception {
		MyCalendar dto=null;
		try {
			dto=dao.selectOne("calendar.readCalendar", eventNum);
			if(dto!=null) {
				String s;
				s=dto.getStartDate().substring(0, 4)+"-"+dto.getStartDate().substring(4, 6)+"-"+dto.getStartDate().substring(6);
				dto.setStartDate(s);
				if(dto.getEndDate()!=null&&dto.getEndDate().length()==8) {
					s=dto.getEndDate().substring(0, 4)+"-"+dto.getEndDate().substring(4, 6)+"-"+dto.getEndDate().substring(6);
					dto.setEndDate(s);
				}
				
				if(dto.getStartTime()!=null&&dto.getStartTime().length()==4) {
					s=dto.getStartTime().substring(0, 2)+":"+dto.getStartTime().substring(2);
					dto.setStartTime(s);
				}
				
				if(dto.getEndTime()!=null&&dto.getEndTime().length()==4) {
					s=dto.getEndTime().substring(0, 2)+":"+dto.getEndTime().substring(2);
					dto.setEndTime(s);
				}
				
				String period = dto.getStartDate();
				if(dto.getStartTime()!=null&&dto.getStartTime().length()!=0) {
					period+=" "+dto.getStartTime();
				}
				
				if(dto.getEndDate()!=null&&dto.getEndDate().length()!=0) {
					period+=" ~ "+dto.getEndDate();
				}
				
				if(dto.getEndTime()!=null&&dto.getEndTime().length()!=0) {
					period+=" "+dto.getEndTime();
				}
				dto.setPeriod(period);
			}
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateCalendar(MyCalendar dto) throws Exception {
		try {
			dto.setStartDate(dto.getStartDate().replaceAll("-", ""));
			dto.setEndDate(dto.getEndDate().replaceAll("-", ""));
			dto.setStartTime(dto.getStartTime().replaceAll(":", ""));
			dto.setEndTime(dto.getEndTime().replaceAll(":", ""));
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
				dto.setEndDate("");
			
			dao.updateData("calendar.updateCalendar", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void deleteCalendar(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("calendar.deleteCalendar", map);
		} catch (Exception e) {
			throw e;
		}
	}
}
