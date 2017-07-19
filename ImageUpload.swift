 func imageUpload(){
        let parameters = [
            "dealer_id"   : "\(userDefaults.GET_USERID())",
            "arabic_name":"\(ProductNameInArbTxt.text!)",
            "brand_id":"\(brandID)",
            "model_id":"\(modelID)",
            "year_id":"\(yearID)",
            "cat_id":"\(catID)",
            "sparepart_id":"\(subcatID)",
            "price":"\(productPriceTct.text!)",
            "description":"\(productDescTxtView.text!)",
            "editor":"\(tagTxt)",
            "name":"\(productNameTxt)"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in

            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            if self.imageArr.count != 0{
                for i in 0...self.imageArr.count-1{
                    
                    let img:UIImage = self.imageArr[i]
                    multipartFormData.append(UIImageJPEGRepresentation(img , 0.6)!, withName: "image[]", fileName: "file.jpeg", mimeType: "image/jpeg")
                }
            }
            
            
            
        }, to:"http://azool.ae/webservice/add_product.php" )
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print("Encoding: \(progress)")
                })
                
                upload.responseJSON { response in
                    print ("Image upload response : \(response)")
                    
                    let responseObject = response.result.value! as! NSDictionary
                    let status = responseObject["status"] as! Bool
                    if status{
                        
                        if let imageNW = responseObject["msg"]{
                            Alertift.alert(title: "Success", message: "\(imageNW)")
                                .action(.default("OK"))
                                .show(on: self)
                        }
                        
                    }else{
                        
                        Alertift.alert(title: "Error", message: "Try again.")
                            .action(.default("OK"))
                            .show(on: self)
                        
                    }
                    
                }
                
                break
            case .failure(let encodingError):
                //print encodingError.description
                print("Encoding: \(encodingError)")
                
                break
            }
        }
        
    }
