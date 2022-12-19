package com.semi.admin.dao;

import java.util.List;

import com.semi.admin.vo.Position;
import com.semi.util.SqlMapper;

public class PositionDao {

	private static PositionDao instance = new PositionDao();
	private PositionDao() {}
	public static PositionDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Position> getAllPositions() {
		return (List<Position>) SqlMapper.selectList("positions.getAllPositions");
	}
}
