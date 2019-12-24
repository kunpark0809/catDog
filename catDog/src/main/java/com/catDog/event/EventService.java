package com.catDog.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent(Event dto, String pathname) throws Exception;
	public void insertImgFile(Event dto, String pathname) throws Exception;
	public List<Event> listEvent(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public List<Event> readEvent(int eventNum);
	public List<Event> upReEvent(int eventNum);
	public void updateHitCount(int eventNum) throws Exception;
	public Event preReadEvent(Map<String, Object> map);
	public Event nextReadEvent(Map<String, Object> map);
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int eventNum, String pathname, String userId) throws Exception;
	
	/*public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	public int replyCount(Map<String, Object> map);
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);*/
}
