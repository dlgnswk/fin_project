package com.spring.app.jy.lodge.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.jy.lodge.model.LodgeDAO;
import com.spring.app.jy.lodge.model.LodgeDAO_imple;

@Service
public class LodgeService_imple implements LodgeService {
	
	@Autowired
	private LodgeDAO dao = new LodgeDAO_imple();

	@Override
	public Map<String, String> getLodgeInfo(String lodge_id) {
		Map<String, String> lodgeInfoMap = dao.getLodgeInfo(lodge_id);
		return lodgeInfoMap;
	}

	@Override
	public List<Map<String, String>> getInet_opt_list(String lodge_id) {
		List<Map<String, String>> Inet_opt_list = dao.getInet_opt_list(lodge_id);
		return Inet_opt_list;
	}

	@Override
	public List<Map<String, String>> getPark_opt_list(String lodge_id) {
		List<Map<String, String>> Park_opt_list = dao.getPark_opt_list(lodge_id);
		return Park_opt_list;
	}

	@Override
	public List<Map<String, String>> getDin_opt_list(String lodge_id) {
		List<Map<String, String>> Din_opt_list = dao.getDin_opt_list(lodge_id);
		return Din_opt_list;
	}
	

	@Override
	public List<Map<String, String>> getPool_opt_list(String lodge_id) {
		List<Map<String, String>> Pool_opt_list = dao.getPool_opt_list(lodge_id);
		return Pool_opt_list;
	}

	@Override
	public List<Map<String, String>> getFac_opt_list(String lodge_id) {
		List<Map<String, String>> Fac_opt_list = dao.getFac_opt_list(lodge_id);
		return Fac_opt_list;
	}

	@Override
	public List<Map<String, String>> getCs_opt_list(String lodge_id) {
		List<Map<String, String>> Cs_opt_list = dao.getCs_opt_list(lodge_id);
		return Cs_opt_list;
	}

	@Override
	public List<Map<String, String>> getRmsvc_opt_list(String lodge_id) {
		List<Map<String, String>> Rmsvc_opt_list = dao.getRmsvc_opt_list(lodge_id);
		return Rmsvc_opt_list;
	}

	@Override
	public List<Map<String, String>> getBsns_opt_list(String lodge_id) {
		List<Map<String, String>> Bsns_opt_list = dao.getBsns_opt_list(lodge_id);
		return Bsns_opt_list;
	}

	@Override
	public List<Map<String, String>> getFasvc_opt_list(String lodge_id) {
		List<Map<String, String>> Fasvc_opt_list = dao.getFasvc_opt_list(lodge_id);
		return Fasvc_opt_list;
	}

	@Override
	public List<Map<String, String>> getLg_img_list(Map<String, String> i_paraMap) {
		List<Map<String, String>> Lg_img_list = dao.getLg_img_list(i_paraMap);
		return Lg_img_list;
	}


	@Override
	public List<Map<String, String>> getCom_bath_opt_list(String lodge_id) {
		List<Map<String, String>> Com_bath_opt_list = dao.getCom_bath_opt_list(lodge_id);
		return Com_bath_opt_list;
	}

	@Override
	public List<Map<String, String>> getCom_snk_opt_list(String lodge_id) {
		List<Map<String, String>> Com_snk_opt_list = dao.getCom_snk_opt_list(lodge_id);
		return Com_snk_opt_list;
	}

	@Override
	public List<Map<String, String>> getCom_kt_opt_list(String lodge_id) {
		List<Map<String, String>> Com_kt_opt_list = dao.getCom_kt_opt_list(lodge_id);
		return Com_kt_opt_list;
	}

	@Override
	public List<Map<String, String>> getCom_ent_opt_list(String lodge_id) {
		List<Map<String, String>> Com_ent_opt_list = dao.getCom_ent_opt_list(lodge_id);
		return Com_ent_opt_list;
	}

	@Override
	public List<Map<String, String>> getCom_tmp_opt_list(String lodge_id) {
		List<Map<String, String>> Com_tmp_opt_list = dao.getCom_tmp_opt_list(lodge_id);
		return Com_tmp_opt_list;
	}

	@Override
	public List<Map<String, String>> getAvbl_rm_list(Map<String, String> paraMap) {
		List<Map<String, String>> Avbl_rm_list = dao.getAvbl_rm_list(paraMap);
		return Avbl_rm_list;
	}

	@Override
	public List<Map<String, String>> getBath_opt_list(String rm_seq) {
		List<Map<String, String>> Bath_opt_list = dao.getBath_opt_list(rm_seq);
		return Bath_opt_list;
	}

	@Override
	public List<Map<String, String>> getSnk_opt_list(String rm_seq) {
		List<Map<String, String>> Snk_opt_list = dao.getSnk_opt_list(rm_seq);
		return Snk_opt_list;
	}

	@Override
	public List<Map<String, String>> getKt_opt_list(String rm_seq) {
		List<Map<String, String>> Kt_opt_list = dao.getKt_opt_list(rm_seq);
		return Kt_opt_list;
	}

	@Override
	public List<Map<String, String>> getEnt_opt_list(String rm_seq) {
		List<Map<String, String>> Ent_opt_list = dao.getEnt_opt_list(rm_seq);
		return Ent_opt_list;
	}

	@Override
	public List<Map<String, String>> getTmp_opt_list(String rm_seq) {
		List<Map<String, String>> Tmp_opt_list = dao.getTmp_opt_list(rm_seq);
		return Tmp_opt_list;
	}

	@Override
	public List<Map<String, String>> getRm_img_list(Map<String, String> paraMap) {
		List<Map<String, String>> Rm_img_list = dao.getRm_img_list(paraMap);
		return Rm_img_list;
	}

	@Override
	public List<Map<String, String>> getLg_img_ca_list(String lodge_id) {
		List<Map<String, String>> Lg_img_ca_list = dao.getLg_img_ca_list(lodge_id);
		return Lg_img_ca_list;
	}


	@Override
	public String getLg_ca_name(String img_cano) {
		String Lg_ca_name = dao.getLg_ca_name(img_cano);
		return Lg_ca_name;
	}

	@Override
	public boolean isExist_wish(Map<String, String> paraMap) {
		boolean isExist_wish = dao.isExist_wish(paraMap);
		return isExist_wish;
	}

	@Override
	public int delete_wishList(Map<String, String> paraMap) {
		int delete_wishList = dao.delete_wishList(paraMap);
		return delete_wishList;
	}

	@Override
	public int add_wishList(Map<String, String> paraMap) {
		int add_wishList = dao.add_wishList(paraMap);
		return add_wishList;
	}

}
