package kr.ac.kyonggi.swaig.handler.excel;

import kr.ac.kyonggi.swaig.handler.dto.settings.RegAnswerDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegQuestionDTO;
import kr.ac.kyonggi.swaig.handler.dto.settings.RegisterDTO;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class RegExcelWriter {
    public void xlsWriter(ArrayList<RegAnswerDTO> arraylist, ArrayList<RegQuestionDTO> questions, String path) throws IOException {
        //DB조회후 데이터를 담았다는 가상의 데이터
        ArrayList<ArrayList<String>> array=new ArrayList<>();

        int count = questions.size();
        ArrayList<Integer> fileQuestions = new ArrayList<>();
        for(int i = 0 ; i < questions.size() ; ++i) {
            if(questions.get(i).question_type == 5)
                fileQuestions.add(i+1);
        }

        ArrayList<String> a = null;
        for(int i = 0 ; i < arraylist.size() ; ++i) {
            RegAnswerDTO answer = arraylist.get(i);
            if(i % count == 0) {
                a = new ArrayList<>();
                a.add(answer.writer_name);
                a.add(answer.writer_type);
                if(answer.writer_perId == null)
                    a.add("-");
                else
                    a.add(answer.writer_perId);
                if(answer.writer_grade == null)
                    a.add("-");
                else
                    a.add(answer.writer_grade);
                if(fileQuestions.contains(answer.question_num)) {
                    if(answer.answer.equals("null"))
                        a.add("파일 미제출");
                    else
                        a.add("파일 답변");
                }
                else
                    a.add(answer.answer);
            }
            else {
                if(fileQuestions.contains(answer.question_num)) {
                    if(answer.answer.equals("null"))
                        a.add("파일 미제출");
                    else
                        a.add("파일 답변");
                }
                else
                    a.add(answer.answer);
            }
            if(i % count == (count-1))
                array.add(a);
        }

        //1차로 workbook을 생성
        HSSFWorkbook workbook=new HSSFWorkbook();
        //2차는 sheet생성
        HSSFSheet sheet=workbook.createSheet("신청접수 결과");
        //엑셀의 행
        HSSFRow row=null;
        //엑셀의 셀
        HSSFCell cell=null;
        //임의의 DB데이터 조회
        row=sheet.createRow(0);
        ArrayList<String> header= new ArrayList<String>();
        header.add("이름");
        header.add("구분");
        header.add("학번");
        header.add("학년");
        for(int i = 1 ; i <= count ; ++i)
            header.add(Integer.toString(i) + "번");
        for(int k = 0 ; k < header.size();k++) {
            cell=row.createCell(k);
            cell.setCellValue(header.get(k));
        }

        if(array !=null && array.size() >0){
            for(int i = 0 ; i < array.size() ; ++i){
                ArrayList<String> answers = array.get(i);
                row=sheet.createRow((short)(i+1));
                if(answers !=null && answers.size() >0){
                    for(int j = 0 ; j < answers.size() ; ++j){
                        //생성된 row에 컬럼을 생성한다
                        cell=row.createCell(j);
                        //map에 담긴 데이터를 가져와 cell에 add한다
                        String value = answers.get(j);
                        if(!value.equals(""))
                            cell.setCellValue(value);
                        else
                            cell.setCellValue("미답변");
                    }
                }
            }
        }

        FileOutputStream fileoutputstream=new FileOutputStream(path + "/신청관리.xls");
        //파일을 쓴다
        workbook.write(fileoutputstream);
        //필수로 닫아주어야함
        fileoutputstream.close();
    }
}
