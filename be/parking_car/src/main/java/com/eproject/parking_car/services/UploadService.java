package com.eproject.parking_car.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class UploadService {

    @Autowired
    private Cloudinary cloudinary;

    public String generateUniqueFilename() {
        String uniqueId = UUID.randomUUID().toString();
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = currentDateTime.format(formatter);
        return timestamp + "-" + uniqueId;
    }

    public String getDirectorySubFolder(String parentFolderName, String subfolderName) throws Exception {
        Map result = cloudinary.api().subFolders(parentFolderName, ObjectUtils.emptyMap());
        List subfolders = (List) result.get("subfolders");

        if (subfolders == null || !subfolders.contains(parentFolderName + "/" + subfolderName)) {
            cloudinary.api().createFolder(parentFolderName + "/" + subfolderName, ObjectUtils.emptyMap());
        }

        return parentFolderName + "/" + subfolderName;
    }

    public String getFolderName() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        int atIndex = email.indexOf('@');
        return email.substring(0, atIndex);
    }


    public CloudinaryImageInfor uploadImage(MultipartFile file) throws Exception {
        String folder = getDirectorySubFolder("Project_Parking_Car",getFolderName());
        String uniqueFileName = generateUniqueFilename();
        var uploadFile = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap(
                "folder", folder,
                "public_id", "team4-ppc-"+uniqueFileName,
                "upload_preset", "upload-image-project"));
        String name = (String) uploadFile.get("public_id");
        String url = (String) uploadFile.get("secure_url");
        CloudinaryImageInfor result = new CloudinaryImageInfor();
        result.setName(name).setUrl(url);
        return result;
    }

    public Set<CloudinaryImageInfor> uploadMultiImage(MultipartFile[] files) throws Exception {
        Set<CloudinaryImageInfor> results = new HashSet<>();
        String folder = getDirectorySubFolder("Project_Parking_Car",getFolderName());
        for (MultipartFile file : files) {
            String uniqueFileName = generateUniqueFilename();
            var uploadFile = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap(
                    "folder", folder,
                    "public_id", "team4-ppc-" + uniqueFileName,
                    "upload_preset", "upload-image-project"));
            String name = (String) uploadFile.get("public_id");
            String url = (String) uploadFile.get("secure_url");
            CloudinaryImageInfor result = new CloudinaryImageInfor();
            result.setName(name).setUrl(url);
            results.add(result);
        }
        return results;
    }

    public boolean deleteImage(String publicId) {
        try {
            var result = cloudinary.api().resource(publicId, ObjectUtils.emptyMap());
            if(result.get("public_id") != null) {
                cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
                return true;
            } else {
                throw new IOException();
            }
        } catch (Exception e) {
            e.getMessage();
            return false;
        }
    }

    public boolean deleteMultiImage(Set<String> listPublicId) {
        try {
            if(listPublicId.size() > 0) {
                for (String item: listPublicId) {
                    var result = cloudinary.api().resource(item, ObjectUtils.emptyMap());
                    if (result.get("public_id") == null) {
                        throw new IOException();
                    }
                    cloudinary.uploader().destroy(item, ObjectUtils.emptyMap());
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            e.getMessage();
            return false;
        }
    }
}
