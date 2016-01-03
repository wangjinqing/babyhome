package com.eportal.service.impl;

import java.util.List;
import com.eportal.DAO.BaseDAO;
import com.eportal.ORM.News;
import com.eportal.service.NewsService;

/** 新闻管理业务逻辑接口实现 */
public class NewsServiceImpl implements NewsService {
	/** 通过依赖注入DAO组件实例 */
	BaseDAO dao;

	/** 新增或修改新闻 */	
	public boolean saveOrUpdateNews(News News){
		boolean status = false;
		try{
			dao.saveOrUpdate(News);
			status = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return status;
	}

	/** 统计新闻总数 */
	public int countNews() {
		return dao.countAll("News");
	}
	
	/** 浏览新闻 */
	@SuppressWarnings("unchecked")
	public List<News> browseNews(int pageNo,int pageSize){
		return dao.listAll("News",pageNo,pageSize);
	}
	
	/** 删除指定的新闻 */
	public boolean delNews(Integer id){
		boolean status = false;
		try{
			dao.delById(News.class, id);
			status = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return status;
	}

	/** 装载指定的新闻 */
	public News loadNews(Integer id){
		return (News)dao.loadById(News.class, id);
	}	

	public BaseDAO getDao() {
		return dao;
	}

	public void setDao(BaseDAO dao) {
		this.dao = dao;
	}

}
