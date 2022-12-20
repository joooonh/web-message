package com.semi.message.dao;

import java.util.List;
import java.util.Map;

import com.semi.admin.vo.Department;
import com.semi.admin.vo.Employee;
import com.semi.message.dto.MessageDeleteDto;
import com.semi.message.vo.Message;
import com.semi.message.vo.MessageDepartment;
import com.semi.message.vo.MessageReceiver;
import com.semi.util.SqlMapper;

public class MessageDao {

	private static MessageDao instance = new MessageDao();
	private MessageDao() {}
	public static MessageDao getInstance() {
		return instance;
	}
	
	public int getMessageNo() {
		return (int) SqlMapper.selectOne("messages.getMessageNo");
	}
	
	public void sendMessage(Message message) {
		SqlMapper.insert("messages.sendMessage", message);
	}
	
	public void receiveMessageEmployee(MessageReceiver messageReceiver) {
		SqlMapper.insert("messages.receiveMessageEmployee", messageReceiver);
	}
	
	public void receiveMessageDepartment(MessageDepartment messageDepartment) {
		SqlMapper.insert("messages.receiveMessageDepartment", messageDepartment);
	}
	
	public int getTotalRows(Map<String, Object> param) {
		return (int) SqlMapper.selectOne("messages.getTotalRows", param); 
	}
	
	@SuppressWarnings("unchecked")
	public List<Message> getMessageList(Map<String, Object> param) {
		return (List<Message>) SqlMapper.selectList("messages.getMessageList", param);
	}
	
	public MessageReceiver getEmpReceiverByMessageNo(int messageNo) {
		return (MessageReceiver) SqlMapper.selectOne("messages.getEmpReceiverByMessageNo", messageNo);
	}
	
	public MessageDepartment getDeptReceiverByMessageNo(int messageNo) {
		return (MessageDepartment) SqlMapper.selectOne("messages.getDeptReceiverByMessageNo", messageNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<Department> getDeptList() {
		return (List<Department>) SqlMapper.selectList("messages.getDeptList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Employee> getEmpList() {
		return (List<Employee>) SqlMapper.selectList("messages.getEmpList");
	}
	
	public void deleteReceiveMessage(MessageDeleteDto messageDeleteDto) {
		SqlMapper.update("messages.deleteReceiveMessage", messageDeleteDto);
	}
	
	public void deleteSendMessage(MessageDeleteDto messageDeleteDto) {
		SqlMapper.update("messages.deleteSendMessage", messageDeleteDto);
	}
	
	public void clearReceiveMessage(int empNo) {
		SqlMapper.update("messages.clearReceiveMessage", empNo);
	}
	public void clearSendMessage(int empNo) {
		SqlMapper.update("messages.clearSendMessage", empNo);
	}
	
	public void cancelMessage(MessageDeleteDto messageDeleteDto) {
		SqlMapper.update("messages.cancelMessage", messageDeleteDto);
	}
	
	public void readMessageDateUpdate(int messageNo) {
		SqlMapper.update("messages.readMessageDateUpdate", messageNo);
	}
	public void readMessageisReadUpdate(int messageNo) {
		SqlMapper.update("messages.readMessageisReadUpdate", messageNo);
	}
	
	public void readMessage(int messageNo) {
		SqlMapper.update("messages.readMessageDateUpdate", messageNo);
		SqlMapper.update("messages.readMessageisReadUpdate", messageNo);
	}
}
	
