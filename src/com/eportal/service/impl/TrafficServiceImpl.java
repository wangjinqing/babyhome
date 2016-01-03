package com.eportal.service.impl;

import java.util.List;
import com.eportal.DAO.BaseDAO;
import com.eportal.service.TrafficService;

/** ����ͳ��ҵ���߼��ӿ�ʵ�� */
public class TrafficServiceImpl implements TrafficService {
	/** ͨ������ע��DAO���ʵ�� */
	BaseDAO dao;
	
	/** ������ʼ�¼ */
	public List browseTraffic(String hql,int pageNo,int pageSize) {
		return dao.query(hql,pageNo,pageSize);
	}

	/** ͳ��IP���� */
	public int countIP(String hql) {
		return dao.countQuery(hql);
	}

	/** ͳ��PV���� */
	public int countPV(String hql) {
		return dao.countQuery(hql);
	}	
	
	public BaseDAO getDao() {
		return dao;
	}

	public void setDao(BaseDAO dao) {
		this.dao = dao;
	}
}
