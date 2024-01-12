package com.spring.app.ch.tripboard.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.spring.app.ch.tripboard.service.TripboardService;
import com.spring.app.common.*;
import com.spring.app.expedia.domain.TripboardVO;
import com.spring.app.expedia.domain.UserVO;

@Controller
public class TripboardController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private TripboardService service;
	
	// === #155. 파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
		
		
	// === 여행후기 게시판 글목록 페이지 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tblist.exp") 
	public ModelAndView tripboard(ModelAndView mav, HttpServletRequest request) {
		
		List<TripboardVO> tripboardList = null;
		
		// === 글조회수(td_readCount)증가 (DML문 update)는
		//          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		//          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		//          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.
		HttpSession session = request.getSession();
		session.setAttribute("td_readCountPermission", "yes");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		// System.out.println("~~ 확인용 searchType : " + searchType);
		// ~~ 확인용 searchType : null
		// ~~ 확인용 searchType : subject
		// ~~ 확인용 searchType : content
		// ~~ 확인용 searchType : subject_content
		// ~~ 확인용 searchType : name

		// System.out.println("~~ 확인용 searchWord : " + searchWord);

		// System.out.println("~~ 확인용 str_currentShowPageNo : " +
		// str_currentShowPageNo);
		// ~~ 확인용 str_currentShowPageNo : null

		if (searchType == null) {
			searchType = "";
		}

		if (searchWord == null) {
			searchWord = "";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
			// " 입니다 " ==> "입니다"
			// " " ==> ""
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		// boardList = service.boardListSearch(paraMap); // 글목록 가져오기(페이징 처리 안했으며, 검색어가
		// 없는 것 또는 검색어가 있는것 모두 포함한 것)

		// 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)

		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
		// System.out.println("~~~~ 확인용 totalCount : " + totalCount);
		// ~~~~ 확인용 totalCount : 214
		// ~~~~ 확인용 totalCount : 4
		// ~~~~ 확인용 totalCount : 2
		// ~~~~ 확인용 totalCount : 6
		// ~~~~ 확인용 totalCount : 3

		// 만약에 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 한다.
		// 만약에 총 게시물 건수(totalCount)가 120 개 이라면 총 페이지수(totalPage)는 12 페이지가 되어야 한다.
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);
		// (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> 12

		if (str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면

			currentShowPageNo = 1;
		}

		else {

			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 음수를 입력하여 장난친 경우
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을
					// 입력하여 장난친 경우
					currentShowPageNo = 1;
				}

			} catch (NumberFormatException e) {
				// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
				currentShowPageNo = 1;
			}
		}

		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
		/*
		 * currentShowPageNo startRno endRno
		 * -------------------------------------------- 1 page ===> 1 10 2 page ===> 11
		 * 20 3 page ===> 21 30 4 page ===> 31 40 ...... ... ...
		 */
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		tripboardList = service.tripboardListSearch_withPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)

		
		
		mav.addObject("tripboardList", tripboardList);

		if ("tb_city".equals(searchType) || "tb_subject".equals(searchType) || "tb_content".equals(searchType) || "tb_subject_content".equals(searchType)
				|| "tb_name".equals(searchType)) {
			mav.addObject("paraMap", paraMap);
		}

		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
		 * 1 2 3 4 5 6 7 8 9 10 [다음][마지막] -- 1개블럭 [맨처음][이전] 11 12 13 14 15 16 17 18 19
		 * 20 [다음][마지막] -- 1개블럭 [맨처음][이전] 21 22 23
		 */

		int loop = 1;
		/*
		 * loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */

		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

		String pageBar = "<ul style='list-style:none;'>";
		String url = "tblist.exp";

		// === [맨처음][이전] 만들기 === //
		if (pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + (pageNo - 1)
					+ "'>[이전]</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"
						+ pageNo + "</li>";
			} else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url
						+ "?searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo
						+ "'>" + pageNo + "</a></li>";
			}

			loop++;
			pageNo++;
		} // end of while-------------------------

		// === [다음][마지막] 만들기 === //
		if (pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo + "'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + totalPage + "'>[마지막]</a></li>";
		}

		pageBar += "</ul>";

		mav.addObject("pageBar", pageBar);
		// System.out.println(pageBar);

		// 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		// 사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		// 현재 페이지 주소를 뷰단으로 넘겨준다.
		String goBackURL = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용(list.action) goBackURL : " + goBackURL);
		

		mav.addObject("goBackURL", goBackURL);

		mav.setViewName("ch/tripboard/tblist.tiles1");

		return mav;
	}	
	
	// === 여행후기 게시판 글쓰기 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tbadd.exp") 
	public ModelAndView requiredLogin_tbadd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		
		mav.setViewName("ch/tripboard/tbadd.tiles1");
		
		return mav;
	}
	
	// === 여행후기 게시판 글쓰기 완료 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@PostMapping("/tbaddEnd.exp") 
	public ModelAndView tbaddEnd(Map<String, String> paraMap, ModelAndView mav, TripboardVO tripboardvo, MultipartHttpServletRequest mrequest) {
		
		// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지, 아니면 파일첨부가 안된 것인지 구분을 지어주어야 한다. === //
		// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! === 
			MultipartFile attach = tripboardvo.getAttach();
			
			if(attach != null) { // !!! 첨부파일이 있다면 !!!
				// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
				/*
		            1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
		            >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		                          우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
		                          조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	            */
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/"); // 최상위 루트가 어딘지 알아온다.
				
			//	System.out.println("~~~ 확인용 webapp의 절대경로 => " + root);
			    // ~~~ 확인용 webapp의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			               운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			               운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
	            */
				// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//	System.out.println("~~~ 확인용 webapp의 절대경로 => " + path);
			    //~~~ 확인용 webapp의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files
				
				/*
					2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일 올리기				
				*/
				String newFileName = "";
				// WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것. (리턴타입 => 배열)
				
				long fileSize = 0;			
				// 첨부파일의 크기 
				
				
				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					
					String originalFilename = attach.getOriginalFilename();
					// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
					
				//	System.out.println("~~~ 확인용 originalFilename => " + originalFilename);
				    // ~~~ 확인용 originalFilename => washer_samsung_wd15h_1.png
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드하는 것이다.
					
				//	System.out.println("~~~ 확인용 newFileName => " + newFileName);
					// ~~~ 확인용 newFileName => 2023112411365864884011858800.png
					
					/*
						3. Tripboardvo tripboardvo 에 fileName 값과 orgFilename 값과   fileSize 값을 넣어주기		
					*/
					 tripboardvo.setTb_fileName(newFileName);
					 // WAS(톰캣)에 저장된 파일명(2023112411365864884011858800.png)
					 
					 tripboardvo.setTb_orgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(washer_samsung_wd15h_1.png)을 보여줄 때 사용.
			        // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					 fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					 
					 tripboardvo.setTb_fileSize(String.valueOf(fileSize));
					
									
				} catch (Exception e) {				
					e.printStackTrace();
				}
							
			}		
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
			
			int n = 0;
			
			if(attach.isEmpty()) {
				// 파일첨부가 없는 경우라면 
				n = service.add(tripboardvo);
			}
			
			else {
				// 파일첨부가 있는 경우라면 
				n = service.add_withFile(tripboardvo);
			}
			// === 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service를 호출하기  끝 === //
			
			if(n==1) {
				mav.setViewName("redirect:/tblist.exp");
				
			}
			else {
				mav.setViewName("ch/tripboard/error/add_error.tiles1");
				
			}	

		return mav;
	}
	
	// === 여행후기 게시판 글 상세보기 페이지 === //
	@GetMapping("/tbview.exp")
	public ModelAndView tbview(ModelAndView mav, HttpServletRequest request) {
		
		/////////////////////////////////////////////////////
		String tb_seq = "";
		String goBackURL = "";
		String searchType = "";
		String searchWord = "";

		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다.

		if (inputFlashMap != null) { // redirect 되어서 넘어온 데이터가 있다 라면

			@SuppressWarnings("unchecked") // 경고 표시를 하지 말라는 뜻이다.
			Map<String, String> redirect_map = (Map<String, String>) inputFlashMap.get("redirect_map");
			// "redirect_map" 값은 /view_2.action 에서 redirectAttr.addFlashAttribute("키", 밸류값);
			// 을 할때 준 "키" 이다.
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터를 꺼내어 온다.
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터의 값은 Map<String, String> 이므로 Map<String,
			// String> 으로 casting 해준다.

			// System.out.println("~~~ 확인용 tb_seq : " + redirect_map.get("tb_seq"));
			 
			tb_seq = redirect_map.get("tb_seq");
			searchType = redirect_map.get("searchType");
			try {
				searchWord = URLDecoder.decode(redirect_map.get("searchWord"), "UTF-8"); // 한글데이터가 포함되어 있으면 반드시 한글로																							// 복구주어야 한다.
				goBackURL = URLDecoder.decode(redirect_map.get("goBackURL"), "UTF-8"); // 한글데이터가 포함되어 있으면 반드시 한글로 복구주어야																						// 한다.
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			if (goBackURL != null && goBackURL.contains(" ")) {
				goBackURL = goBackURL.replaceAll(" ", "&");
			}
		}

		/////////////////////////////////////////////////////

		else { // redirect 되어서 넘어온 데이터가 아닌 경우

			// == 조회하고자 하는 글번호 받아오기 ==

			tb_seq = request.getParameter("tb_seq");
			// System.out.println("~~~~~~ 확인용 tb_seq : " + tb_seq);

			// === 특정글을 조회한 후 "검색된결과목록보기" 버튼을 클릭했을 때 돌아갈 페이지를 만들기 위함.
			goBackURL = request.getParameter("goBackURL");
			if (goBackURL != null && goBackURL.contains(" ")) {
				goBackURL = goBackURL.replaceAll(" ", "&");
			}
			// System.out.println("~~~ 확인용(tbview.exp) goBackURL : " + goBackURL);
			
			//   (post방식 이어야함) ~~~ 확인용(tbview.exp) goBackURL :
			//  /tblist.exp?searchType=name&searchWord=서울&currentShowPageNo=9
			 

			// === 검색으로 조회된 글을 볼 때 tbview.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위한 것임. 시작 ===
			searchType = request.getParameter("searchType");
			searchWord = request.getParameter("searchWord");

			if (searchType == null) {
				searchType = "";
			}

			if (searchWord == null) {
				searchWord = "";
			}

			// System.out.println("~~~ 확인용 searchType : " + searchType);
			// System.out.println("~~~ 확인용 searchWord : " + searchWord);
			// === 검색으로 조회된 글을 볼 때 tbview.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위한 것임. 끝 ===
		}

		mav.addObject("goBackURL", goBackURL);

		try {
			Integer.parseInt(tb_seq);
			
			//"이전글제목" 또는 "다음글제목" 을 클릭하여 특정글을 조회한 후 새로고침(F5)을 한 경우는 원본이 /view_2.action 을 통해서
			//redirect 되어진 경우이므로 form 을 사용한 것이 아니라서 "양식 다시 제출 확인" 이라는 alert 대화상자가 뜨지 않는다.
			//그래서 request.getParameter("seq"); 은 null 이 된다. 즉, 글번호인 seq 가 null 이 되므로 DB 에서
			//데이터를 조회할 수 없게 된다. 또한 seq 는 null 이므로 Integer.parseInt(seq); 을 하면
			//NumberFormatException 이 발생하게 된다.
			

			HttpSession session = request.getSession();
			UserVO loginuser = (UserVO) session.getAttribute("loginuser");

			String login_userid = null;
			if (loginuser != null) {
				login_userid = loginuser.getUserid();
				// login_userid 는 로그인 되어진 사용자의 userid 이다.
			}

			Map<String, String> paraMap = new HashMap<>();

			paraMap.put("tb_seq", tb_seq);
			paraMap.put("login_userid", login_userid);

			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);

			// 위의 글목록보기에서 session.setAttribute("td_td_readCountPermission", "yes"); 해두었다.
			TripboardVO tripboardvo = null;

			if ("yes".equals((String) session.getAttribute("td_readCountPermission"))) {
				// 글목록보기인 /tblist.exp 페이지를 클릭한 다음에 특정글을 조회해온 경우이다.

				tripboardvo = service.getView(paraMap);
				// 글조회수 증가와 함께 글1개를 조회를 해주는 것
				// System.out.println("~~ 확인용 글내용 : " + tripboardvo.getContent());

				session.removeAttribute("td_readCountPermission");
				// 중요함!! session 에 저장된 td_td_readCountPermission 을 삭제한다.
			}

			else {
				// 글목록에서 특정 글제목을 클릭하여 본 상태에서
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
				// System.out.println("글목록에서 특정 글제목을 클릭하여 본 상태에서 웹브라우저에서 새로고침(F5)을 클릭한 경우");

				tripboardvo = service.getView_no_increase_readCount(paraMap);
				// 글조회수 증가는 없고 단순히 글1개만 조회를 해주는 것
			 	
			}

			mav.addObject("tripboardvo", tripboardvo);

			mav.addObject("paraMap", paraMap);

		} catch (NumberFormatException e) {
			// 이전글제목 또는 다음글제목을 클릭하여 본 상태에서
			// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
			 mav.setViewName("redirect:/tblist.exp");
			 return mav;
		
		}
		
		mav.setViewName("ch/tripboard/tbview.tiles1");

		return mav;
	}
	
