package com.catDog.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("event.eventService")
public class EventServiceImpl implements EventService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			dto.setEventNum(dao.selectOne("event.seq"));
			dao.insertData("event.insertEvent", dto);
			
			if(! dto.getMainUpload().isEmpty()) {
				String saveFilename = fileManager.doMainFileUpload(dto.getMainUpload(), pathname);
				if(saveFilename != null) {
					dto.setImageFilename(saveFilename);
					insertImgFile(dto, pathname);
				}
			}
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) continue;
					
					dto.setImageFilename(saveFilename);
					insertImgFile(dto, pathname);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertImgFile(Event dto, String pathname) throws Exception {
		try {
			dao.insertData("event.insertImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list = null;
		
		try {
			list=dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Event> readEvent(int eventNum) {
		List<Event> list=null;
		
		try {
			list=dao.selectOne("event.readEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int eventNum) throws Exception {
		try {
			dao.updateData("event.updateHitCount", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Event preReadEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.selectOne("event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event nextReadEvent(Map<String, Object> map) {
		Event dto=null;
		
		try {
			dto=dao.selectOne("event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doMainFileUpload(dto.getMainUpload(), pathname);
			
			if(saveFilename != null) {
				if(dto.getImageFilename().length()!=0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}
				dto.setImageFilename(saveFilename);
			}
			
			dao.updateData("event.updateEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteEvent(int eventNum, String pathname, String userId) throws Exception {
		try {
			List<Event> list = readEvent(eventNum);
			
			if(list==null || (! userId.equals("admin")))
				return;
			
			if(list.remove(eventNum)!=null)
				fileManager.doFileDelete(userId, pathname);
			
			dao.deleteData("event.deleteEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("event.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list =null;
		try {
			list=dao.selectList("event.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("event.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.selectList("event.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
