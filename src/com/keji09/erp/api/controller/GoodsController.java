package com.keji09.erp.api.controller;

import com.keji09.erp.api.service.PddService;
import com.keji09.erp.model.DictionaryEntity;
import com.keji09.erp.model.MemberEntity;
import com.keji09.erp.model.OrderEntity;
import com.keji09.erp.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.mezingr.dao.HDaoUtils;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.*;
import com.pdd.pop.sdk.http.api.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * 
 */
@Controller
@RequestMapping("/app_goods")
public class GoodsController extends XDAOSupport {

	@Autowired
	private PopHttpClient client;
	
	@Autowired
	private PddService pddService;

	/**
	 * 商品详情 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.detail
	 */
	@RequestMapping(value="detail",method = RequestMethod.GET)
	@ResponseBody
	public Object getCaptcha(
			@RequestParam(value = "id") Long id,
			ModelMap map) {
		//id = 7440289L;
		//id =86954697838L;
		//resp.addHeader("Access-Control-Allow-Origin", "*");
		try {
			PddDdkGoodsDetailRequest request = new PddDdkGoodsDetailRequest();
			List<Long> goodsIdList = new ArrayList<Long>();
			goodsIdList.add(id);
			//goodsIdList.add(86954697838L);
			request.setGoodsIdList(goodsIdList);
			PddDdkGoodsDetailResponse response = client.syncInvoke(request);
			return  JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		}catch (Exception e){
		}
		return map;
	}

	/**
	 * 获取同类商品 id ,切割
	 */
	@RequestMapping(value="opt",method = RequestMethod.GET)
	@ResponseBody
	public Object getOpt(
			@RequestParam(value = "ids") String ids,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		try {
			PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
			request.setPage(1);
			request.setPageSize(10);
			request.setOptId(Long.valueOf(ids.split(",")[0]));
			request.setWithCoupon(true);
			PddDdkGoodsSearchResponse response = client.syncInvoke(request);
			return  JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		}catch (Exception e){
		}
		return map;
	}

//	/**
//	 * https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.goods.promotion.url.generate
//	 */
//	@RequestMapping(value="generate",method = RequestMethod.GET)
//	@ResponseBody
//	public Object generate(
//			@RequestParam(value = "id") String id,
//			HttpServletRequest req, HttpServletResponse resp
//			, ModelMap map){
//		MemberEntity member = (MemberEntity)req.getSession().getAttribute("member");
//		PddDdkGoodsPromotionUrlGenerateRequest request = new PddDdkGoodsPromotionUrlGenerateRequest();
//		List<Long> goodsIdList = new ArrayList<Long>();
//		goodsIdList.add(Long.valueOf(id));
//		request.setPId(member.getPid());
//		request.setGoodsIdList(goodsIdList);
//		request.setGenerateWeiboappWebview(true);
//		request.setGenerateWeApp(true);
//		request.setGenerateWeiboappWebview(true);
//		request.setGenerateMallCollectCoupon(true);
//		request.setGenerateSchemaUrl(true);
//		request.setGenerateQqApp(true);
//		try{
//			PddDdkGoodsPromotionUrlGenerateResponse response = client.syncInvoke(request);
//			System.out.println( JsonUtil.transferToJson(response));
//			return  JsonUtil.transferToJson(response);
//		}catch (Exception e){
//			e.printStackTrace();
//		}
//		return map;
//	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	@ResponseBody
	public Object search(
			@RequestParam(value = "keyword" , required = false) String keyword, //关键词搜索
			@RequestParam(value = "sortType") Integer sortType, //排序方式
			@RequestParam(value = "catId" , required = false) Long catId, //分类搜索
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {

		PddDdkGoodsSearchRequest request = new PddDdkGoodsSearchRequest();
		request.setPage(pageIndex);
		request.setPageSize(10);
		if(keyword!=null&&!keyword.equals("")){
			request.setKeyword(keyword);
		}
		if(catId!=null){
			request.setCatId(catId);
		}
		request.setSortType(sortType);
		request.setWithCoupon(true);
		PddDdkGoodsSearchResponse response;
		try {
			response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 商品分类 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.goods.cats.get
	 */
	@RequestMapping(value = "cats", method = RequestMethod.GET)
	@ResponseBody
	public Object getCats(
			@RequestParam(value = "id", defaultValue = "0") Long pageIndex,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		PddGoodsCatsGetRequest request = new PddGoodsCatsGetRequest();
		request.setParentCatId(pageIndex);
		try {
			PddGoodsCatsGetResponse response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 运营频道商品
	 */
	@RequestMapping(value = "goods/channel", method = RequestMethod.GET)
	@ResponseBody
	public Object channelGoods(
			@RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "pageSize", defaultValue = "40") Integer pageSize,
			@RequestParam(value = "channelType",defaultValue = "1") Integer channelType, //0, "1.9包邮", 1, "今日爆款", 2, "品牌清仓", 非必填 ,默认是1
			ModelMap map) {
		try {
			PddDdkGoodsRecommendGetResponse response = pddService.channelGoods(channelType,pageIndex,pageSize);
			PddDdkGoodsRecommendGetResponse.GoodsBasicDetailResponse item = response.getGoodsBasicDetailResponse();
			map.put("data", item);
			map.put("errcode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errcode", 500);
			map.put("msg", "连接超时");
		}
		return map;
	}
}