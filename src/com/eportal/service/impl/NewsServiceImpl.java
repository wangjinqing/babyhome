package com.eportal.service.impl;

import java.util.List;
import com.eportal.DAO.BaseDAO;
import com.eportal.ORM.News;
import com.eportal.service.NewsService;

/** ���Ź���ҵ���߼��ӿ�ʵ�� */
public class NewsServiceImpl implements NewsService {
	/** ͨ������ע��DAO���ʵ�� */
	BaseDAO dao;

	/** �������޸����� */	
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

	/** ͳ���������� */
	public int countNews() {
		return dao.countAll("News");
	}
	
	/** ������� */
	@SuppressWarnings("unchecked")
	public List<News> browseNews(int pageNo,int pageSize){
		return dao.listAll("News",pageNo,pageSize);
	}
	
	/** ɾ��ָ�������� */
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

	/** װ��ָ�������� */
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
