package com.catDog.training;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;
import com.catDog.customer.SessionInfo;

@Service("training.TrainingServiceImpl")
public class TrainingServiceImpl implements TrainingService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private TrainingService service;
	

	@Override
	public void insertTraining(Training dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("training.seq"));
			dao.insertData("training.insertTraining", dto);
			
			if(! dto.getUpload().isEmpty()) {
				String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
				if(saveFilename != null) {
					dto.setImageFileName(saveFilename);
					insertImgFile(dto, pathname);
				}
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	@Override
	public void insertImgFile(Training dto, String pathname) throws Exception {
		try {
			dao.insertData("training.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("training.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Training> listTraining(Map<String, Object> map) {
		List<Training> list=null;
		
		try {
			list=dao.selectList("training.listTraining", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Training readTraining(int recommendNum) {
		Training dto = null;
		try {
			dto = dao.selectOne("training.readTraining",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Training preReadTraining(Map<String, Object> map) {
		Training dto=null;
		
		try {
			dto=dao.selectOne("training.preReadTraining", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Training nextReadTraining(Map<String, Object> map) {
		Training dto=null;
		
		try {
			dto=dao.selectOne("training.nextReadTraining", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateTraining(Training dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
					String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setImageFileName(saveFilename);
					updateImgFile(dto);
			}

			
			dao.updateData("training.updateTraining", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("training.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteTraining(int recommendNum, String pathname, String userId) throws Exception {
		try {
			Training dto = readTraining(recommendNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("training.deleteTraining", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/training/delete", method=RequestMethod.GET)
	public String delete(@RequestParam int recommendNum,
						 @RequestParam String page,
						 @RequestParam(defaultValue="all") String condition,
						 @RequestParam(defaultValue="") String keyword,
						 HttpSession session
						 ) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"training";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteTraining(recommendNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/training/list?"+query;
	}
	
	

	@Override
	public void insertRate(Training dto) throws Exception {
		try {
			dao.insertData("training.insertRate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Training> listRate(Map<String, Object> map) {
		List<Training> list=null;
		try {
			list=dao.selectList("training.listRate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int rateCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("training.rateCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteRate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("training.deleteRate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void updateImgFile(Training dto) throws Exception {
		try {
			dao.updateData("training.updateImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
