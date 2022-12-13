package com.semi.address.dao;

import com.semi.address.vo.Address;
import com.semi.util.SqlMapper;

public class AddressDao {

	public void insertAddress(Address address) {
		SqlMapper.insert("addresses.insertAddress", address);
	}
}
