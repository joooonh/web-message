package com.semi.address.dao;

import java.util.List;
import java.util.Map;

import com.semi.address.vo.Book;
import com.semi.util.SqlMapper;

public class BookDao {

	public int getSequence() {
		return (Integer) SqlMapper.selectOne("books.getSequence");
	}
	
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("books.getTotalRows");
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooks(Map<String, Object> param) {
		return (List<Book>) SqlMapper.selectList("books.getBooks", param);
	}
	
	public void insertBook(Book book) {
		SqlMapper.insert("books.insertBook", book);
	}
	

	
}
