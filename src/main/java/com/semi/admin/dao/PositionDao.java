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
	
	public void insertPosition(Position position) {
		SqlMapper.insert("positions.insertPosition", position);
	}
	
	public Position getPositionByNo(int positionNo) {
		return (Position) SqlMapper.selectOne("positions.getPositionByNo", positionNo);
	}
	
	public void updatePosition(Position position) {
		SqlMapper.update("positions.updatePosition", position);
	}
}
