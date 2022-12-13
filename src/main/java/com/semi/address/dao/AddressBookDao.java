package com.semi.address.dao;

import java.util.List;
import java.util.Map;

import com.semi.address.dto.AddressDto;
import com.semi.address.vo.Address;
import com.semi.address.vo.AddressBook;
import com.semi.address.vo.Contact;
import com.semi.address.vo.Email;
import com.semi.util.SqlMapper;

public class AddressBookDao {
	
	/**
	 * 직원번호에 해당하는 주소록중 삭제여부가 Y인 주소록 정보를 조회
	 * @param param map객체
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressDto> getAddressByEmpNoFindY(Map<String, Object> param) {
		return (List<AddressDto>) SqlMapper.selectList("address.getAddressByEmpNoFindY", param);
	}
	
	/**
	 * 직원번호에 해당하는 주소록중 삭제여부가 Y인 주소록 정보를 조회
	 * @param empNo 직원번호
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressDto> getAddressByEmpNoFindYList(int empNo) {
		return (List<AddressDto>) SqlMapper.selectList("address.getAddressByEmpNoFindYList", empNo);
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
	public Integer totalRows(int empNo) {
		return (Integer) SqlMapper.selectOne("address.totalRows", empNo);
	}
	
	/**
	 * 직원번호에 해당하는 주소록 정보를 조회
	 * @param empNo 직원번호
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressDto> getAddressByEmpNo(int empNo) {
		return (List<AddressDto>) SqlMapper.selectList("address.getAddressByEmpNo", empNo);
	}
	
	/**
	 * 주소록번호에 해당하는 주소록 정보를 조회
	 * @param addressBookNo 주소록 번호
	 * @return
	 */
	public Object getAddressByBookNo(int addressBookNo) {
		return (Object) SqlMapper.selectOne("address.getAddressByBookNo", addressBookNo);
	}
	
	/**
	 * 주소록 기본 정보를 업데이트 한다.
	 * @param addressBook 주소록 기본 정보
	 */
	public void updateAddressBook(AddressBook addressBook) {
		SqlMapper.update("address.updateAddressBook", addressBook);
	}
	
	/**
	 * 주소록 주소 정보를 업데이트 한다.
	 * @param address 주소록 주소 정보
	 */
	public void updateAddress(Address address) {
		SqlMapper.update("address.updateAddress", address);
	}
	
	/**
	 * 주소록 연락처 정보를 업데이트 한다.
	 * @param contact 주소록 연락처 정보
	 */
	public void updateAddressContact(Contact contact) {
		SqlMapper.update("address.updateAddressContact", contact);
	}
	
	/**
	 * 주소록 이메일 정보를 업데이트 한다.
	 * @param email 주소록 이메일 정보
	 */
	public void updateAddressEmail(Email email) {
		SqlMapper.update("address.updateAddressEmail", email);
	}
	
	/**
	 * 주소록번호에 해당하는 주소록을 삭제한다.
	 * @param addressBookNo 주소록 번호
	 */
	public void deleteAddress(int addressBookNo) {
		SqlMapper.delete("address.deleteAddress", addressBookNo);
	}
}
