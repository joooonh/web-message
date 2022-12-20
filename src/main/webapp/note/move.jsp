<%@page import="com.semi.memo.vo.Memo"%>
<%@page import="com.semi.memo.vo.Folder"%>
<%@page import="com.semi.memo.dao.MemoDao"%>
<%@page import="com.semi.memo.dao.FolderDao"%>
<%@page import="com.semi.admin.vo.Employee"%>
<%@page import="com.semi.admin.dao.EmployeeDao"%>

<%@page import="com.semi.util.StringUtils"%>
<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
   
   <% 
    int empNo = 1006;
   //int empNo = loginEmployee.getNo();
    int memoNo = Integer.parseInt(request.getParameter("memoNo"));
	int folderNo = Integer.parseInt(request.getParameter("folderNo"));

	MemoDao memoDao = new MemoDao();
	Memo memo = memoDao.getMemoByNo(memoNo);
	memo.setFolderNo(folderNo);

	memoDao.updateMemo(memo);

	out.write("success");
   %>