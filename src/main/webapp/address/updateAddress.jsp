<%@page import="com.semi.address.dao.AddressDao"%>
<%@page import="com.semi.address.dao.EmailDao"%>
<%@page import="com.semi.address.dao.ContactDao"%>
<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.address.vo.Address"%>
<%@page import="com.semi.address.vo.AddressBook"%>
<%@page import="com.semi.address.vo.Email"%>
<%@page import="com.semi.address.vo.Contact"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 수정할 주소록의 주소록번호를 저장한다.
	int addressBookNo = Integer.parseInt(request.getParameter("addressBookNo"));
	
	// 주소록 기본 정보 
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName"); 
	int groupNo = StringUtils.stringToInt(request.getParameter("groupNo"));
	String companyName = request.getParameter("company");
	String deptName = request.getParameter("dept");
	String positionName = request.getParameter("position");
	String memo = request.getParameter("memo");
	
	// 전화번호
	String[] contactTypeList = request.getParameterValues("contactType");	
	String[] telList = request.getParameterValues("contactTel");
	//String[] contactDefaultYN = request.getParameterValues("contactDefaultYN");
	
	// 이메일																																																								gtff
	String[] emailList = request.getParameterValues("emailAddr");
	//String emailDefaultYN = request.getParameter("emailDefaultYN");
	
	// 주소 
	String[] addrTypeList = request.getParameterValues("addressType");
	String[] zipcodeList = request.getParameterValues("zipcode");
	String[] basicList = request.getParameterValues("basic");
	String[] detailList = request.getParameterValues("detail");

	AddressBookDao addressBookDao = new AddressBookDao();
	// AddressBook객체 생성해서 전달받은 값을 저장
	AddressBook addressBook = addressBookDao.getAddressBookByBookNo(addressBookNo);
	
	addressBook.setFirstName(firstName);
	addressBook.setLastName(lastName);
	addressBook.setGroupNo(groupNo);
	addressBook.setCompany(companyName);
	addressBook.setDept(deptName);
	addressBook.setPosition(positionName);
	addressBook.setMemo(memo);
	
	addressBookDao.updateAddressBook(addressBook);
	
	ContactDao contactDao = ContactDao.getInstance();
	contactDao.deleteContactByBookNo(addressBookNo);
	// Contact 객체 생성해서 전달받은 값을 저장
	for (int i = 0; i < telList.length; i++) {
		Contact contact = new Contact();
		
		contact.setBookNo(addressBookNo);
		contact.setType(contactTypeList[i]);
		contact.setTel(telList[i]);
		//contact.setDefaultYN(contactDefaultYN[i]);
		
		// 연락처를 지웠기 때문에 nullPointException발생(주소록 번호가 없음) -> insert한다.
		contactDao.insertContact(contact);
	}
	
	EmailDao emailDao = EmailDao.getInstance();
	// Email 객체 생성해서 전달받은 값을 저장
	emailDao.deleteByBookNo(addressBookNo);
	
	for (int i = 0; i < emailList.length; i++) {
		Email email = new Email();
		email.setBookNo(addressBookNo);
		email.setAddr(emailList[i]);
		//email.setDefaultYN(emailDefaultYN[i]);
		
		emailDao.insertEmail(email);
	}

	AddressDao addressDao = AddressDao.getInstance();
	addressDao.deleteAddressByBookNo(addressBookNo);
	// Address 객체 생성해서 전달받은 값을 저장
	for (int i = 0; i < zipcodeList.length; i++) {
		Address address = new Address();
		
		// 주소를 3 -> 2 개로 수정 할 수도 있으니까 아예 주소록번호에 해당하는 주소를 지운 다음 업데이트한다.
		// 주소록번호에 해당하는 주소를 지운다.
		
		// 배열에 담긴 주소정보를 각각 저장
		address.setBookNo(addressBookNo);
		address.setType(addrTypeList[i]);
		address.setZipcode(zipcodeList[i]);
		address.setBasic(basicList[i]);
		address.setDetail(detailList[i]);
		
		addressDao.insertAddress(address);
	}
	
	response.sendRedirect("home.jsp");
	
	
%>