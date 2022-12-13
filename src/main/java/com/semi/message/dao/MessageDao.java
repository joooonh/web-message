package com.semi.message.dao;

import java.util.List;
import java.util.Map;

import com.semi.message.vo.Message;
import com.semi.message.vo.MessageReceivers;
import com.semi.util.SqlMapper;

public class MessageDao {

	private static MessageDao instance = new MessageDao();
	private MessageDao() {}
	public static MessageDao getInstance() {
		return instance;
	}
	
	public int getMessageNo() {
		return (Integer) SqlMapper.selectOne("messages.getMessageNo");
	}
	
	public void sendMessage(Message message) {
		SqlMapper.insert("messages.sendMessage", message);
	}
	
	public void receiveMessageEmployee(MessageReceivers messageReceivers) {
		SqlMapper.insert("messages.receiveMessageEmployee", messageReceivers);
	}
	
}
	
