package com.catDog.adopt;
 
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("adopt.adoptService")
public class AdoptServiceImpl implements AdoptService{
	
	@Autowired
	private CommonDAO dao; 
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertAdopt(Adopt dto,String pathname) throws Exception {
		try {
			
			if(!dto.getUpload().isEmpty()) {
				String saveFileName= fileManager.doFileUpload(dto.getUpload(), pathname);
				if(saveFileName != null) {
					dto.setImageFileName(saveFileName);
				}
			}
			
			dao.insertData("adopt.insertAdopt",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("adopt.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Adopt> listAdopt(Map<String, Object> map) {
		List<Adopt> list = null;
		
		try {
			list = dao.selectList("adopt.listAdopt",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int adoptionNum) throws Exception {
		try {
			dao.updateData("adopt.updateHitCount",adoptionNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Adopt readAdopt(int adoptionNum) {
		Adopt dto = null;
		
		try {
			dto = dao.selectOne("adopt.readAdopt",adoptionNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Adopt preReadAdopt(Map<String, Object> map) {
		Adopt dto = null;
		
		try {
			dto = dao.selectOne("adopt.preReadAdopt",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Adopt nextReadAdopt(Map<String, Object> map) {
		Adopt dto = null;
		
		try {
			dto = dao.selectOne("adopt.nextReadAdopt",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public void updateAdopt(Adopt dto, String pathname) throws Exception {
		try {
			if(!dto.getUpload().isEmpty()) {
				String saveFileName = fileManager.doFileUpload(dto.getUpload(), pathname); 
				if(saveFileName != null && dto.getImageFileName()!=null && dto.getImageFileName().length() != 0) { 
					fileManager.doFileDelete(dto.getImageFileName(),pathname);
					dto.setImageFileName(saveFileName);
				}
			}
			dao.updateData("adopt.updateAdopt",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void deleteAdopt(int adoptionNum,String pathname, String userId) throws Exception {
		try {
			Adopt dto = readAdopt(adoptionNum);
			
			if(dto==null || userId.indexOf("admin")>0) {
				return;
			}
			
			dao.deleteData("adopt.deleteAdopt",adoptionNum);
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateStatus(Map<String, Object> map) throws Exception {
		try {
			
			dao.updateData("adopt.updateStatus",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertReply(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("adopt.insertReply",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.selectList("adopt.listReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("adopt.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Reply> listReplyAnswer(int parent) {
		List<Reply> list = null;
			try {
				list = dao.selectList("adopt.listAnswerReply", parent);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return list;
	}

	@Override
	public int replyAnswerCount(int parent) {
		int result = 0;
		try {
			result = dao.selectOne("adopt.replyAnswerCount",parent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("adopt.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}



}
