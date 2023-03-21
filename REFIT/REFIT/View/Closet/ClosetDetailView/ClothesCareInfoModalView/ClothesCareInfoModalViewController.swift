//
//  ClothesCareInfoModalViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/20.
//

import Foundation
import UIKit

class ClothesCareInfoModalViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleItem: UINavigationItem!
    
    var modalTitle: String = "title"
    
    // material
    let materialStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 건조하기",
        "STEP.3 다림질하기",
        "STEP.4 보관하기"
    ]
    let furStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 보관하기"
    ]
    
    let cotton = [
        "면은 사계절 내내 입을 수 있으며,\n쉽게 찢어지지 않아 오래 입을 수 있습니다.\n그러나 쉽게 구겨지고,\n열에 약하며 물에 오래 담궈두었을 때\n탈색의 위험이 있으니 주의해야 합니다.",
        "중성세제로 세탁해 주세요. 미온수에서 손 세탁을  가장 추천해요. 세탁기 사용 시 울코스에서 30~40°C로 세탁해 주세요.",
        "세탁기로 탈수 시, 시간은 5분 이내로 하는 것이 좋아요. 열에 약하므로 직사광선을 피해 통풍이 잘 되는 곳에 건조해 주세요. 젖은 면 옷을 옷걸이에 걸어 건조하면 형태의 변형이 생길 수 있습니다. 건조대를 이용해 건조하세요.",
        "180~200°C 사이의 온도로 다림질 해 주세요.",
        "깔끔하게 접어 보관하는 것이 가장 좋아요."
    ]
    let linen = [
        "린넨은 얇고 바람이 잘 통해 여름에 주로 입습니다. 열과 수분, 마찰에 강하지만, 구김이 쉽게 가 보관에 유의해야 합니다.",
        "중성세제로 세탁해 주세요.\n섬유유연제는 사용하면 안 돼요!\n약한 강도의 손세탁을 가장 추천해요.\n세탁기 이용 시 꼭 세탁망에 넣어 30°C 미만의 물로 단시간 세탁해야 합니다.",
        "옷을 잘 펼치거나 옷걸이에 걸어 그늘에서 건조하세요.",
        "180~200°C 사이의 온도로 다림질 해 주세요.",
        "옷이 구겨지지 않게 옷걸이에 걸어 보관하세요."
    ]
    let polyester = [
        "가장 많이 사용되는 인조섬유입니다. 구김이 잘 안가지만, 열에 약해 세탁/관리 시 주의해야 합니다.",
        "중성세제로 세탁해 주세요.\n정전기가 심해 건조한 날에는 섬유유연제를 쓰는 것이 좋아요.\n표백제 사용은 주의해야 해요.\n미지근한 물에서 세탁해야 합니다.",
        "열에 약해 건조기 사용은 절대 금물이에요.\n건조대를 이용해 건조하세요",
        "120°C 이하의 온도로 다림질 해 주세요.",
        "옷걸이에 걸거나 접어서 보관하세요."
    ]
    let nylon = [
        "아웃도어 의류나 스타킹, 양말에 많이 사용되는 나일론은 튼튼하고 가벼운 것이 특징입니다. ",
        "일반세제를 이용해 세탁하세요.\n표백제 사용은 주의해야 해요.\n20°C의 차가운 물에 짧게 세탁하는 것이 좋습니다. ",
        "옷걸이에 걸어 그늘에서 건조해 주세요.",
        "120°C 이하의 온도로 다림질 해 주세요.\n다른 천을 덧대어 다림질 하는 것도 좋아요.",
        "열에 약하니 핫볕이 들지 않는 곳에 보관해 주세요."
    ]
    let velvet = [
        "벨벳은 관리법이 정말 중요합니다. 표면의 털이 눌려 납작해지거나 먼지가 쌓여 뭉칠 수도 있습니다. ",
        "자주 세탁하지 않는 것이 좋아요.\n얼룩이 묻었을 때는 물을 묻혀 문지르지 말고, 물을 살짝 뿌린 후 부드러운 천으로 살짝 닦아주세요.\n드라이클리닝을 이용해야 벨벳이 손상되지 않아요.",
        "옷걸이에 걸어서 건조하세요.",
        "천을 뒤집어서 안감을 다림질 해 주세요.\n얇은 천을 한 겹 덧대어 스팀다리미로 다림질 하세요.",
        "옷걸이에 넣어 그늘진 곳에 보관해 주세요."
    ]
    let Denim = [
        "광부의 작업복을 만들던 튼튼하고 복원력이 좋은 원단으로 유명합니다. 그러나 오래도록 예쁘게 입기 위해서는 물빠짐에 주의해야 합니다.",
        "자주 세탁하지 않는 것이 좋습니다.\n옷을 뒤집어 빨면 물빠짐을 막을 수 있습니다.\n손 빨래, 울 코스에서 냉수로 세탁해 주세요.",
        "자연건조 하는 것이 좋습니다. 직사광선을 피해 건조하세요.\n바지의 경우, 발목이 위로 가게 건조하면 바지의 수축을 방지하고, 늘어난 무릎을 복구시킬 수도 있습니다.\n건조기를 이용할 때는 최저온도로 설정하고 이용해 주세요.",
        "다리미의 온도를 140~190°C로 설정하여 다림질하세요.",
        "옷걸이에 걸어 보관하세요.\n바지는 접어서 보관하기보다 돌돌 말아 보관하는 것이 좋습니다."
    ]
    let leather = [
        "방수성, 탄력, 내구성이 뒤어납니다. 그러나 관리가 까다로워 주의가 필요합니다.",
        "손상의 위험이 있으니 자주 세탁하지 않는 것이 좋습니다.\n가죽전용 세탁세제를 이용해 손세탁하세요.",
        "울코스로 탈수해 건조하세요.\n바람이 잘 통하는 곳에 널어 건조해야 해요.",
        "가장 낮은 온도로, 천을 한 겹 덧대어 다림질 하세요.",
        "가죽전용크림을 바르면 색감과 광택을 오래 유지할 수 있습니다.\n환기가 잘 되는 곳에 옷걸이에 걸어 보관하세요."
    ]
    let fur = [
        "고급스럽고 따듯한 이미지를 주며 겨울 옷에 많이 활용합니다.",
        "2~3년에 한 번 모피 전문 세탁 업체에 맡겨 세탁하는 것이 좋습니다.\n오염물질이 묻었을 때는 천에 미지근한 물을 묻혀 두드리듯 닦아주세요.",
        "그늘지고, 통풍이 잘 되는 곳에 보관하세요.\n습지가 차지 않도록 하는 것이 중요합니다."
    ]
    let silk = [
        "천연섬유로 자연스러운 광택이 특징입니다. 가볍고 보온성이 좋으나 땀과 빛에 약해 세탁, 보관 시 유의해야 합니다. ",
        "드라이클리닝을 맡기는 것이 가장 좋습니다.\n세탁기 이용 시 30°C 이하의 차가운 물에 중성세제를 풀어 세탁하세요.",
        "수건 위에 두어 물기를 제거 한 뒤 그늘에서 말려주세요.",
        "직접 열이 가해지는 다림질은 피해주세요.\n구김이 생긴 실크는 샤워할 때 옷걸이에 걸어 두면 구김이 펴집니다.",
        "옷걸이에 걸어 햇빛이 들거나 습하지 않은 곳에 보관하세요."
    ]
    let tweed = [
        "양모사와 기타 모사를 섞어 촘촘하게 짠 옷감으로, 다소 거친 느낌을 주며 습기에 강하고 튼튼한 것이 특징입니다.",
        "드라이클리닝이나 손세탁을 이용해요.\n중성세제를 물에 풀어 비비지 말고 부드럽게 세탁해 주세요.\n오염물질이 묻었을 때는 중성세제를 묻혀 위에서 아래로 살살 문질러 주세요.",
        "실온에서 자연건조 해주세요.",
        "스팀다리미로 다림질 해요.",
        "어깨부분이 두꺼운 정장용 옷걸이에 걸어 보관하세요.\n단추를 채우면 형태가 변형되는 것을 막을 수 있습니다."
    ]
    let chiffon = [
        "가볍고 하늘하늘한 쉬폰은 원사가 얇아 원단이 망가지기 쉬우니 관리에 유의해야 합니다. ",
        "땀과 자외선에 약해 외출 후 바로 세탁하는 것이 좋아요.\n중성세제를 이용해 미지근한 물에서 손세탁하세요.",
        "바틀어 짜지 말고 타월로 가볍게 물기를 제거해 그늘에 자연건조하세요,",
        "가능하면 다림질하지 않는 것이 좋습니다.\n필요한 경우, 가장 낮은 온도로 천을 합 겹 덧대어 다림질해주세요.",
        "옷걸이에 걸어 보관하세요."
    ]
    let corduroy = [
        "촉감이 부드럽고, 내구성과 보온성이 좋아 가을, 겨울 옷에 많이 활용됩니다. 그러나 보풀이 일어나기 쉽고, 원단이 잘 늘어나 관리 시 주의해야 합니다.",
        "첫 세탁은 드라이클리닝에 맡기는 것이 좋아요.\n보붚이 쉽게 일어나니 단독으로 세탁하세요.\n중성세제를 이용해 30°C 이하의 미온수에서 세탁해야 하며, 손세탁 하는 것을 추천해요.",
        "옷이 완전히 마르기 전에 부드러운 솔을 이용해 결대로 빗어주면 코듀로이 결이 깨끗하게 유지됩니다.",
        "스팀다리미를 이용해야 합니다.\n옷을 뒤집어 안감을 다림질 해 주세요.",
        "옷걸이에 걸어 빽빽하지 않게, 간격을 두고 보관해야 결이 상하지 않습니다."
    ]
    let metallic = [
        "",
        "",
        "",
        "",
        ""
    ]
    let lace = [
        "",
        "",
        "",
        "",
        ""
    ]
    let etc = [
        "",
        "",
        "",
        "",
        ""
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        self.titleItem.title = modalTitle
        
        let collectionNib = UINib(nibName: String(describing: ClothesCareInfoModalViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(collectionNib, forCellWithReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self))
        self.collectionView.collectionViewLayout = createCompostionalLayout()
    }

}

extension ClothesCareInfoModalViewController: UICollectionViewDelegate {
    
}

extension ClothesCareInfoModalViewController: UICollectionViewDataSource {
    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self), for: indexPath) as! ClothesCareInfoModalViewCell
        
        cell.topic = "test"
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height:  collectionView.frame.height)
    }
    
}

extension ClothesCareInfoModalViewController {
    fileprivate func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)

            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            // 가로 스크롤만 가능하도록 orthogonalScrollingBehavior 속성 설정
            section.orthogonalScrollingBehavior = .paging

            return section
        }
        return layout
    }
}
