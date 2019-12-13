package com.catDog.cs;

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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNotice(int noticeNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertQna(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna readQna(int qnaNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna preReadQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna nextReadQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateQna(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteQna(int qnaNum) throws Exception {
		// TODO Auto-generated method stub
		
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
	public int qnaDataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int faqDataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
