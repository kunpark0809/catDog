package com.catDog.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catDog.common.dao.CommonDAO;

@Service("pay.payService")
public class PayServiceImpl implements PayService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Pay readProudct(int productNum) {
		Pay dto = null;
		try {
			dto = dao.selectOne("pay.readProduct", productNum); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Pay readCustomer(long num) {
		Pay dto = null;
			try {
				dto = dao.selectOne("pay.readCumstomer",num);
				
				if(dto != null) {
					if(dto.getTel() !=null) {
						String[] s = dto.getTel().split("-");
						dto.setTel1(s[0]);
						dto.setTel2(s[1]);
						dto.setTel3(s[2]);
					}
					
					if(dto.getEmail() !=null) {
						String[] s = dto.getEmail().split("@");
						dto.setEmail1(s[0]);
						dto.setEmail2(s[1]);
						
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return dto;
	}

	@Override
	public void insertCustomer(Pay pay) throws Exception {
		try {
			pay.setNum(dao.selectOne("pay.customerSeq"));
			
			if(pay.getTel1() !=null && pay.getTel1().length() !=0 && 
					pay.getTel2() !=null && pay.getTel2().length() !=0 &&
					pay.getTel3() !=null && pay.getTel3().length() !=0) {
				pay.setTel(pay.getTel1()+"-"+pay.getTel2()+"-"+pay.getTel3());
			}
			
			if(pay.getEmail1() !=null && pay.getEmail1().length() !=0 && 
					pay.getEmail2() !=null && pay.getEmail2().length() !=0 ) {
				pay.setEmail(pay.getEmail1()+"@"+pay.getEmail2());
			}
			
			dao.insertData("pay.insertCumstomer",pay);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public String insertRequest(Pay pay) throws Exception {
		String requestNum = null;
		try {
			requestNum = dao.selectOne("pay.requestSeq");
			pay.setRequestNum(requestNum);
			pay.setPoint((int)(pay.getPurchase()*0.01));
			pay.setStatus(1);
			
			if(pay.getPayMethod()==0) {
				pay.setStatus(0);
			}
			
			if(pay.getDeliverTel1() !=null && pay.getDeliverTel1().length() !=0 && 
					pay.getDeliverTel2() !=null && pay.getDeliverTel2().length() !=0 &&
					pay.getDeliverTel3() !=null && pay.getDeliverTel3().length() !=0) {
				pay.setDeliverTel(pay.getDeliverTel1()+"-"+pay.getDeliverTel2()+"-"+pay.getDeliverTel3());
			}
			

			
			dao.insertData("pay.insertRequest",pay);
			dao.insertData("pay.insertpayment",pay);
			if(pay.getUsePoint() != 0) {
				Map<String, Object> map = new HashMap<>();
				map.put("num", pay.getNum());
				map.put("point", pay.getUsePoint());
				map.put("content", "구매 사용 포인트");
				map.put("checked", 0);
				dao.insertData("pay.insertPointDetail",map);
				dao.updateData("pay.usePoint",map);
			}
			
			if(pay.getRefundAccount() != null && !pay.getRefundAccount().equals("")) {
				dao.insertData("pay.insertrefund",pay);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return requestNum;
	}

	@Override
	public void insertRequestDetail(Pay pay) throws Exception {
		try {
			dao.insertData("pay.insertRequestDetail",pay);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		
	}
	
	@Override
	public void insertCart(Pay product) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num",product.getNum());
			map.put("productNum", product.getProductNum());
			
			Pay search = dao.selectOne("pay.readCart",map);
			if(search != null) {
				search.setProductCount(search.getProductCount()+product.getProductCount());
				search.setProductSum(search.getProductSum()+product.getProductSum());
				updateCount(search);
			} else {
				dao.insertData("pay.insertCart",product);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Pay readCart(String cartNum) throws Exception {
		Pay dto = null;
		try {
			dto = dao.selectOne("pay.searchCartNum",cartNum);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return dto;
	}

	@Override
	public void deleteCart(Map<String, Object> map) {
		
		try {
			dao.deleteData("pay.deleteCart",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<Pay> cartList(long num) {
		List<Pay> list = null;
		try {
			list = dao.selectList("pay.cartList",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateCount(Pay pay) throws Exception {
		try {
			dao.updateData("pay.updateCount",pay);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Pay> cartPayList(Map<String, Object> map) {
		List<Pay> list = null;
		
		try {
			list = dao.selectList("pay.cartPayList",map);
			int total = 0;
			for(Pay dto : list) {
				total +=dto.getProductSum();
			}
			list.get(0).setTotal(total);
			list.get(0).setPoint((int)(total*0.01));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Pay> requestList(String requestNum) throws Exception {
		List<Pay> list = null;
		
		try {
			list = dao.selectList("pay.readRequest",requestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}





}
