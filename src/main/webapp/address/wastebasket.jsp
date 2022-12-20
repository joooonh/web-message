<%@page import="com.semi.util.StringUtils"%>
<%@page import="com.semi.util.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.semi.address.dto.AddressDto"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.address.dao.AddressBookDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 직원번호를 저장한다.
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	// 페이지 번호를 저장한다.
	String pageNo = request.getParameter("pageNo");
	
	AddressBookDao addressBookDao = AddressBookDao.getInstance();
	
	// 휴지통 페이징 처리에 필요한 정보	
	int currentPage = StringUtils.stringToInt(pageNo, 1);
	int totalRows = addressBookDao.totalRowsY(empNo);
	Pagination paging = new Pagination(currentPage, totalRows);
	int begin = paging.getBegin();
	int end = paging.getEnd();
	int totalPages = paging.getTotalPages();
	int totalBlocks = paging.getTotalBlocks();
	int currentPageBlock = paging.getCurrentPageBlock();
	int beginPage = paging.getBeginPage();
	int endPage = paging.getEndPage();
	boolean isFirst = paging.isFirst();
	boolean isLast = paging.isLast();
	int prevPage = paging.getPrevPage();
	int nextPage = paging.getNextPage();
	
	Map<String, Object> param = new HashMap<>();
	param.put("empNo", empNo);
	param.put("begin", paging.getBegin());
	param.put("end", paging.getEnd());
	
	// 직원번호로 삭제여부가 'Y'인 게시글을 addressBookList에 담는다.
	List<AddressDto> addressList = addressBookDao.getAddressByEmpNoFindYList(param);
	
	Map<String, Object> resultMap = new HashMap<>();
	resultMap.put("addressList", addressList);
	resultMap.put("paging", paging);
	resultMap.put("begin", begin);
	resultMap.put("end", end);
	resultMap.put("totalPages", totalPages);
	resultMap.put("totalBlocks", totalBlocks);
	resultMap.put("currentPageBlock", currentPageBlock);
	resultMap.put("beginPage", beginPage);
	resultMap.put("endPage", endPage);
	resultMap.put("isFirst", isFirst);
	resultMap.put("isLast", isLast);
	resultMap.put("prevPage", prevPage);
	resultMap.put("nextPage", nextPage);
	
	Gson gson = new GsonBuilder().serializeNulls().setDateFormat("yyyy년 M월 d일").create();
	String json = gson.toJson(resultMap);
	
	out.write(json);
%>