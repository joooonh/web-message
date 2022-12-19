package com.semi.admin.dao;

import java.util.List;

import com.semi.admin.vo.Department;
import com.semi.util.SqlMapper;

public class DepartmentDao {

	private static DepartmentDao instance = new DepartmentDao();
	private DepartmentDao() {}
	public static DepartmentDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepartments() {
		return (List<Department>) SqlMapper.selectList("departments.getAllDepartments");
	}
}
