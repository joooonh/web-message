package com.semi.address.dao;
import com.semi.address.vo.Email;
import com.semi.util.SqlMapper;

public class EmailDao {

	public Email getEmailsByBookNo(int bookNo) {
		return (Email) SqlMapper.selectOne("emails.getEmailsByBookNo", bookNo);
	}
	
	public void insertEmail(Email email) {
		SqlMapper.insert("emails.insertEmail", email);
	}
}
