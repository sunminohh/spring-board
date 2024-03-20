package kr.co.sun.service;

import java.util.List;

import kr.co.sun.domain.Criteria;
import kr.co.sun.domain.ReplyPageDTO;
import kr.co.sun.domain.ReplyVO;

public interface ReplyService {

public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
