package com.catDog.cafe;

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

@Service("cafe.CafeServiceImpl")
public class CafeServiceImpl implements CafeService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private CafeService service;
	

	@Override
	public void insertCafe(Cafe dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("cafe.seq"));
			dao.insertData("cafe.insertCafe", dto);
			
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
	public void insertImgFile(Cafe dto, String pathname) throws Exception {
		try {
			dao.insertData("cafe.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("cafe.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Cafe> listCafe(Map<String, Object> map) {
		List<Cafe> list=null;
		
		try {
			list=dao.selectList("cafe.listCafe", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Cafe readCafe(int recommendNum) {
		Cafe dto = null;
		try {
			dto = dao.selectOne("cafe.readCafe",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Cafe preReadCafe(Map<String, Object> map) {
		Cafe dto=null;
		
		try {
			dto=dao.selectOne("cafe.preReadCafe", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Cafe nextReadCafe(Map<String, Object> map) {
		Cafe dto=null;
		
		try {
			dto=dao.selectOne("cafe.nextReadCafe", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateCafe(Cafe dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
					String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setImageFileName(saveFilename);
					updateImgFile(dto);
			}

			
			dao.updateData("cafe.updateCafe", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("cafe.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteCafe(int recommendNum, String pathname, String userId) throws Exception {
		try {
			Cafe dto = readCafe(recommendNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("cafe.deleteCafe", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/cafe/delete", method=RequestMethod.GET)
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
		String pathname=root+"uploads"+File.separator+"cafe";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteCafe(recommendNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/cafe/list?"+query;
	}
	
	

	@Override
	public void insertRate(Cafe dto) throws Exception {
		try {
			dao.insertData("cafe.insertRate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Cafe> listRate(Map<String, Object> map) {
		List<Cafe> list=null;
		try {
			list=dao.selectList("cafe.listRate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int rateCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("cafe.rateCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteRate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("cafe.deleteRate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
 

	@Override
	public void updateImgFile(Cafe dto) throws Exception {
		try {
			dao.updateData("cafe.updateImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
