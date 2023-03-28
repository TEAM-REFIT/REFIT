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
    
    // category
    let categoryStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 건조하기",
        "STEP.3 보관하기"
    ]
    
    // top
    let tShirtAndHood = [
        "",
        "프린팅이 있는 옷은 뒤집어서 세탁하면 뜯어짐이나 갈라짐을 예방 할 수 있습니다.\n물세제나 울샴푸를 섞은 물에 20분 가량 담궈 두면 오염이 쉽게 빠집니다.\n손빨래는 할 때는 세게 비비지 말고 부드럽게 세탁하세요.\n세탁기 이용 시에는 세탁망에 넣어 세탁하면 늘어남을 방지 할 수 있어요.",
        "물기를 제거할 때는 너무 세지 않게, 부드럽게 비틀어 물기를 제거하세요.\n물기를 짠 옷은 세면대나 욕조 같이 두께가 있는 곳에 걸쳐 물기를 조금 더 뺀 후 건조대에 널어주세요.\n햇볕이 바로 닿지 않는 곳에 건조하세요.",
        "늘어나지 않게 접어서 보관하세요."
    ]
    let shirt = [
        "",
        "셔츠의 누런 얼룩은 과탄산소다나 샴푸로 지우면 쉽게 지워져요.\n음식 얼룩은 식초 혹은 주방세제로 빨래하면 깔끔하게 지울 수 있습니다.\n단추를 모두 잠군 후 세탁 망에 넣어세탁하면 형태 변형을 막을 수 있습니다.",
        "탈수는 최대한 약하게 한 후 옷걸이에 걸어 자연건조 하세요.",
        "옷걸이에 걸어 보관하세요."
    ]
    let knit = [
        "",
        "손세탁 하는 것이 가장 좋습니다.\n세탁기를 이용할 때는 세탁망에 넣어 세탁해야 합니다. 냉수를 이용하고, 울 코스/탈수 섬세 모드를 이용하세요.\n헹군 단계에서 식초나 레몬즙을 넣으면 보풀을 방지 할 수 있어요.",
        "건조대 두 칸에 걸쳐 늘어나지 않게 건조하세요.",
        "늘어나지 않게 접어서 보관하는 것이 좋아요.\n어깨가 넓은 정장용 옷걸이에 걸어 보관하세요.\n니트를 팽팽하게 당겨 칫솔로 살살 문지르면 보풀을 쉽게 제거할 수 있어요."
    ]
    
    // pants
    let dressPants = [
        "",
        "30°C 이하의 물에 중성세제를 풀어 비비지 말고 부드럽게 손세탁 하세요.\n세탁기 이용 시에는 뒤집어서 세탁망에 넣고, 차가운 물로 울 세탁 코스를 이용하세요.",
        "비틀어 짜지 말고, 수건으로 눌러 물기를 제거하세요.\n탈수기 이용 시에는 약하게, 1분 이내로 마쳐주세요.\n통풍이 잘 되는 곳에서 자연건조 하세요.\n건조기 사용은 하지 않는 것이 좋아요.",
        "바지걸이에 걸어 보관하세요."
    ]
    let jeans = [
        "",
        "청바지는 자주 세탁하지 않는 것이 좋습니다.\n청바지를 뒤집어 빨면 물빠짐을 막을 수 있습니다.\n손 빨래, 울 코스에서 냉수로 세탁해 주세요.",
        "청바지는 자연건조 하는 것이 좋습니다. 직사광선을 피해 건조하세요.\n바지의 발목이 위로 가게 건조하면 바지의 수축을 방지하고, 늘어난 무릎을 복구시킬 수도 있습니다.\n건조기를 이용할 때는 최저온도로 설정하고 이용해 주세요.",
        "접어서 보관하기보다 돌돌 말아 보관하는 것이 좋습니다."
    ]
    let skirt = [
        "",
        "레이스 스커트나, 악세사리가 부착된 스커트의 경우, 드라이크리닝을 맡기는 것이 좋습니다.\n중성세제를 차가운 물에 풀어 부드럽게 세탁해주세요.\n세탁기 이용 시 세탁망에 넣어 울 세제를 넣고, 울 코스를 이용하세요.",
        "옷걸이에 걸어 건조하지 말고 수건을 이용해 물기 제거 후 건조대에 널어 그늘에서 말려주세요.",
        "구짐이 가지 않게 바지걸이에 널어 보관하세요."
    ]
    let cottonPant = [
        "",
        "손세탁이나 세탁기 '울 세탁'모드를 이용합니다.\n소재별 관리 '면 세탁/관리방법'을 확인해보세요",
        "탈수가 끝난 바지를 세로로 길게 접어 얇은 천을 덧대 평평한 물건으로 눌러 준 후 건조하면 구김 없이 건조할 수 있습니다.",
        "바지걸이에 걸어 보관하세요.\n잘 접어 보관하는 것도 좋아요."
    ]

    
    ///outer
    let padding = [
        "",
        "드라이클리닝을 이용할 수도 있지만, 패딩의 볼륨감을 유지하려면 손세탁 하는 것이 가장 좋습니다.\n30°C 정도의 물에 중성세제를 물에 풀어 주무릅니다. 오염이 있는 부분은 솔을 이용해 문질러주세요.\n물에 너무 오래 담겨있지 않게 빠르게 세탁해주어야 합니다.\n세탁기 이용 시 지퍼를 채우고 세탁 망에 넣어 울코스를 이용하세요.",
        "손으로 충전재를 풀어준 후 건조대에 눕혀 건조하세요.\n건조된 후에는 방망이로 살살 두드려 주며 솜이 뭉친 곳은 없는지 확인해 주세요.",
        "드라이클리닝 후에는 비닐을 벗겨 3~4시간 햇빛을 쫴어 주세요.\n옷걸이에 걸어 보관하세요."
    ]
    let coat = [
        "",
        "드라이클리닝을 권장합니다.\n손세탁 시에는 홈드라이클리닝세제를 물에 풀어 20분 정도 담가둔 후 손세탁하세요.",
        "손세탁 후 세탁기에 넣어 탈수합니다.\n건조대에 눕혀 건조하세요.",
        "두꺼운 정장용 옷걸이에 걸어 보관하세요.\n단추를 채우고 보관하세요."
    ]
    let jacket = [
        "",
        "케어라벨을 확인해 세탁 가능 여부를 확인하세요. 드라이클리닝만 가능한 제품일 수도 있습니다.\n손세탁 할 경우, 얼룩진 곳에 얼룩제거제를 바르고 10분간 기다려줍니다.\n중성세제를 물에 풀어 세탁하세요.\n세탁기 이용 시 지퍼를 잠구고, 뒤집어 세탁망에 넣고 차가운 물에 울세탁을 이용하세요.",
        "탈수기를 이용해 탈 수 후 건조기에 눕혀 자연건조 하세요.",
        "두꺼운 정장용 옷걸이에 걸어 보관하세요."
    ]
    // shoes
    
    // etc
    let onePiece = [
        "",
        "일반 원피스는 중성세제를 이용해 세탁하는 것이 좋습니다.\n악세사리가 부착되어 있다면 드라이크리닝을 맡기는 것이 좋습니다.",
        "옷걸이에 걸어 건조하지 말고 수건을 이용해 물기 제거 후 건조대에 널어 그늘에서 말려주세요.",
        "다림질 후 옷걸이에 걸어 보관하세요"
    ]
    let clothHat = [
        "",
        "미지근한 물에서 솔이나 칫솔로 닦아 세탁하세요.",
        "그늘지고 바람이 잘 통하는 곳에서 건조하세요. ",
        "신문지로 모자 속을 채워두면 세탁 후에도 형태가 변하지 않습니다."
    ]
    let beanie = [
        "",
        "미지근한 물에 중성세제를 풀어 부드럽게 손세탁 해 주세요.",
        "꽉 짜지 말고 살짝 짠 후 수건으로 물기를 제거하세요.\n건조대 위에 올려 그늘진 곳에서 자연건조 시키세요.",
        "모양이 구겨지지 않게 신문지를 넣어 보관하세요."
    ]
    let muffler = [
        "",
        "목도리는 직접 얼굴에 닿는 만큼 자주 세탁하는 것이 좋습니다.\n중성세제를 탄 물에 15분간 불려준 후 손세탁 해 주세요.\n세탁기 이용 시에는 세탁망에 넣어 울 샴푸, 울 코스를 이용해 주세요.\n헹굴 때 식초나 섬유유연제를 넣으면 정전기를 방지 할 수 있습니다. ",
        "손으로 비틀어 짜지 말고, 수건으로 감싸 물기를 제거해 주세요.\n건조대 여러 칸에 걸쳐 뉘어 건조시켜주세요.",
        "옷걸이에 널어 보관하거나 돌돌 말아 보관하세요."
    ]
    let bag = [
        "",
        "세탁 전 케어라벨을 확인해 주세요.\n얼룩진 곳에 얼룩제거제를 바르고 30분간 기다려줍니다.\n미지근한 물에 세제를 넣고 부드러운 솔로 문질러 세탁하세요.\n세탁기 사용 시 미지근한 물로 울세탁하세요.",
        "수건으로 물기를 제거해 주세요.\n그늘진 곳에 건조하세요.",
        "신문지를 뭉쳐 넣어 형태가 유지될 수 있게 보관해 주세요."
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
        switch modalTitle {
        case "면":
            return cotton.count
        case "린넨":
            return linen.count
        case "폴리에스테르":
            return polyester.count
        case "나일론":
            return nylon.count
        case "벨벳":
            return velvet.count
        case "데님":
            return Denim.count
        case "가죽":
            return leather.count
        case "퍼":
            return fur.count
        case "실크":
            return silk.count
        case "트위드":
            return tweed.count
        case "쉬폰":
            return chiffon.count
        case "코듀로이":
            return corduroy.count
        case "메탈릭":
            return metallic.count
        case "레이스":
            return lace.count
        case "기타":
            return etc.count
        // category
        // top
        case "티셔츠":
            return tShirtAndHood.count
        case "맨투맨":
            return tShirtAndHood.count
        case "후드":
            return tShirtAndHood.count
        case "셔츠":
            return shirt.count
        case "니트":
            return knit.count
        // pants
        case "슬랙스(정장바지)":
            return dressPants.count
        case "청바지":
            return jeans.count
        case "치마":
            return skirt.count
        case "면바지":
            return cottonPant.count
        // outer
        case "패딩":
            return padding.count
        case "코트":
            return cottonPant.count
        case "자켓":
            return jacket.count
        // shoes
            
        // etc
        case "원피스":
            return onePiece.count
        case "천모자":
            return clothHat.count
        case "비니(털모자)":
            return beanie.count
        case "목도리":
            return muffler.count
        default:
            return 0
        }
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self), for: indexPath) as! ClothesCareInfoModalViewCell
        
        switch modalTitle {
        case "면":
            cell.careInfo = cotton[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "린넨":
            cell.careInfo = linen[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "폴리에스테르":
            cell.careInfo = polyester[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "나일론":
            cell.careInfo = nylon[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "벨벳":
            cell.careInfo = velvet[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "데님":
            cell.careInfo = Denim[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "가죽":
            cell.careInfo = leather[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "퍼":
            cell.careInfo = fur[indexPath.row]
            cell.stepLabel = furStep[indexPath.row]
        case "실크":
            cell.careInfo = silk[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "트위드":
            cell.careInfo = tweed[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "쉬폰":
            cell.careInfo = chiffon[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "코듀로이":
            cell.careInfo = corduroy[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "메탈릭":
            cell.careInfo = metallic[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "레이스":
            cell.careInfo = lace[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        case "기타":
            cell.careInfo = etc[indexPath.row]
            cell.stepLabel = materialStep[indexPath.row]
        // category
        // top
        case "티셔츠":
            cell.careInfo = tShirtAndHood[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "맨투맨":
            cell.careInfo = tShirtAndHood[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "후드":
            cell.careInfo = tShirtAndHood[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "셔츠":
            cell.careInfo = shirt[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "니트":
            cell.careInfo = knit[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        // pants
        case "슬랙스(정장바지)":
            cell.careInfo = dressPants[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "청바지":
            cell.careInfo = jeans[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "치마":
            cell.careInfo = skirt[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "면바지":
            cell.careInfo = cottonPant[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        // outer
        case "패딩":
            cell.careInfo = padding[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "코트":
            cell.careInfo = coat[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "자켓":
            cell.careInfo = jacket[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        // shoes
            
        // etc
        case "원피스":
            cell.careInfo = onePiece[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "천모자":
            cell.careInfo = clothHat[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "비니(털모자)":
            cell.careInfo = beanie[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "목도리":
            cell.careInfo = muffler[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        case "가방":
            cell.careInfo = bag[indexPath.row]
            cell.stepLabel = categoryStep[indexPath.row]
        default:
            cell.careInfo = ""
        }
        
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
