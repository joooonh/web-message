package com.semi.admin.dao;

import java.util.List;
import java.util.Map;

import com.semi.admin.dto.EmployeeDto;
import com.semi.admin.vo.Employee;
import com.semi.util.SqlMapper;

public class EmployeeDao {
	
	private static EmployeeDao instance = new EmployeeDao();
	private EmployeeDao() {}
	public static EmployeeDao getInstance() {
		return instance;
	}
	
	public void insertEmployee(Employee employee) {
		SqlMapper.insert("employees.insertEmployee", employee);
	}
	
	@SuppressWarnings("unchecked")
	public List<EmployeeDto> getEmployees(Map<String, Object> param) {
		return (List<EmployeeDto>) SqlMapper.selectList("employees.getEmployees", param);
	}
	
	public Employee getEmployeeByEmail(String email) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByEmail", email);
	}
	
//	@SuppressWarnings("unchecked")
//	public List<Employee> getEmployees(Pagination pagination) {
//		return (List<Employee>)SqlMapper.selectList("employees.getEmployees", pagination);
//	}

	public Employee getEmployeeByNo(int empNo) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByNo", empNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<Employee> getAllEmployees() {
		return (List<Employee>) SqlMapper.selectList("employees.getAllEmployees");
	}
	
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("employees.getTotalRows");
	}
	
	public void updateEmployee(Employee employee) {
		SqlMapper.update("employees.updateEmployee", employee);
	}
}
