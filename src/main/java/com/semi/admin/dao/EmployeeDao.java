package com.semi.admin.dao;

import java.util.List;
import java.util.Map;

import com.semi.admin.vo.Employee;
import com.semi.util.Pagination;
import com.semi.util.SqlMapper;

public class EmployeeDao {
	
	@SuppressWarnings("unchecked")
	public List<Employee> getEmployees(Pagination pagination) {
		return (List<Employee>)SqlMapper.selectList("employees.getEmployees", pagination);
	}

	public Employee getEmployeeByNo(int employeeNo) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByNo", employeeNo);
	}
	
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("employees.getTotalRows");
	}
}
