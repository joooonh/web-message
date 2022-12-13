package com.semi.address.dao;

import java.util.List;

import com.semi.address.dto.AddressDto;
import com.semi.util.SqlMapper;

public class AddressBookDao {
	
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
	 * 직원번호에 해당하는 주소록중 삭제여부가 Y인 주소록 정보를 조회
	 * @param empNo 직원번호
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressDto> getAddressByEmpNoFindY(int empNo) {
		return (List<AddressDto>) SqlMapper.selectList("address.getAddressByEmpNoFindY", empNo);
	}
	
	/**
	 * 주소록번호에 해당하는 주소록 정보를 조회
	 * @param addressBookNo 주소록 번호
	 * @return
	 */
	public AddressDto getAddressByBookNo(int addressBookNo) {
		return (AddressDto) SqlMapper.selectOne("address.getAddressByBookNo", addressBookNo);
	}
	
	/**
	 * 주소록 기본 정보를 업데이트 한다.
	 * @param addressDtp 주소록 정보
	 */
	public void updateAddressBook(AddressDto addressDtp) {
		SqlMapper.update("address.updateAddressBook", addressDtp);
	}
	
	/**
	 * 주소록 주소 정보를 업데이트 한다.
	 * @param addressDtp 주소록 정보
	 */
	public void updateAddress(AddressDto addressDtp) {
		SqlMapper.update("address.updateAddress", addressDtp);
	}
	
	/**
	 * 주소록 연락처 정보를 업데이트 한다.
	 * @param addressDtp 주소록 정보
	 */
	public void updateAddressContact(AddressDto addressDtp) {
		SqlMapper.update("address.updateAddressContact", addressDtp);
	}
	
	/**
	 * 주소록 이메일 정보를 업데이트 한다.
	 * @param addressDtp 주소록 정보
	 */
	public void updateAddressEmail(AddressDto addressDtp) {
		SqlMapper.update("address.updateAddressEmail", addressDtp);
	}
	
	/**
	 * 주소록번호에 해당하는 주소록을 삭제한다.
	 * @param addressBookNo 주소록 번호
	 */
	public void deleteAddress(int addressBookNo) {
		SqlMapper.delete("address.deleteAddress", addressBookNo);
	}
}
