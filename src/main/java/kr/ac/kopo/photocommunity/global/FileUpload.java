package kr.ac.kopo.photocommunity.global;

import kr.ac.kopo.photocommunity.model.Attach;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileUpload {
    private static final String rootPath = "c://upload/photocommunity";


    public static List<Attach> filesUpload(List<MultipartFile> fileList){
        List<Attach> list = new ArrayList<Attach>();

        try {
            for(MultipartFile file : fileList){
                if (file != null && !file.isEmpty()){
                    String filename = file.getOriginalFilename();

                    file.transferTo(new File(rootPath + filename));

                    Attach attachItem = new Attach();
                    attachItem.setFilename(filename);

                    list.add(attachItem);
                } else {
                    break;
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return list;
    }

}
