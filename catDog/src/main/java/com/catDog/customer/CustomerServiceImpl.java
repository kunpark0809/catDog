package com.catDog.customer;

import java.util.List;
import java.util.Map;

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

	@Override
	public void updateEnabled(Map<String, Object> map) throws Exception {

		try {
			dao.updateData("customer.updateEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int failureCount(String userId) {
		int result = -1;

		try {
			result = dao.selectOne("customer.failureCount", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void failureReset(String userId) throws Exception {

		try {
			dao.updateData("customer.failureReset", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public void updateFailure(String userId) throws Exception {

		try {
			dao.updateData("customer.updateFailure", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateFailureReset(String userId) throws Exception {
		try {
			dao.updateData("customer.updateFailureReset", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {

		try {
			dao.updateData("customer.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertMemberState(Customer customer) throws Exception {

		try {
			dao.insertData("customer.insertMemberState", customer);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Customer> listMemberState(String userId) {
		List<Customer> list = null;
		try {
			list = dao.selectList("customer.listMemberState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Customer readMemberState(String userId) {
		Customer customer = null;
		try {
			customer = dao.selectOne("customer.readMemberState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return customer;
	}

	@Override
	public void deleteCustomerDetail(int num) throws Exception {

		try {
			dao.deleteData("customer.deleteCustomerDetail", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteMemberDetail(int num) throws Exception {

		try {
			dao.deleteData("customer.deleteMemberDetail", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updatePwd(Customer dto) throws Exception {

		try {
			dao.updateData("customer.updatePwd", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
}
