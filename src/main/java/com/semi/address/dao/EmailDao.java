package com.semi.address.dao;
import com.semi.address.vo.Email;
import com.semi.util.SqlMapper;

public class EmailDao {

	public Email getEmailsByBookNo(int bookNo) {
		return (Email) SqlMapper.selectOne("emails.getEmailsByBookNo", bookNo);
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
