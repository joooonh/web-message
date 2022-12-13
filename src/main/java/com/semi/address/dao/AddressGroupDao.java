package com.semi.address.dao;

import java.util.List;
import java.util.Map;

import com.semi.address.vo.Group;
import com.semi.util.SqlMapper;

public class AddressGroupDao {

	public void insertAddressGroup(Group group) {
		SqlMapper.insert("addressGroups.insertAddressGroup", group);
	}
	
	@SuppressWarnings("unchecked")
	public List<Group> getAddGroupsByEmpNo(int empNo) {
		return (List<Group>)SqlMapper.selectList("addressGroups.getAddGroupsByEmpNo", empNo);
	}
	
	public Group getAddressGroupByNo(int groupNo) {
		return (Group) SqlMapper.selectOne("addressGroups.getAddressGroupByNo", groupNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<Group> getAddressGroups(Map<String, Object> param) {
		return (List<Group>) SqlMapper.selectList("addressGroups.getAddressGroups", param);
	}
}
