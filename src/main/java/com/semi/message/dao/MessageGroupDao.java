package com.semi.message.dao;


import java.util.List;
import java.util.Map;

import com.semi.message.vo.MessageGroup;
import com.semi.util.SqlMapper;

public class MessageGroupDao {
	private static MessageGroupDao instance = new MessageGroupDao();
	private MessageGroupDao() {}
	public static MessageGroupDao getInstance() {
		return instance;
	}
	
	public void insertMessageGroup(MessageGroup messageGroup) {
		SqlMapper.insert("messageGroup.insertMessageGroup", messageGroup);
	}
	
	public MessageGroup getMessageGroupsByGroupNo(int groupNo)  {
		return (MessageGroup) SqlMapper.selectOne("messageGroup.getMessageGroupsByGroupNo", groupNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<MessageGroup>  getMessageGroupsByEmpNo(int empNo)  {
		return (List<MessageGroup>) SqlMapper.selectList("messageGroup.getMessageGroupsByEmpNo", empNo);
		}
	

	public void updateMessageGroup(MessageGroup messageGroup) {
		SqlMapper.update("messageGroup.updateMessageGroup", messageGroup);
	}
	
	public void deleteMessageGroup(int groupNo) {
		SqlMapper.delete("messageGroup.deleteMessageGroup", groupNo);
	}
}
