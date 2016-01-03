package com.eportal.service.impl;

import java.util.List;
import com.eportal.DAO.BaseDAO;
import com.eportal.ORM.Merchandise;
import com.eportal.service.MerchandiseService;

/** 商品管理业务逻辑接口实现 */
public class MerchandiseServiceImpl implements MerchandiseService {
	/** 通过依赖注入DAO组件实例 */
	BaseDAO dao;

	/** 新增或修改商品 */	
	public boolean saveOrUpdateMerchandise(Merchandise Merchandise){
		boolean status = false;
		try{
			dao.saveOrUpdate(Merchandise);
			status = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return status;
	}

	/** 浏览所有商品 */
	@SuppressWarnings("unchecked")
	public List<Merchandise> browseMerchandise(){
		return dao.listAll("Merchandise");
	}
	
	/** 浏览某页商品 */
	@SuppressWarnings("unchecked")
	public List<Merchandise> browseMerchandise(int pageNo,int pageSize){
		return dao.listAll("Merchandise",pageNo,pageSize);
	}	
	
	/** 统计商品总数 */
	public int countMerchandise() {
		return dao.countAll("Merchandise");
	}	
	
	/** 删除指定的商品 */
	public boolean delMerchandise(Integer id){
		boolean status = false;
		try{
			dao.delById(Merchandise.class, id);
			status = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return status;
	}

	/** 装载指定的商品 */
	public Merchandise loadMerchandise(Integer id){
		return (Merchandise)dao.loadById(Merchandise.class, id);
	}	

	public BaseDAO getDao() {
		return dao;
	}

	public void setDao(BaseDAO dao) {
		this.dao = dao;
	}
}
