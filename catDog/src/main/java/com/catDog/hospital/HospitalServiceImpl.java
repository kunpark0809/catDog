package com.catDog.hospital;

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

@Service("hospital.HospitalServiceImpl")
public class HospitalServiceImpl implements HospitalService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private HospitalService service;
	

	@Override
	public void insertHospital(Hospital dto, String pathname) throws Exception {
		try {
			dto.setRecommendNum(dao.selectOne("hospital.seq"));
			dao.insertData("hospital.insertHospital", dto);
			
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
	public void insertImgFile(Hospital dto, String pathname) throws Exception {
		try {
			dao.insertData("hospital.insertImgFile",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("hospital.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Hospital> listHospital(Map<String, Object> map) {
		List<Hospital> list=null;
		
		try {
			list=dao.selectList("hospital.listHospital", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Hospital readHospital(int recommendNum) {
		Hospital dto = null;
		try {
			dto = dao.selectOne("hospital.readHospital",recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
		

	@Override
	public Hospital preReadHospital(Map<String, Object> map) {
		Hospital dto=null;
		
		try {
			dto=dao.selectOne("hospital.preReadHospital", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Hospital nextReadHospital(Map<String, Object> map) {
		Hospital dto=null;
		
		try {
			dto=dao.selectOne("hospital.nextReadHospital", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHospital(Hospital dto, String pathname) throws Exception {
		try {
			
			
			if(! dto.getUpload().isEmpty()) {
					String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
					dto.setImageFileName(saveFilename);
					updateImgFile(dto);
			}

			
			dao.updateData("hospital.updateHospital", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
	@Override
	public void updateHitCount(int recommendNum) throws Exception {
		try {
			dao.updateData("hospital.updateHitCount", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteHospital(int recommendNum, String pathname, String userId) throws Exception {
		try {
			Hospital dto = readHospital(recommendNum);
	
			if(dto==null || userId.indexOf("admin") != 0 )
				return;
	
			fileManager.doFileDelete(dto.getImageFileName(), pathname);
			

			dao.deleteData("hospital.deleteHospital", recommendNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@RequestMapping(value="/hospital/delete", method=RequestMethod.GET)
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
		String pathname=root+"uploads"+File.separator+"hospital";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteHospital(recommendNum, pathname, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/hospital/list?"+query;
	}
	
	

	@Override
	public void insertRate(Hospital dto) throws Exception {
		try {
			dao.insertData("hospital.insertRate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public List<Hospital> listRate(Map<String, Object> map) {
		List<Hospital> list=null;
		try {
			list=dao.selectList("hospital.listRate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int rateCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("hospital.rateCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public void deleteRate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("hospital.deleteRate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void updateImgFile(Hospital dto) throws Exception {
		try {
			dao.updateData("hospital.updateImgFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
