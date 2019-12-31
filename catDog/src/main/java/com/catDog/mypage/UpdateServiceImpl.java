package com.catDog.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;
import com.catDog.customer.Customer;

@Service("mypage.updateService")
public class UpdateServiceImpl implements UpdateService {
	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public void updateMemberDetail(Customer dto) throws Exception {
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					 dto.getEmail2() != null && dto.getEmail2().length() != 0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length() != 0 &&
						dto.getTel3() != null && dto.getTel3().length() != 0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			dao.updateData("customer.memberRegister", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
