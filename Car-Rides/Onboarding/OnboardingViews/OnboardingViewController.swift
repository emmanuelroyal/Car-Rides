//
//  OnboardingViewController.swift
//  Car-Rides
//
//  Created by Decagon on 7/29/21.
//

import UIKit
import FirebaseAuth

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    private let viewModel = OnboardingViewModel()
    var timer: Timer?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        setNavBar()
        createTimer()
        pageControl.numberOfPages = viewModel.slides.count
        viewModel.updateButton = { [weak self] title, currentPage  in
            self?.pageControl.currentPage = currentPage
            self?.nextButton.setTitle(title, for: .normal)
        }
        
        
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if viewModel.currentPage == viewModel.slides.count - 1 {
            skippedToLoginPage()
        } else {
            viewModel.currentPage += 1
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
    
    private func skippedToLoginPage() {
        let newStoryboard = UIStoryboard(name: "ProfileRegistration", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "Storyboard2") as ProfileRegistrationViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
    }
    
    @objc func toggle() {
        if viewModel.currentPage == viewModel.slides.count - 1 {
            viewModel.currentPage -= 1
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            toggles()
        } else {
            viewModel.currentPage += 1
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            toggles()
        }
    }
    @objc func toggles(){
        DispatchQueue.main.async { [self] in
            perform(#selector(createTimer), with: nil, afterDelay: 40)
        }
    }
    @objc func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 20.0,
                                     target: self,
                                     selector: #selector(toggle),
                                     userInfo: nil,
                                     repeats: true)
    }
}
extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "OnBoardingCollectionViewCell", for: indexPath) as?
                OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(viewModel.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage = Int(scrollView.contentOffset.x/width)
    }
}

