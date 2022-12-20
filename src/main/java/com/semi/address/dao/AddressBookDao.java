package com.semi.address.dao;

import java.util.List;
import java.util.Map;

import com.semi.address.dto.AddressDto;
import com.semi.address.vo.AddressBook;
import com.semi.util.SqlMapper;

public class AddressBookDao {
	
	/**
	 * 직원번호에 해당하는 주소록중 삭제여부가 Y인 주소록 정보를 조회
	 * @param empNo 직원번호
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressDto> getAddressByEmpNoFindYList(Map<String, Object> param) {
		return (List<AddressDto>) SqlMapper.selectList("address.getAddressByEmpNoFindYList", param);
	}
	
	/**
	 * 주소록 번호에 해당하는 AddressBook 객체 조회
	 * @param addressBookNo 주소록 번호
	 * @return
	 */
	public AddressBook getAddressBookByBookNo(int addressBookNo) {
		return (AddressBook) SqlMapper.selectOne("address.getAddressBookByBookNo", addressBookNo);
	}
	
	/**
	 * 직원번호에 해당하는 주소록중 삭제여부가 'Y'인 주소록의 갯수
	 * @param empNo 직원 번호
	 * @return
	 */
	public Integer totalRowsY(int empNo) {
		return (Integer) SqlMapper.selectOne("address.totalRowsY", empNo);
	}
	
	/**
	 * 직원번호에 해당하는 주소록 정보를 조회
	 * @param empNo 직원번호
	 * @return
	 */
	@SuppressWarnings("unchecked") // 수정
	public List<AddressBook> getAddressBookByEmpNo(int empNo) {
		return (List<AddressBook>) SqlMapper.selectList("address.getAddressBookByEmpNo", empNo);
	}
	
	/**
	 * 주소록 기본 정보를 업데이트 한다.
	 * @param addressBook 주소록 기본 정보
	 */
	public void updateAddressBook(AddressBook addressBook) {
		SqlMapper.update("address.updateAddressBook", addressBook);
	}
	
	public void deleteAddress(int addressBookNo) {
		SqlMapper.delete("address.deleteAddress", addressBookNo);
	}
}
