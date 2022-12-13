package com.semi.memo.dao;

import java.util.List;

import com.semi.memo.vo.Memo;
import com.semi.util.SqlMapper;

public class MemoDao {
	
	public void insertMemo(Memo memo) {
		SqlMapper.insert("memos.insertMemo", memo);
	}
	
	public void deleteMemoByNo(int memoNo) {
		SqlMapper.delete("memos.deleteMemoByNo", memoNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<Memo> selectSemiMemosByEmpNo(int empNo) {
		return (List<Memo>)SqlMapper.selectList("memos.selectSemiMemosByEmpNo", empNo);
	} 
}