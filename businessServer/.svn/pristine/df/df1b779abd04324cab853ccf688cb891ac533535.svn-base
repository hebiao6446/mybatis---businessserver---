package com.business.service;

import java.util.HashMap;
import java.util.List;

import com.business.entity.Product;
import com.business.entity.ProductCategory;
import com.business.entity.ProductImg;

public interface ProductManager {

	List<ProductCategory> findProductCategory(HashMap<String, Object> param);

	List<Product> findProductList(HashMap<String, Object> param);

	Object findProductListCount(HashMap<String, Object> param);

	Product findProductInfo(HashMap<String, Object> param);

	Long parentCategoryId(Long categoryId);

	List<ProductImg> findProductImg(Long productId);

	void updateProductInfo(Product p, String addFile, String delFile);

	void deleteProductData(String productId);
	
	
}
