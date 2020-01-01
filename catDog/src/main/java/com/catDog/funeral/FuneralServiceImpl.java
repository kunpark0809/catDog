package com.catDog.funeral;

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

@Service("funeral.FuneralServiceImpl")
public class FuneralServiceImpl implements FuneralService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private FuneralService service;
	

	@Override
	public void insertFuneral(Funeral dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("funeral.seq"));
			dao.insertData("funeral.insertFuneral", dto);
			
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
	public void insertImgFile(Funeral dto, String pathname) throws Exception {
		try {
			dao.insertData("funeral.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("funeral.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Funeral> listFuneral(Map<String, Object> map) {
		List<Funeral> list=null;
		
		try {
			list=dao.selectList("funeral.listFuneral", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Funeral readFuneral(int recommendNum) {
		Funeral dto = null;
		try {
			dto = dao.selectOne("funeral.readFuneral",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Funeral preReadFuneral(Map<String, Object> map) {
		Funeral dto=null;
		
		try {
			dto=dao.selectOne("funeral.preReadFuneral", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Funeral nextReadFuneral(Map<String, Object> map) {
		Funeral dto=null;
		
		try {
			dto=dao.selectOne("funeral.nextReadFuneral", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateFuneral(Funeral dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
					String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setImageFileName(saveFilename);
					updateImgFile(dto);
			}

			
			dao.updateData("funeral.updateFuneral", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("funeral.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteFuneral(int recommendNum, String pathname, String userId) throws Exception {
		try {
			Funeral dto = readFuneral(recommendNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("funeral.deleteFuneral", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/funeral/delete", method=RequestMethod.GET)
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
		String pathname=root+"uploads"+File.separator+"funeral";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteFuneral(recommendNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/funeral/list?"+query;
	}
	
	

	@Override
	public void insertRate(Funeral dto) throws Exception {
		try {
			dao.insertData("funeral.insertRate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Funeral> listRate(Map<String, Object> map) {
		List<Funeral> list=null;
		try {
			list=dao.selectList("funeral.listRate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int rateCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("funeral.rateCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteRate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("funeral.deleteRate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void updateImgFile(Funeral dto) throws Exception {
		try {
			dao.updateData("funeral.updateImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
