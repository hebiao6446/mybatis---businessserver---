package com.business.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.business.entity.Sell;
import com.business.entity.SellProduct;

public interface SellManager {

	List<Sell> findUserSellList(HashMap<String, Object> param);

	Object findUserSellListCount(HashMap<String, Object> param);

	Sell findUserSellInfo(Long sellId);

	List<SellProduct> findSellProductInfo(Long sellId);

	void updateSellInfo(Sell sell, List<SellProduct> sellProductlist);

	void deleteSellData(String sellIdList);

	Date findLastUpdateTime(Sell sell);


}
