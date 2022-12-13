<%@page import="com.semi.address.dao.ContactDao"%>
<%@page import="com.semi.address.dao.EmailDao"%>
<%@page import="com.semi.address.dao.AddressDao"%>
<%@page import="com.semi.address.vo.Group"%>
<%@page import="com.semi.address.vo.Address"%>
<%@page import="com.semi.address.vo.Email"%>
<%@page import="com.semi.address.vo.Contact"%>
<%@page import="com.semi.address.vo.Book"%>
<%@page import="com.semi.address.dao.BookDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%

/*
	
	** 프로필사진, 중요주소록여부, 기본연락처, 기본이메일, 기본주소여부 추가 필요 
	** 성이름, 그룹번호, 전화번호, 이메일, 주소 - not null 
	
*/

	// Book 객체 
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName"); 
	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));
	String companyName = request.getParameter("companyName");
	String deptName = request.getParameter("deptName");
	String positionName = request.getParameter("positionName");
	String memo = request.getParameter("memo");
	// 프로필사진 추가 
	
	// Contact 객체 
	String[] contactTypeArray = request.getParameterValues("contactType");	
	String[] telArray = request.getParameterValues("tel");					
	
	// Email 객체 																																																								gtff
	String[] emailArray = request.getParameterValues("email");				
	
	// Address 객체 
	String[] addrTypeArray = request.getParameterValues("addrType");
	String[] zipcodeArray = request.getParameterValues("zipcode");
	String[] address1Array = request.getParameterValues("addr1");
	String[] address2Array = request.getParameterValues("addr2");
	
	// BookDao 객체 얻기 
	BookDao bookDao = new BookDao();
	// 주소록 번호 저장
	int bookNo = bookDao.getSequence(); 
	
	// Book 객체 세팅
	Book book = new Book();
	book.setBookNo(bookNo); 
	book.setFirstName(firstName); 
	book.setLastName(lastName);
	book.setGroupNo(groupNo); 
	book.setCompany(companyName);
	book.setDept(deptName);
	book.setPosition(positionName);
	book.setMemo(memo);
 
	bookDao.insertBook(book); 
	
	// 각각 Dao 생성
	AddressDao addressDao = new AddressDao(); 
	EmailDao emailDao = new EmailDao(); 
	ContactDao contactDao = new ContactDao();
		
	// Contact 연락처 넣기 
	for(int i=0; i<contactTypeArray.length; i++){
		Contact contact = new Contact(); 
		contact.setType(contactTypeArray[i]); 
		contact.setTel(telArray[i]); 
		contact.setBookNo(bookNo); 
		
		contactDao.insertContact(contact); 
	}
	
	// 이메일 넣기 
	for(int i=0; i<emailArray.length; i++){
		Email email = new Email(); 
		email.setAddr(emailArray[i]);
		email.setBookNo(bookNo); 
		
		emailDao.insertEmail(email);
	}
	
	// 주소 넣기 
	for(int i=0; i<zipcodeArray.length; i++){
		Address address = new Address(); 
		address.setType(addrTypeArray[i]);
		address.setZipcode(zipcodeArray[i]);
		address.setBasic(address1Array[i]);
		address.setDetail(address2Array[i]);
		address.setBookNo(bookNo); 
		
		addressDao.insertAddress(address);
	}
	
	// 재응답 페이지 
	response.sendRedirect("home.jsp");
%>