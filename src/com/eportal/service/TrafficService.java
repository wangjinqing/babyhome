package com.eportal.service;

import java.util.List;
import com.eportal.ORM.*;

/** ����ͳ��ҵ���߼��ӿ� */
public interface TrafficService {
	/** ͳ��IP���� */
	public int countIP(String hql);
	/** ͳ��PV���� */
	public int countPV(String hql);	
	/** ������ʼ�¼ */
	public List browseTraffic(String hql,int pageNo,int pageSize);	
}
