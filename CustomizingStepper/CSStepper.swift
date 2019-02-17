//
//  CSStepper.swift
//  CustomizingStepper
//
//  Created by 정기욱 on 16/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit
class CSStpper: UIView {
    
    public var leftBtn = UIButton(type: .system) // 좌측 버튼
    public var rightBtn = UIButton(type: .system) // 우측 버튼
    public var centerLabel = UILabel() // 중앙 레이블
    public var value: Int = 0 // 스테퍼의 현재값을 저장할 변수
    
    // 스토리보드에서 호출할 초기화 메소드
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // 프로그래밍 방식으로 호출할 초기화 메소드
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        // 여기에 스테퍼의 기본 속성을 설정한다.
        // 좌측 다운 버튼 속성 설정
        
        let borderWidth: CGFloat = 0.5 // 테두리 두께값
        let borderColor = UIColor.blue.cgColor // 테두리 색상값
        
        self.leftBtn.tag = -1 // 태그 값에 -1을 부여
        self.leftBtn.setTitle("↓", for: .normal) // 버튼 타이틀
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 폰트
        
        self.leftBtn.layer.borderWidth = borderWidth // 버튼 테두리 두께
        self.leftBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        // 우측 업 버튼 속성 설정
        self.rightBtn.tag = 1 // 태그값 1을 부여
        self.rightBtn.setTitle("↑", for: .normal) // 버튼의 타이틀
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 타이틀의 폰트
        
        self.rightBtn.layer.borderWidth = borderWidth // 버튼 테두리의 두께
        self.rightBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        
        // 중앙 레이블 속성 설정
        self.centerLabel.text = String(value) // 컨트롤의 현재값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center // 가운데 정렬
        self.centerLabel.backgroundColor = UIColor.cyan // 배경색상
        self.centerLabel.layer.borderWidth = borderWidth // 레이블의 테두리 두께
        self.centerLabel.layer.borderColor = borderColor // 테두리 색상 파란색
        
        // 영역별 객체를 서브 뷰로 추가한다.
        // 현재 구현하고 있는 CSStepper 자체가 루트뷰이기 때문에 서브뷰로 구현된 객체 3개를 추가해준다,
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
    }
    
    override public func layoutSubviews() { // 이 메소드는 뷰의 크기가 변할 때 호출되는 메소드
        // 스토리보드에서 리사이징 핸들로 드래그하여 크기를 바꾸거나 프로그래밍 코드로 뷰의 속성값을 변경할때
        // 즉 위의 두가지 방법으로 뷰의 크기를 조절할때 그때마다 자동으로 호출되는 메소드
        // 뷰의 내부의 객체들이 있다면 이 메소드 내부에 객체의 크기를 조절하는 구문을 작성함으로써
        // 뷰의 크기 변화에 적절히 대응 가능한다.
        super.layoutSubviews()
        
        // 버튼과 레이블 사이지를 계산식으로 구현하여 상수에 대입
        // 버튼의 너비 = 뷰 높이
        let btnWidth = self.frame.height
        
        // 레이블의 너비 = 뷰 전체 크기 - 양쪽 버튼의 너비 합
        let lblWidth = self.frame.width - ( btnWidth * 2 )
        
        // 버튼과 레이블 사이지를 정적인 값으로 설정하지 않고 뷰가 늘어나고 줄어듬에 따라 그 뷰에 맞추어 버튼과 레이블이 동적으로 늘어남.
        
        // 버튼의 너비와 레이블의 너비를 각 객체에 적용함
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth + lblWidth, y: 0, width: btnWidth, height: btnWidth)
        
    }
    
}
