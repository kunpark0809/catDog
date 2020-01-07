package com.catDog.mpbbs;

import java.util.List;
import java.util.Map;

public interface MpbbsService {

	public List<Mpbbs> listMpBbs(Map<String, Object> map);
	public int dataCountMpBbs(Map<String, Object> map);

}
