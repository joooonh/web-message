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
<%@ include file="../logincheck.jsp" %>
<%

	// Book 객체 
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName"); 
	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));
	String companyName = request.getParameter("companyName");
	String deptName = request.getParameter("deptName");
	String positionName = request.getParameter("positionName");
	String memo = request.getParameter("memo");
	String important = request.getParameter("important"); 
	// 기본연락처로 저장된 행 인덱스의 값
	int contactIndex = StringUtils.stringToInt(request.getParameter("contact-index"));
	int emailIndex = StringUtils.stringToInt(request.getParameter("email-index"));
	int addressIndex = StringUtils.stringToInt(request.getParameter("address-index"));
	
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
	
	// session에서 로그인된 직원번호 조회
	int empNo = loginEmployee.getNo();
	
	// BookDao 객체 얻기 
	BookDao bookDao = BookDao.getInstance();
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
	book.setImportant(important); 
	book.setEmpNo(empNo);
 
	bookDao.insertBook(book); 
	
	// 각각 Dao 생성
	AddressDao addressDao = AddressDao.getInstance(); 
	EmailDao emailDao = EmailDao.getInstance(); 
	ContactDao contactDao = ContactDao.getInstance();
		
	// Contact 연락처 넣기 
	for(int i=0; i<contactTypeArray.length; i++){
		
		if(telArray[i].isBlank()){
			continue;
		}
			
		Contact contact = new Contact(); 
		contact.setType(contactTypeArray[i]); 
		contact.setTel(telArray[i]); 
		contact.setBookNo(bookNo); 
		// 기본연락처 여부
		if(contactIndex == i){
				contact.setDefaultYN("Y");
			} else {
				contact.setDefaultYN("N");
			}
		
		contactDao.insertContact(contact); 
	}
	
	// 이메일 넣기 
	for(int i=0; i<emailArray.length; i++){
		
		if(emailArray[i].isBlank()){
			continue;
		}
		
		Email email = new Email(); 
		email.setAddr(emailArray[i]);
		email.setBookNo(bookNo); 
		// 기본이메일 여부 
		if(emailIndex == i){
			email.setDefaultYN("Y");
		} else {
			email.setDefaultYN("N"); 
		}
		
		emailDao.insertEmail(email);
	}
	
	// 주소 넣기 
	for(int i=0; i<zipcodeArray.length; i++){
		
		if(zipcodeArray[i].isBlank() || address1Array[i].isBlank() || address2Array[i].isBlank()){
			continue;
		}
		
		Address address = new Address(); 
		address.setType(addrTypeArray[i]);
		address.setZipcode(zipcodeArray[i]);
		address.setBasic(address1Array[i]);
		address.setDetail(address2Array[i]);
		address.setBookNo(bookNo); 
		// 기본주소 여부 
		if(addressIndex == i){
			address.setDefaultYN("Y");
		} else {
			address.setDefaultYN("N");
		}
		
		addressDao.insertAddress(address);
	}
	
	// 재응답 페이지 
	response.sendRedirect("home.jsp");
%>