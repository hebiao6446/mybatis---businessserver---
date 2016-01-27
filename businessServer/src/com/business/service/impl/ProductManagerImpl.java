package com.business.service.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.business.entity.Product;
import com.business.entity.ProductCategory;
import com.business.entity.ProductImg;
import com.business.service.ProductManager;

@Service
@Transactional
public class ProductManagerImpl implements ProductManager {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@SuppressWarnings("unchecked")
	@Override
	public List<ProductCategory> findProductCategory(
			HashMap<String, Object> param) {
		return (List<ProductCategory>) sqlSession.selectList(
				"ProductCategory.findProductCategory", param);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> findProductList(HashMap<String, Object> param) {
		return (List<Product>) sqlSession.selectList("Product.findProductList",
				param);
	}

	@Override
	public Object findProductListCount(HashMap<String, Object> param) {
		return sqlSession.selectOne("Product.findProductListCount", param);
	}

	@Override
	public Product findProductInfo(HashMap<String, Object> param) {
		return (Product) sqlSession.selectOne("Product.findProductInfo", param);
	}

	@Override
	public Long parentCategoryId(Long categoryId) {
		return (Long) sqlSession.selectOne("ProductCategory.parentCategoryId",
				categoryId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProductImg> findProductImg(Long productId) {
		return (List<ProductImg>) sqlSession.selectList(
				"ProductImg.findProductImg", productId);
	}

	@Override
	public synchronized void updateProductInfo(Product p, String addFile,
			String delFile) {
		if (p.getProductId() == null || p.getProductId() == 0) {
			sqlSession.insert("Product.insertProductInfo", p);
			Long productId = (Long) sqlSession.selectOne(
					"Product.findIdByProductInfo", p);
			if (addFile != null && !"".equals(addFile)) {
				String[] imgPathList = addFile.split(",");
				for (String imgPath : imgPathList) {
					if(imgPath==null||"".equals(imgPath)){
						continue;
					}
					ProductImg m = new ProductImg();
					m.setFilePath(imgPath);
					m.setProductId(productId);
					m.setFileType(1);
					sqlSession.insert("ProductImg.insertProductFile", m);
				}
			}
		} else {
			sqlSession.update("Product.updateProductInfo", p);
			if (addFile != null && !"".equals(addFile)) {
				String[] imgPathList = addFile.split(",");
				for (String imgPath : imgPathList) {
					if(imgPath==null||"".equals(imgPath)){
						continue;
					}
					ProductImg m = new ProductImg();
					m.setFilePath(imgPath);
					m.setProductId(p.getProductId());
					m.setFileType(1);
					sqlSession.insert("ProductImg.insertProductFile", m);
				}
			}
			if (delFile != null && !"".equals(delFile)) {
				String[] imgIdList = delFile.split(",");
				for (String imgId : imgIdList) {
					if(imgId==null||"".equals(imgId)){
						continue;
					}					
					ProductImg m = new ProductImg();
					m.setProductImgId(Long.valueOf(imgId));
					sqlSession.delete("ProductImg.deleteProductFile", m);
				}
			}
		}
	}

	@Override
	public void deleteProductData(String productId) {
		if (productId != null && !"".equals(productId)) {
			String[] productIdList = productId.split(",");
			for (String pId : productIdList) {
				if (pId != null && !"".equals(pId)) {
					Product p=new Product();
					p.setProductId(Long.valueOf(pId));
					p.setDeleteFlag(2);					
					sqlSession.update("Product.updateProductInfo", p);
				}
			}
		}
	}

}
