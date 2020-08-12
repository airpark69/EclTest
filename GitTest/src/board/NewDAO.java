package board;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;

import board.BoardBean.board_Type;

public class NewDAO {
	private static NewDAO instance = new NewDAO();
	
	private NewDAO() {}
	
	public static NewDAO getInstance() {
		return instance;
	}
	
	public ArrayList<BoardBean> getNewComment(String id) {
		ArrayList<BoardBean> newCommentList = new ArrayList<BoardBean>();
		
		ArrayList<BoardBean> tempList;
		BoardDAO bdao = new BoardDAO();
		tempList = bdao.getNewComment(id);
		
		BoardBean bb;
		
		
		for(int x = 0; x < tempList.size(); x++) {
			bb = tempList.get(x);
			bb.setBoard_type(board_Type.board_Type_notice);
			newCommentList.add(bb);
		}
		
		GalleryDAO gdao = new GalleryDAO();
		tempList = gdao.getNewComment(id);
		
		for (int x = 0; x < tempList.size(); x++) {
			bb = tempList.get(x);
			bb.setBoard_type(board_Type.board_Type_gallery);
			newCommentList.add(bb);
		}
		
		// 최근 날짜 기준으로 정렬
		Collections.sort(newCommentList, new Comparator<BoardBean>() {

			@Override
			public int compare(BoardBean b1, BoardBean b2) {
				// TODO Auto-generated method stub
				return b1.getDate().compareTo(b2.getDate());
			}

		
		});
		
		
		return newCommentList;
		
	}
	
	
}
