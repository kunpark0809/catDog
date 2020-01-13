package com.catDog.aband;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("aband.abandonedService")
public class AbandServiceImpl implements AbandService{

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertAband(Aband dto, String pathname) throws Exception {
		try {
			if(!dto.getUpload().isEmpty()) {
				String saveName = fileManager.doFileUpload(dto.getUpload(), pathname);
				if(saveName != null) {
					dto.setImageFileName(saveName);
				}
			}
			
			dao.insertData("aband.insertAband",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result =dao.selectOne("aband.dataCount", map);
		} catch (Exception e){
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Aband> listAband(Map<String, Object> map) {
		List<Aband> list = null;
		try {
			list = dao.selectList("aband.listAband",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Aband readAband(int lostPetNum) {
		Aband dto = null;
		try {
			dto = dao.selectOne("aband.readAband",lostPetNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Aband preReadAband(Map<String, Object> map) {
		Aband dto = null;
		try {
			dto = dao.selectOne("aband.preReadAband",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Aband nextReadAband(Map<String, Object> map) {
		Aband dto = null;
		try {
			dto = dao.selectOne("aband.nextReadAband",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateAband(Aband dto, String pathname) throws Exception {
		try {
			if(!dto.getUpload().isEmpty()) {
				String saveFileName = fileManager.doFileUpload(dto.getUpload(), pathname); 
				if(saveFileName != null && dto.getImageFileName()!=null && dto.getImageFileName().length() != 0) { 
					fileManager.doFileDelete(dto.getImageFileName(),pathname);
					dto.setImageFileName(saveFileName);
				}
			}
			dao.updateData("aband.updateAband",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteAband(int lostPetNum, String pathname, String userId) throws Exception {
		try {
			Aband dto = readAband(lostPetNum);
			
			if(dto==null || userId.indexOf("admin")>0) {
				return;
			}
			
			dao.deleteData("aband.deleteAband",lostPetNum);
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateStatus(Map<String, Object> map) throws Exception {
		try {
			
			dao.updateData("aband.updateStatus",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}

	@Override
	public void insertReply(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("aband.insertReply",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.selectList("aband.listReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("aband.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Reply> listReplyAnswer(int parent) {
		List<Reply> list = null;
		try {
			list = dao.selectList("aband.listAnswerReply", parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int parent) {
		int result = 0;
		try {
			result = dao.selectOne("aband.replyAnswerCount",parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("aband.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
