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
	
	public int getTotalRows(int empNo) {
		return (Integer) SqlMapper.selectOne("books.getTotalRows", empNo);
	}
	
	public int getTotalImportantRows(int empNo) {
		return (Integer) SqlMapper.selectOne("books.getTotalImportantRows", empNo);
	}
	
	public int getTotalRowsByGroupNo(Map<String, Object> map) {
		return (Integer) SqlMapper.selectOne("books.getTotalRowsByGroupNo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooks(Map<String, Object> param) {
		return (List<Book>) SqlMapper.selectList("books.getBooks", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooksByGroupNo(Map<String, Object> param){
		return (List<Book>) SqlMapper.selectList("books.getBooksByGroupNo", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getImportantBooks(Map<String, Object> param){
		return (List<Book>) SqlMapper.selectList("books.getImportantBooks", param); 
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooksOrderbyRecentDate(Map<String, Object> param) {
		return (List<Book>) SqlMapper.selectList("books.getBooksOrderbyRecentDate", param);
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
