package com.semi.address.dao;

import java.util.List;
import java.util.Map;

import com.semi.address.vo.Book;
import com.semi.util.SqlMapper;

public class BookDao {

	private static BookDao instance = new BookDao();
	private BookDao() {}
	public static BookDao getInstance() {
		return instance;
	}
	
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
	
	public Book getBookByBookNo(int bookNo) {
		return (Book) SqlMapper.selectOne("books.getBookByBookNo", bookNo);
	}
	
	public void insertBook(Book book) {
		SqlMapper.insert("books.insertBook", book);
	}
	
	public void updateImportant(Book book) {
		SqlMapper.update("books.updateImportant", book);
	}

	
}
