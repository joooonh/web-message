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
	String[] telList = request.getParameterValues("tel");
	int contactIndex = StringUtils.stringToInt(request.getParameter("contact-index"));
	
	// 이메일																																																								gtff
	String[] emailList = request.getParameterValues("emailAddr");
	int emailIndex = StringUtils.stringToInt(request.getParameter("email-index"));
	
	// 주소 
	String[] addrTypeList = request.getParameterValues("addressType");
	String[] zipcodeList = request.getParameterValues("zipcode");
	String[] basicList = request.getParameterValues("basic");
	String[] detailList = request.getParameterValues("detail");
	int addressIndex = StringUtils.stringToInt(request.getParameter("address-index"));

	// AddressBook객체 생성해서 전달받은 값을 저장
	AddressBookDao addressBookDao = AddressBookDao.getInstance();
	AddressBook addressBook = addressBookDao.getAddressBookByBookNo(addressBookNo);
	
	addressBook.setFirstName(firstName);
	addressBook.setLastName(lastName);
	addressBook.setGroupNo(groupNo);
	addressBook.setCompany(companyName);
	addressBook.setDept(deptName);
	addressBook.setPosition(positionName);
	addressBook.setMemo(memo);
	
	addressBookDao.updateAddressBook(addressBook);
	
	// Contact 객체 생성해서 전달받은 값을 저장
	ContactDao contactDao = ContactDao.getInstance();
	// 연락처를 3 -> 2 개로 수정 할 수도 있으니까 아예 주소록번호에 해당하는 연락처를 지운 다음 업데이트한다.
	contactDao.deleteContactByBookNo(addressBookNo);
	for (int i = 0; i < contactTypeList.length; i++) {
		Contact contact = new Contact();
		
		contact.setBookNo(addressBookNo);
		contact.setType(contactTypeList[i]);
		contact.setTel(telList[i]);
		// 기본연락처 여부 확인 -> 파라미터값으로 받아온 contactIndex와 같은 값일때 기본연락처를 'Y'로 설정한다.
		if(contactIndex == i){
				contact.setDefaultYN("Y");
			} else {
				contact.setDefaultYN("N");
			}

		// 연락처를 지웠기 때문에 nullPointException발생(주소록 번호가 없음) -> insert한다.
		contactDao.insertContact(contact);
	}
	
	// Email 객체 생성해서 전달받은 값을 저장
	EmailDao emailDao = EmailDao.getInstance();
	// 이메일을 3 -> 2 개로 수정 할 수도 있으니까 아예 주소록번호에 해당하는 이메일을 지운 다음 업데이트한다.
	emailDao.deleteByBookNo(addressBookNo);
	
	for (int i = 0; i < emailList.length; i++) {
		Email email = new Email();
		email.setBookNo(addressBookNo);
		email.setAddr(emailList[i]);
		// 기본이메일 여부 -> 파라미터값으로 받아온 emailIndex와 같은 값일때 기본연락처를 'Y'로 설정한다.
		if(emailIndex == i){
			email.setDefaultYN("Y");
		} else {
			email.setDefaultYN("N"); 
		}
		
		emailDao.insertEmail(email);
	}

	// Address 객체 생성해서 전달받은 값을 저장
	AddressDao addressDao = AddressDao.getInstance();
	// 주소를 3 -> 2 개로 수정 할 수도 있으니까 아예 주소록번호에 해당하는 주소를 지운 다음 업데이트한다.
	addressDao.deleteAddressByBookNo(addressBookNo);
	for (int i = 0; i < zipcodeList.length; i++) {
		Address address = new Address();
		
		// 배열에 담긴 주소정보를 각각 저장
		address.setBookNo(addressBookNo);
		address.setType(addrTypeList[i]);
		address.setZipcode(zipcodeList[i]);
		address.setBasic(basicList[i]);
		address.setDetail(detailList[i]);
		// 기본주소 여부 -> 파라미터값으로 받아온 addressIndex와 같은 값일때 기본연락처를 'Y'로 설정한다. 
		if(addressIndex == i){
			address.setDefaultYN("Y");
		} else {
			address.setDefaultYN("N");
		}
		
		addressDao.insertAddress(address);
	}
	
	response.sendRedirect("home.jsp");
	
	
%>