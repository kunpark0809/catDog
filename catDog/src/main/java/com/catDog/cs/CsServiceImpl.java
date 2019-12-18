package com.catDog.cs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("cs.csService")
public class CsServiceImpl implements CsService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertNotice(Notice dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("notice.seq");
			dto.setNoticeNum(seq);
			
			dao.insertData("notice.insertNotice", dto);
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFileName = fileManager.doFileUpload(mf, pathname);
					if(saveFileName==null) continue;
					
					String originalFileName = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFileName(originalFileName);
					dto.setSaveFileName(saveFileName);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
			}
		}			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}		
	}

	@Override
	public int noticeDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("notice.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;
		
		try {
			list = dao.selectList("notice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return list;
	}

	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list = null;
		
		try {
			list = dao.selectList("notice.listNoticeTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int noticeNum) throws Exception {
		dao.updateData("notice.updateHitCount", noticeNum);
	}

	@Override
	public Notice readNotice(int noticeNum) {
		Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.readNotice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.preReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.nextReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateNotice(Notice dto, String pathname) throws Exception {
		try {
			dao.updateData("notice.updateNotice", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String saveFileName = fileManager.doFileUpload(mf, pathname);
					if(saveFileName==null) continue;
					
					String originalFileName = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFileName(originalFileName);
					dto.setSaveFileName(saveFileName);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteNotice(int noticeNum, String pathname) throws Exception {
		try {
			List<Notice> list = listFile(noticeNum);
			if(list!=null) {
				for(Notice dto : list) {
					fileManager.doFileDelete(dto.getSaveFileName(), pathname);
				}
			}
			Map<String, Object> map = new HashMap<>();
			map.put("field", "noticeNum");
			map.put("num", noticeNum);
			deleteFile(map);
			
			dao.deleteData("notice.deleteNotice", noticeNum);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertFile(Notice dto) throws Exception {
		try {
			dao.insertData("notice.insertNoticeFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Notice> listFile(int noticeNum) {
		List<Notice> list = null;
		
		try {
			list = dao.selectList("notice.listFile", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return list;
	}

	@Override
	public Notice readFile(int fileNum) {
		Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("notice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertQna(Qna dto) throws Exception {
		try {
			int seq = dao.selectOne("qna.seq");
			dto.setQnaNum(seq);
			
			dao.insertData("qna.insertQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int qnaDataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;
		try {
			list=dao.selectList("qna.listQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Qna readQnaQuestion(int qnaNum) {
		Qna dto = null;
		try{
			dto=dao.selectOne("qna.readQnaQuestion", qnaNum);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Qna preReadQnaQuestion(Map<String, Object> map) {
		Qna dto = null;
		try{
			dto=dao.selectOne("qna.preReadQnaQuestion", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Qna nextReadQnaQuestion(Map<String, Object> map) {
		Qna dto = null;
		try{
			dto=dao.selectOne("qna.nextReadQnaQuestion", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateQna(Qna dto) throws Exception {
		try{
			dao.updateData("qna.updateQna", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteQnaQuestion(int qnaNum) throws Exception {
		try{
			dao.deleteData("qna.deleteQnaQuestion", qnaNum);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Qna readQnaAnswer(int parent) {
		Qna dto = null;
		
		try{
			dto=dao.selectOne("qna.readQnaAnswer", parent);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteQnaAnswer(int qnaNum) throws Exception {
		try{
			dao.deleteData("qna.deleteQnaAnswer", qnaNum);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertQnaCategory(Qna dto) throws Exception {
		try {
			dao.insertData("qna.insertQnaCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateQnaCategory(Qna dto) throws Exception {
		try {
			dao.updateData("qna.updateQnaCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteQnaCategory(int qnaCategoryNum) throws Exception {
		try {
			dao.deleteData("qna.deleteQnaCategory", qnaCategoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Qna> listQnaCategory() {
		List<Qna> list = null;
		try {
			list=dao.selectList("qna.listQnaCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

	@Override
	public void insertFaq(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Qna> listFaq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna readFaq(int faqNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna preReadFaq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna nextReadFaq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateFaq(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteFaq(int faqNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

	

	@Override
	public int faqDataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
