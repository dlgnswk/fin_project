package com.spring.app.ch.tripboard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.app.ch.tripboard.model.TripboardDAO;
import com.spring.app.common.FileManager;
import com.spring.app.expedia.domain.TripboardVO;

//==== Service 선언 ====
@Service
public class TripboardService_imple implements TripboardService {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private TripboardDAO dao;
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
 	private FileManager fileManager;
	
	@Override
	public int add(TripboardVO tripboardvo) {
		
		int n = dao.add(tripboardvo); // 첨부파일 없는 경우
		
		return n;
	}

	@Override
	public int add_withFile(TripboardVO tripboardvo) {
		int n = dao.add_withFile(tripboardvo); // 첨부파일이 있는 경우
		
		return n;
	}
	
	
	 // 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<TripboardVO> tripboardListSearch_withPaging(Map<String, String> paraMap) {
		List<TripboardVO> tripboardList = dao.tripboardListSearch_withPaging(paraMap);
		return tripboardList;
	}
		
	
	// 글조회수 증가와 함께 글1개를 조회를 해주는 것
	@Override
	public TripboardVO getView(Map<String, String> paraMap) {
		
		TripboardVO tripboardvo = dao.getView(paraMap); // 글1개 조회하기
		String login_userid = paraMap.get("login_userid");
		
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		if(login_userid != null &&
				tripboardvo != null &&
		  !login_userid.equals(tripboardvo.getFk_userid()) ) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다. 
			
			int n = dao.increase_readCount(tripboardvo.getTb_seq()); // 글조회수 1증가 하기 
			if(n==1) {
				tripboardvo.setTb_readCount(String.valueOf(Integer.parseInt(tripboardvo.getTb_readCount())+1) );
			}
		}
		
		return tripboardvo;
	}
	
	// 글조회수 증가는 없고 단순히 글1개만 조회를 해주는 것
	@Override
	public TripboardVO getView_no_increase_readCount(Map<String, String> paraMap) {
		TripboardVO tripboardvo = dao.getView(paraMap); // 글1개 조회하기
		return tripboardvo;
	}
	
	
	// 글 수정하기
	@Override
	public int tbedit(TripboardVO tripboardvo) {
		
		int n = dao.tbedit(tripboardvo);
		
		return n;
	}
	
	// 1개글 삭제하기
	@Override
	public int tbdel(Map<String, String> paraMap) {
		
		int n = dao.tb_del(paraMap);
		
		// === #165. 파일 첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작  === //
		if(n==1) {
			String path = paraMap.get("path");
			String tb_fileName = paraMap.get("tb_fileName");
			
			if( tb_fileName != null && !"".equals(tb_fileName) ) {
				try {
				fileManager.doFileDelete(tb_fileName, path);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		// === #165. 파일 첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝  === //
		
		return n;
	}
	
	// 좋아요 버튼을 눌렀을 때 insert 해주는 것
	@Override
	public int likeAdd(Map<String, String> paraMap) {
		
		int n = dao.getLike(paraMap);
		return n;
	}

	// 좋아요 지워주는 것
	@Override
	public int likeDelete(Map<String, String> paraMap) {
		int n = dao.deleteLike(paraMap);
		return n;
	}

	// 좋아요 개수
	@Override
	public Map<String, Integer> getCnt(String tb_seq) {
		Map<String, Integer> map = dao.getCnt(tb_seq);
		return map;
	}
	
}
