package com.eportal.service;

import java.util.List;
import com.eportal.ORM.Merchandise;

/** 商品管理业务逻辑接口 */
public interface MerchandiseService {
	/** 浏览所有商品 */
	public List<Merchandise> browseMerchandise();	
	/** 浏览某页商品 */
	public List<Merchandise> browseMerchandise(int pageNo,int pageSize);
	/** 统计商品总数 */
	public int countMerchandise();		
	/** 装载指定的商品 */	
	public Merchandise loadMerchandise(Integer id);	
	/** 删除指定的商品 */	
	public boolean delMerchandise(Integer id);	
	/** 新增或修改商品 */
	public boolean saveOrUpdateMerchandise(Merchandise merchandise);
}
