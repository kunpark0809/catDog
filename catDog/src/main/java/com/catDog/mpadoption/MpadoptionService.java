package com.catDog.mpadoption;

import java.util.List;
import java.util.Map;

public interface MpadoptionService {

	public List<Mpadoption> listMpAdoption(Map<String, Object> map);
	public int dataCountMpAdoption(Map<String, Object> map);

}
