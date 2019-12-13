package com.catDog.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.FileManager;
import com.catDog.common.dao.CommonDAO;

@Service("customer.customerService")
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public void insertMember(Customer dto, String pathname) throws Exception {
		try {
			if (dto.getEmail1() != null && dto.getEmail1().length() != 0 && dto.getEmail2() != null
					&& dto.getEmail2().length() != 0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());

			if (dto.getTel1() != null && dto.getTel1().length() != 0 && dto.getTel2() != null
					&& dto.getTel2().length() != 0 && dto.getTel3() != null && dto.getTel3().length() != 0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());

			dto.setAddr(dto.getAddr1()+" "+dto.getAddr2());
			
			long customerSeq = dao.selectOne("customer.customerSeq");
			dto.setNum(customerSeq);
			
			
			
			String userPic = fileManager.doFileUpload(dto.getUpload(), pathname);
			if (userPic != null) {
				dto.setUserPic(userPic);
			}

			dao.updateData("customer.memberRegister", dto);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Customer loginCustomer(String userId) throws Exception {
		Customer dto = null;

		try {
			dto = dao.selectOne("customer.loginCustomer", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Customer nickNameCheck(String nickName) throws Exception {
		Customer dto = null;

		try {
			dto = dao.selectOne("customer.nickNameCheck", nickName);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Customer readCustomer(String userId) throws Exception {
		Customer dto = null;

		try {
			dto = dao.selectOne("customer.readCustomer", userId);

			if (dto != null) {
				if (dto.getEmail() != null) {
					String[] s = dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if (dto.getTel() != null) {
					String[] s = dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

}
