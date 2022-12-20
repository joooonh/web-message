package com.semi.address.dao;
import java.util.List;

import com.semi.address.vo.Email;
import com.semi.util.SqlMapper;

public class EmailDao {

	private static EmailDao instance = new EmailDao();
	private EmailDao() {}
	public static EmailDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Email> getEmailsByBookNo(int bookNo) {
		return (List<Email>) SqlMapper.selectList("emails.getEmailsByBookNo", bookNo);
	}
	
	public Email getDefaultEmailByBookNo(int bookNo) {
		return (Email) SqlMapper.selectOne("emails.getDefaultEmailByBookNo", bookNo);
	}
	
	public void insertEmail(Email email) {
		SqlMapper.insert("emails.insertEmail", email);
	}
	
	public void updateAddressEmail(Email email) {
		SqlMapper.update("emails.updateAddressEmail", email);
	}
	
	public void deleteByBookNo(int bookNo) {
		SqlMapper.delete("emails.deleteByBookNo", bookNo);
	}
}
