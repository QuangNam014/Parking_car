package com.eproject.parking_car.controllers;

import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1")
public class UploadController {

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private UploadService uploadService;

    @PostMapping("upload/file")
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return customStatusResponse.BADREQUEST400("File is not empty");
            }

            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image")) {
                return customStatusResponse.BADREQUEST400("File is not an image");
            }

            var response = uploadService.uploadImage(file);
            if (response == null || response.getName() == null || response.getUrl() == null) {
                return customStatusResponse.BADREQUEST400("Result is invalid");
            }

            return customStatusResponse.OK200("Add file success", response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("upload/multi-file")
    public ResponseEntity<?> uploadMultiFile(@RequestParam("files") MultipartFile[] files) {
        try {
            if (files.length == 0) {
                return customStatusResponse.BADREQUEST400("Files are not empty");
            }

            for (MultipartFile file: files) {
                if (file.isEmpty()) {
                    return customStatusResponse.BADREQUEST400("File is not empty");
                }
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image")) {
                    return customStatusResponse.BADREQUEST400("File is not an image");
                }
            }

            var response = uploadService.uploadMultiImage(files);
            if (response.isEmpty()) {
                return customStatusResponse.BADREQUEST400("Result is invalid");
            }

            return customStatusResponse.OK200("Add list file success", response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
