   // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
        
    }
    // CollectionView Dequeue
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: (indexPath as NSIndexPath) as IndexPath) as! HomeCollectionViewCell
        
        
        
        let cat_item = category[indexPath.item] as! NSDictionary
        cell.contentView.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        cell.treatmentImg.layer.cornerRadius = cell.treatmentImg.frame.width/2
        
        
        cell.treatmentImg.sd_setShowActivityIndicatorView(true)
        cell.treatmentImg.sd_setIndicatorStyle(.gray)
        cell.treatmentImg.sd_setImage(with: URL(string: cat_item.value(forKey: "treatment_icon") as! String), placeholderImage: UIImage(named: "dummy_no_image"))
        cell.treatmentLbl.text = cat_item.value(forKey: "treatment_name") as? String
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.contentView.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.contentView.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
        
        
        return cell
    }
   // MARK: - Collection Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGSize = CGSize(width: (collectionView.frame.width/2)-3 , height: (collectionView.frame.width/2)+24 )
        return size
    }
    
    
    // Collection Didselection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let cat_item = category[indexPath.item] as! NSDictionary
        let treatment_id = cat_item.value(forKey: "treatment_id") as! String
        print(treatment_id)
    }
