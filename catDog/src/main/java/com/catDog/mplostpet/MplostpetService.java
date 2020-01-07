package com.catDog.mplostpet;

import java.util.List;
import java.util.Map;

public interface MplostpetService {
	public List<Mplostpet> listMpLostPet(Map<String, Object> map);
	public int dataCountMpLostPet(Map<String, Object> map);

}
