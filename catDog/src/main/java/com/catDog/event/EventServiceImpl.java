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
					dto.setImageFileName(saveFilename);
					insertImgFile(dto);
				}
			}
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) continue;
					
					dto.setImageFileName(saveFilename);
					insertImgFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertImgFile(Event dto) throws Exception {
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
		List<Event> list = null;
		
		try {
			list = dao.selectList("event.readEvent", eventNum);
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
			if(! dto.getMainUpload().isEmpty()) {
				String imageFileName = fileManager.doMainFileUpload(dto.getMainUpload(), pathname);
				if(imageFileName != null) {
					fileManager.doFileDelete(dto.getImageFileName(), pathname);
					
					dto.setImageFileName(imageFileName);
					updatePic(dto);
				}
			}
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String imageFileName = fileManager.doFileUpload(mf, pathname);
					if(imageFileName == null) continue;
					
					dto.setImageFileName(imageFileName);
					insertImgFile(dto);
				}
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
			
			// if(list==null || (! (userId.indexOf("admin") > 0)))
			//	return;
			
			if(list==null || userId.indexOf("admin") != 0 )
				return;
			
			for(Event dto : list) {
				fileManager.doFileDelete(dto.getImageFileName(), pathname);
			}
			
			dao.deleteData("event.deleteEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<Event> upReEvent(int eventNum) {
		
		List<Event> list = null;
		
		try {
			list = dao.selectList("event.upReEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Event> listFile(int eventNum) {
		List<Event> listFile=null;
		
		try {
			listFile=dao.selectList("event.listFile", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}
	
	@Override
	public Event readFile(int eventPicNum) {
		Event dto=null;
		
		try {
			dto=dao.selectOne("event.readFile", eventPicNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("event.deleteFile", map);
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
		List<Reply> list=null;
		try {
			list=dao.selectList("event.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("event.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
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
		List<Reply> list = null;
		try {
			list=dao.selectList("event.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result = dao.selectOne("event.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updatePic(Event dto) throws Exception {
		try {
			dao.updateData("event.updatePic", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
