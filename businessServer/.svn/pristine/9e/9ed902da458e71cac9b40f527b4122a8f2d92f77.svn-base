package com.business.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.Product;
import com.business.entity.Sell;
import com.business.entity.SellProduct;
import com.business.service.SellManager;

@Service
@Transactional
public class SellManagerImpl implements SellManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@SuppressWarnings("unchecked")
	@Override
	public List<Sell> findUserSellList(HashMap<String, Object> param) {

		return (List<Sell>) sqlSession.selectList("Sell.findUserSellList",
				param);
	}

	@Override
	public Date findLastUpdateTime(Sell sell) {
		return (Date) sqlSession.selectOne("SellVisit.findLastUpdateTime", sell);
	}

	@Override
	public Object findUserSellListCount(HashMap<String, Object> param) {

		return sqlSession.selectOne("Sell.findUserSellListCount", param);
	}

	@Override
	public Sell findUserSellInfo(Long sellId) {
		return (Sell) sqlSession.selectOne("Sell.findUserSellInfo", sellId);

	}

	@Override
	public List<SellProduct> findSellProductInfo(Long sellId) {
		return (List<SellProduct>) sqlSession.selectList(
				"SellProduct.findSellProductInfo", sellId);
	}

	@Override
	public synchronized void updateSellInfo(Sell sell,
			List<SellProduct> sellProductlist) {
		if (sell.getSellId() == null || sell.getSellId() == 0) {
			sqlSession.insert("Sell.insertSellInfo", sell);
			Long sellId = (Long) sqlSession.selectOne("Sell.findIdBySellInfo",
					sell);
			for (SellProduct sp : sellProductlist) {
				sp.setDeleteFlag(1);
				sp.setUpdateTime(new Date());
				sp.setSellId(sellId);
				sqlSession.insert("SellProduct.insertSellProduct", sp);
			}
		} else {
			sqlSession.update("Sell.updateSellInfo", sell);
			sqlSession.delete("SellProduct.deleteSellProduct", sell);
			for (SellProduct sp : sellProductlist) {
				sp.setDeleteFlag(1);
				sp.setUpdateTime(new Date());
				sp.setSellId(sell.getSellId());
				sqlSession.insert("SellProduct.insertSellProduct", sp);
			}
		}
	}

	@Override
	public void deleteSellData(String sellIdList) {
		if (sellIdList != null && !"".equals(sellIdList)) {
			String[] productIdList = sellIdList.split(",");
			for (String pId : productIdList) {
				if (pId != null && !"".equals(pId)) {
					Sell sell = new Sell();
					sell.setSellId(Long.valueOf(pId));
					sell.setDeleteFlag(2);
					sqlSession.update("Sell.updateSellInfo", sell);
				}
			}
		}
	}

}
