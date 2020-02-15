package com.keji09.pdd.controller;

import com.keji09.model.support.XDAOSupport;
import com.keji09.erp.utils.Constants;
import com.pdd.pop.sdk.common.util.JsonUtil;
import com.pdd.pop.sdk.http.PopHttpClient;
import com.pdd.pop.sdk.http.api.request.PddDdkMerchantListGetRequest;
import com.pdd.pop.sdk.http.api.response.PddDdkMerchantListGetResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
@Controller
@RequestMapping("/app_shop")
public class ShopController extends XDAOSupport {
	
	/**
	 * 店铺 https://open.pinduoduo.com/#/apidocument/port?portId=pdd.ddk.merchant.list.get
	 */
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	@ResponseBody
	public Object detail(
			@RequestParam(value = "id") Long id,
			HttpServletRequest req, HttpServletResponse resp
			, ModelMap map) {
		String clientId = Constants.CLIENT_ID;
		String clientSecret = Constants.CLIENT_SECRET;
		try {
			PopHttpClient client = new PopHttpClient(clientId, clientSecret);
			PddDdkMerchantListGetRequest request = new PddDdkMerchantListGetRequest();
			List<Long> mallIdList = new ArrayList<Long>();
			mallIdList.add(id);
			request.setMallIdList(mallIdList);
			PddDdkMerchantListGetResponse response = client.syncInvoke(request);
			return JsonUtil.transferToJson(response);
			//msg+=JsonUtil.transferToJson(response);
		} catch (Exception e) {
		}
		return map;
	}
	
	
}