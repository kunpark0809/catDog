package com.catDog.mpqna;

import java.util.List;
import java.util.Map;

public interface MpqnaService {

	public List<Mpqna> listMpQna(Map<String, Object> map);
	public int dataCountMpQna(Map<String, Object> map);
}
