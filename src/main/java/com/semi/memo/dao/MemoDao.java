package com.semi.memo.dao;

import java.util.List;
import java.util.Map;

import com.semi.memo.vo.Memo;
import com.semi.util.SqlMapper;

public class MemoDao {
	
	public void insertMemo(Memo memo) {
		SqlMapper.insert("memos.insertMemo", memo);
	}
	
	public void deleteMemoByNo(int memoNo) {
		SqlMapper.delete("memos.deleteMemoByNo", memoNo);
	}
	
	public void updateMemo(Memo memo) {
		SqlMapper.update("memos.updateMemo", memo);
	}
	
	public Memo getMemoByNo(int memoNo) {
		return (Memo) SqlMapper.selectOne("memos.getMemoByNo", memoNo);
	}
	
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("memos.getTotalRows");
	}
	
	@SuppressWarnings("unchecked")
	public List<Memo> selectSemiMemosByEmpNo(int empNo) {
		return (List<Memo>)SqlMapper.selectList("memos.selectSemiMemosByEmpNo", empNo);
	} 
	
	@SuppressWarnings("unchecked")
	public List<Memo> getMemos(Map<String, Object> param) {
		return (List<Memo>) SqlMapper.selectList("memos.getMemos", param);
		
		
	}
}