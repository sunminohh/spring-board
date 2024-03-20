package kr.co.sun.mapper;


import org.apache.ibatis.annotations.Select;

import kr.co.sun.domain.AuthVO;
import kr.co.sun.domain.MemberVO;

public interface MemberMapper { 

	public MemberVO read(String userid);
	
	public MemberVO getUserById(String userid);
	
	public MemberVO getUserByEmail(String userEmail);
	
	public void insert(MemberVO memvber);

	public void insertRole(AuthVO auth);
	
	
	public void updateUser(MemberVO member);
	
	public void deleteUser(String userid);
	
	public void deleteUserRole(String userid);
	
	
	/* 카카오 로그인 */
	public void kakaoInsert(MemberVO member);
	
	// snsId로 회원정보 얻기
	@Select("select userid, username, useremail from tbl_member where snsId = #{snsId}")
	MemberVO kakaoSelect(String snsId);
	
	// snsId로 회원 아이디 찾기
	@Select("select userid from tbl_member where snsId = #{snsId}")
	String findUserBySnsId(String snsId);
	
}
