package com.catDog.mptip;

import java.util.List;
import java.util.Map;

public interface MptipService {
	
	public List<Mptip> listMpTip(Map<String, Object> map);
	public int dataCountMpTip(Map<String, Object> map);

}
