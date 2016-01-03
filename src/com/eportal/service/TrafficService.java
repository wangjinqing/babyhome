package com.eportal.service;

import java.util.List;
import com.eportal.ORM.*;

/** 流量统计业务逻辑接口 */
public interface TrafficService {
	/** 统计IP总数 */
	public int countIP(String hql);
	/** 统计PV总数 */
	public int countPV(String hql);	
	/** 浏览访问记录 */
	public List browseTraffic(String hql,int pageNo,int pageSize);	
}
