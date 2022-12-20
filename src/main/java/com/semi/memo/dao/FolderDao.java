package com.semi.memo.dao;

import com.semi.memo.vo.Folder;
import com.semi.util.SqlMapper;

public class FolderDao {
	
	public Folder getFolderByNo(int folderNo) {
		return (Folder) SqlMapper.selectOne("folders.getFolderByNo", folderNo);
	}
	
	public void updateFolderByNo(int folderNo) {
		SqlMapper.update("folders.updateFolderByNo", folderNo);
	}

}