//	@GetMapping("/tbview_2.action")
	@PostMapping("/tbview_2.action")
	public ModelAndView tbview_2(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
		
		// 조회하고자 하는 글번호 받아오기
		String tb_seq = request.getParameter("tb_seq");
		
		String goBackURL = request.getParameter("goBackURL");
		goBackURL = goBackURL.replaceAll("&", " ");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		
		HttpSession session = request.getSession();
		session.setAttribute("td_readCountPermission", "yes");

		/* 
		  redirect:/ 를 할때 "한글데이터는 0에서 255까지의 허용 범위 바깥에 있으므로 인코딩될 수 없습니다" 라는 
		  java.lang.IllegalArgumentException 라는 오류가 발생한다.
		   이것을 방지하려면 아래와 같이 하면 된다.
		*/
		try {
			searchWord = URLEncoder.encode(searchWord, "UTF-8");
			goBackURL = URLEncoder.encode(goBackURL, "UTF-8");
			
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	//	mav.setViewName("redirect:/view.action?seq="+seq+"&goBackURL="+goBackURL+"&searchType="+searchType+"&searchWord="+searchWord); 
		
		// ==== redirect(GET방식임) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용하면 된다. 시작 ==== //
		/////////////////////////////////////////////////////////////////////////////////
		Map<String, String> redirect_map = new HashMap<>();
		redirect_map.put("tb_seq", tb_seq);
		redirect_map.put("goBackURL", goBackURL);
		redirect_map.put("searchType", searchType);
		redirect_map.put("searchWord", searchWord);
		
		redirectAttr.addFlashAttribute("redirect_map", redirect_map); // redirectAttr.addFlashAttribute("키", 밸류값); 으로 사용하는데 오로지 1개의 데이터만 담을 수 있으므로 여러개의 데이터를 담으려면 Map 을 사용해야 한다. 

		mav.setViewName("redirect:/tbview.exp"); // 실제로 redirect:/view.action 은 POST 방식이 아닌 GET 방식이다.
        /////////////////////////////////////////////////////////////////////////////////
		// ==== redirect(GET방식임) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용하면 된다. 끝 ==== //
		
		return mav;
		
	}
	
	
	// ==== #71. 글을 수정하는 페이지 요청 ==== //
	@GetMapping("/tbedit.exp")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		// 글 수정해야 할 글번호 가져오기
		String tb_seq = request.getParameter("tb_seq");
		
		String message = "";
		
		try {
			Integer.parseInt(tb_seq);
		
			// 글 수정해야할 글1개 내용가져오기
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("tb_seq", tb_seq);
			
			TripboardVO tripboardvo = service.getView_no_increase_readCount(paraMap);
			// 글조회수(readCount) 증가 없이 단순히 글 1개만 조회해주는 것이다. 
			
			if(tripboardvo == null) {
				message = "글 수정이 불가합니다";
			}
			else {
				HttpSession session = request.getSession();
				UserVO loginuser = (UserVO) session.getAttribute("loginuser");
				
				if( !loginuser.getUserid().equals(tripboardvo.getFk_userid()) ) { 
					 message = "다른 사용자의 글은 수정이 불가합니다";
				}
				else {
					// 자신의 글을 수정할 경우
					// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
					mav.addObject("tripboardvo", tripboardvo);
				 	mav.setViewName("ch/tripboard/tbedit.tiles1");
				 	
				 	return mav;
				}
			}
			
		} catch(NumberFormatException e) {
			message = "글 수정이 불가합니다";
		}
		
        String loc = "javascript:history.back()";
	 	mav.addObject("message", message);
	 	mav.addObject("loc", loc);
	 	
	 	mav.setViewName("msg");
		
		return mav;
	}
		
		
	// ==== #72. 글을 수정하는 페이지 완료하기 ==== //
	@PostMapping("/tbeditEnd.exp")
	public ModelAndView editEnd(ModelAndView mav, TripboardVO tripboardvo, HttpServletRequest request) {
		
		int n = service.tbedit(tripboardvo);
		
		if(n==1) {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/tbview.exp?tb_seq="+tripboardvo.getTb_seq());
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "글 수정 실패!!");
			mav.addObject("loc", request.getContextPath()+"/tbview.exp?tb_seq="+tripboardvo.getTb_seq());
			mav.setViewName("msg");
			
		}
		return mav;
	}
	
		
	
	// ==== #77. 글을 삭제하는 페이지 완료하기 ==== //
		@PostMapping("/delEnd.exp")
		public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
			
			String tb_seq = request.getParameter("tb_seq");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("tb_seq", tb_seq);
			
			
			//////////////////////////////////////////////////////////////////////////
			// === #164. 파일 첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 === //
			
			// 글 하나를 그대로 읽어와야 한다. 
			paraMap.put("tb_seq", tb_seq);
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");


			TripboardVO tripboardvo = service.getView_no_increase_readCount(paraMap);

			String fileName = tripboardvo.getTb_fileName();
			// 2023112412483369178658686400.pdf 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
			
			if(fileName != null && !"".equals(fileName)) {
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 최상위 루트가 어딘지 알아온다.
								
			//	 System.out.println("~~~ 확인용 webapp의 절대경로 => " + root);
			//   ~~~ 확인용 webapp의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
								
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				*/
				
				paraMap.put("path", path);         // 삭제해야할 파일이 저장된 경로
				paraMap.put("fileName", fileName); // 삭제해야할 파일명
			}
			
			// === #164. 파일 첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 === //
			//////////////////////////////////////////////////////////////////////////
			int n = service.tbdel(paraMap);
			
			if(n==1) {
				mav.addObject("message", "글 삭제 성공!!");
				mav.addObject("loc", request.getContextPath()+"/tblist.exp");
				mav.setViewName("msg");
			}
			
			return mav;
		}
	
	// === 첨부파일 다운로드 받기 === //
	@GetMapping(value="/download.exp")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String tb_seq = request.getParameter("tb_seq");
		// System.out.println("tb_seq : " + tb_seq);
		// 첨부파일이 있는 글번호
		
		/*
		 첨부파일이 있는 글번호에서, 2023112412483369178658686400.pdf 처럼
		 이러한 fileName 값을 DB에서 가져와야 한다.
		 또한 orgFilename 값(ex. LG_싸이킹청소기_사용설명서.pdf)도 DB에서 가져와야 한다.
		*/
		
		Map<String, String> paraMap = new HashMap<>(); // 글 하나를 읽어오기 위해 맵을 이용하여 가져온다. 
		paraMap.put("tb_seq", tb_seq);
		paraMap.put("tb_searchType", "");
		paraMap.put("tb_searchWord", "");
		
		// *** 웹브라우저에 출력하기 시작 *** //
	    // HttpServletResponse response 객체는 전송되어져온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다.
	      response.setContentType("text/html; charset=UTF-8");
	      
	      PrintWriter out = null;    // 평상시엔 없다.
	      // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
		
	      try {
			Integer.parseInt(tb_seq);
			TripboardVO tripboardvo = service.getView_no_increase_readCount(paraMap);
			
			if(tripboardvo == null || (tripboardvo != null && tripboardvo.getTb_fileName() == null)) { // 없던지 아니면 첨부파일이 없는 경우
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}
			
			else {
				// 정상적으로 다운로드를 할 경우
				
				String tb_fileName = tripboardvo.getTb_fileName();
				// 2023112412483369178658686400.pdf 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
				
				String tb_orgFilename = tripboardvo.getTb_orgFilename();
				// LG_싸이킹청소기_사용설명서.pdf 다운로드시 보여줄 파일명이다.
				
				// 첨부파일이 저장되어있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.

				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 최상위 루트가 어딘지 알아온다.
				
			//	System.out.println("~~~ 확인용 webapp의 절대경로 => " + root);
			    // ~~~ 확인용 webapp의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\expedia\
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
	            */
				// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//	System.out.println("~~~ 확인용 webapp의 절대경로 => " + path);
			    //~~~ 확인용 webapp의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files
				
					// ***** file 다운로드 하기 ***** //
					boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도. / 성공하면 true, 실패하면 false.					
					flag = fileManager.doFileDownload(tb_fileName, tb_orgFilename, path, response);
					// file 다운로드 성공 시 flag는 true, 실패시 false 를 갖게 된다.
					
					if(!flag) {
						// 다운로드가 실패한 겨우 메시지를 띄운다.
						out = response.getWriter();
						// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
						
						out.println("<script type='text/javascript'>alert('파일다운로드를 실패했습니다.'); history.back();</script>");
						
					}
			}
			
		} catch (NumberFormatException | IOException e) {
			// 다운로드가 실패한 겨우 메시지를 띄운다.
			try {
				out = response.getWriter();
			} catch (IOException e2) {				
				e2.printStackTrace();
			}
			// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
			
			out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
		}
		
		
	}
	
	
	// === 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일 업로드 === //
    @PostMapping(value="/image/multiplePhotoUpload.exp")
    public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
    	/*
		1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
        >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		우리는 WAS 의 webapp/resources/images/ch 라는 폴더로 지정해준다.
    	 */
     
		 // WAS 의 webapp 의 절대경로를 알아와야 한다.
		 //  HttpSession session = request.getSession();
		 //  String root = session.getServletContext().getRealPath("/");
		 //  String path = root + "resources"+File.separator+"photo_upload";
		 // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
		 
    	String root = "C:\\git\\fin_project\\fin_project\\src\\main\\webapp\\resources";
    	String path = root +File.separator+"images"+File.separator+"ch";	
    	
		// C:\Users\82105\Desktop\ssit\java_file\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\expedia\resources\photo_upload
		 // +/resources/images/ch
		 File dir = new File(path);
		 if(!dir.exists()) {
			 dir.mkdirs();
		 }
		 
		 try {
	         String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
	         // 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
	          	
	         /*
	             [참고]
	             HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다. 
	   
	            request.getHeader("referer");           // 접속 경로(이전 URL)
	            request.getHeader("user-agent");        // 클라이언트 사용자의 시스템 정보
	            request.getHeader("User-Agent");        // 클라이언트 브라우저 정보 
	            request.getHeader("X-Forwarded-For");   // 클라이언트 ip 주소 
	            request.getHeader("host");              // Host 네임  예: 로컬 환경일 경우 ==> localhost:9090    
	         */
	         
	      //   System.out.println(">>> 확인용 tb_filename ==> " + tb_filename);
	         // >>> 확인용 filename ==> berkelekle%EB%8B%A8%EA%B0%80%EB%9D%BC%ED%8F%AC%EC%9D%B8%ED%8A%B803.jpg 
	         
	         InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
	         
	         String newtb_Filename = fileManager.doFileUpload(is, filename, path);
	         
	         int width = fileManager.getImageWidth(path+File.separator+newtb_Filename);
	         
	          if(width > 600) {
	             width = 600;
	          }
	          
	       // System.out.println(">>>> 확인용 width ==> " + width);
	       // >>>> 확인용 width ==> 600
	       // >>>> 확인용 width ==> 121
	         
	         String ctxPath = request.getContextPath(); //  /board
	         
	         String strURL = "";
	         strURL += "&bNewLine=true&sFileName="+newtb_Filename; 
	         strURL += "&sWidth="+width;
	         strURL += "&sFileURL="+ctxPath+"/resources/images/ch/"+newtb_Filename;
	         
	         // === 웹브라우저 상에 사진 이미지를 쓰기 === //
	         PrintWriter out = response.getWriter();
	         out.print(strURL);
	         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
		 
		 
    }
	
    
    // 좋아요 버튼 구현하기
    @ResponseBody
    @PostMapping(value="/likeAdd.exp", produces="text/plain;charset=UTF-8")
    public String likeAdd(HttpServletRequest request) {
    
    	
    	String tb_seq =  request.getParameter("tb_seq");
    	String userid = request.getParameter("userid");
    	
    	
    	// System.out.println(tb_seq);
    	// System.out.println(userid);
    	
    	Map<String, String> paraMap = new HashMap<>();
    	
    	paraMap.put("tb_seq", tb_seq);
    	paraMap.put("userid", userid);
    	
    	int n = 0;
    	String msg = "";
    	JSONObject jsonObj = new JSONObject();
    	
		try {
			n = service.likeAdd(paraMap);
		      
		    if(n==1) {
		       msg = "해당제품에\n 좋아요를 클릭하셨습니다.";
		    }
		    
		} catch (Exception e) {
			// System.out.println("~~~~~~~~~ 좋아요를 두번 클릭한 경우~~~~~~~~~");
			// 좋아요를 두번 클릭한 경우
			// e.printStackTrace();
			
			service.likeDelete(paraMap);
		    msg= "취소되었습니다.";
		}
    	 
		jsonObj.put("msg", msg); // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}   {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}
		
		return jsonObj.toString();  
	
    }
	
    
    @ResponseBody
    @GetMapping(value="/likeCount.exp")
    public String likeCount(HttpServletRequest request){

    	String tb_seq = request.getParameter("tb_seq");
    
    	
    	Map<String, Integer> map = service.getCnt(tb_seq);
    	
    	JSONObject jsonObj = new JSONObject();
    	
    	jsonObj.put("likecnt", map.get("LIKECNT"));
    	
    	
    	return jsonObj.toString();
    }
		
	
	
	
}
