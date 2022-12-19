package com.semi.address.dao;

import java.util.List;

import com.semi.address.vo.Address;
import com.semi.util.SqlMapper;

public class AddressDao {

	private static AddressDao instance = new AddressDao();
	private AddressDao() {}
	public static AddressDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Address> getAddressesByBookNo(int bookNo) {
		return (List<Address>) SqlMapper.selectList("addresses.getAddressesByBookNo", bookNo);
	}
	
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
