package com.semi.address.dao;

import java.util.List;

import com.semi.address.vo.Contact;
import com.semi.util.SqlMapper;

public class ContactDao {
	
	@SuppressWarnings("unchecked")
	public List<Contact> getContactsByBookNo(int bookNo) {
		return (List<Contact>) SqlMapper.selectList("contacts.getContactsByBookNo", bookNo);
	}
	
	public Contact getDefaultContactByBookNo(int bookNo) {
		return (Contact) SqlMapper.selectOne("contacts.getDefaultContactByBookNo", bookNo);
	}
	
	public void insertContact(Contact contact) {
		SqlMapper.insert("contacts.insertContact", contact);
	}
	
}
