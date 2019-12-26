package com.catDog.park;

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

@Service("park.ParkServiceImpl")
public class ParkServiceImpl implements ParkService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private ParkService service;
	

	@Override
	public void insertPark(Park dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("park.seq"));
			dao.insertData("park.insertPark", dto);
			
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
	public void insertImgFile(Park dto, String pathname) throws Exception {
		try {
			dao.insertData("park.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("park.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Park> listPark(Map<String, Object> map) {
		List<Park> list=null;
		
		try {
			list=dao.selectList("park.listPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Park readPark(int recommendNum) {
		Park dto = null;
		try {
			dto = dao.selectOne("park.readPark",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Park preReadPark(Map<String, Object> map) {
		Park dto=null;
		
		try {
			dto=dao.selectOne("park.preReadPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Park nextReadPark(Map<String, Object> map) {
		Park dto=null;
		
		try {
			dto=dao.selectOne("park.nextReadPark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updatePark(Park dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
					String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setImageFileName(saveFilename);
					updateImgFile(dto);
			}

			
			dao.updateData("park.updatePark", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("park.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deletePark(int recommendNum, String pathname, String userId) throws Exception {
		try {
			Park dto = readPark(recommendNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("park.deletePark", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/park/delete", method=RequestMethod.GET)
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
		String pathname=root+"uploads"+File.separator+"park";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deletePark(recommendNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/park/list?"+query;
	}
	
	

	@Override
	public void insertRate(Park dto) throws Exception {
		try {
			dao.insertData("park.insertRate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Park> listRate(Map<String, Object> map) {
		List<Park> list=null;
		try {
			list=dao.selectList("park.listRate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int rateCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("park.rateCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteRate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("park.deleteRate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void updateImgFile(Park dto) throws Exception {
		try {
			dao.updateData("park.updateImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
