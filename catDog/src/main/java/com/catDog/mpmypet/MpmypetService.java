package com.catDog.mpmypet;

import java.util.List;
import java.util.Map;

public interface MpmypetService {

	public List<Mpmypet> listMpMyPet(Map<String, Object> map);
	public int dataCountMpMyPet(Map<String, Object> map);

}
