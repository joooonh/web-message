package com.semi.address.dao;

import com.semi.address.vo.Address;
import com.semi.util.SqlMapper;

public class AddressDao {

	public void insertAddress(Address address) {
		SqlMapper.insert("addresses.insertAddress", address);
	}
	
	public void updateAddress(Address address) {
		SqlMapper.update("addresses.updateAddress", address);
	}
	
	public Address getAddressByBookNo(int bookNo) {
		return (Address) SqlMapper.selectOne("addresses.getAddressByBookNo", bookNo);
	}
	
	public void deleteAddressByBookNo(int bookNo) {
		SqlMapper.delete("addresses.deleteAddressByBookNo", bookNo);
	}
}
