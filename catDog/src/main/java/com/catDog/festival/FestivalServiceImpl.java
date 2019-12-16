package com.catDog.festival;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("festival.festivalService")
public class FestivalServiceImpl implements FestivalService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertFestival(Festival dto) throws Exception {
		try {
			dto.setStartDate(dto.getStartDate().replaceAll("-", ""));
			dto.setEndDate(dto.getEndDate().replaceAll("-", ""));
			dto.setStartTime(dto.getStartTime().replaceAll("-", ""));
			dto.setEndTime(dto.getEndTime().replaceAll("-", ""));
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
				dto.setEndDate("");
			dao.insertData("festival.insert", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<Festival> listMonth(Map<String, Object> map) throws Exception {
		List<Festival> list=null;
		try {
			list=dao.selectList("festival.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public List<Festival> listDay(Map<String, Object> map) throws Exception {
		List<Festival> list=null;
		try {
			list=dao.selectList("festival.listDay", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Festival readFestival(int eventNum) throws Exception {
		Festival dto=null;
		try {
			dto=dao.selectOne("festival.readFestival", eventNum);
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
	public void updateFestival(Festival dto) throws Exception {
		try {
			dto.setStartDate(dto.getStartDate().replaceAll("-", ""));
			dto.setEndDate(dto.getEndDate().replaceAll("-", ""));
			dto.setStartTime(dto.getStartTime().replaceAll(":", ""));
			dto.setEndTime(dto.getEndTime().replaceAll(":", ""));
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
				dto.setEndDate("");
			
			dao.updateData("festival.updateFestival", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void deleteFestival(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("festival.deleteFestival", map);
		} catch (Exception e) {
			throw e;
		}
	}
}
