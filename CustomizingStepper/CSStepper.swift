//
//  CSStepper.swift
//  CustomizingStepper
//
//  Created by 정기욱 on 16/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

@IBDesignable


public class CSStpper: UIControl { //UIControl을 서브 클래싱하면 CSStepper 객체에 액션 이벤트를 연결할수있음
    
    public var leftBtn = UIButton(type: .system) // 좌측 버튼
    public var rightBtn = UIButton(type: .system) // 우측 버튼
    public var centerLabel = UILabel() // 중앙 레이블
    
    @IBInspectable
    public var value: Int = 0 { // 프로퍼티의 값이 바뀌면 자동으로 호출된다.
        didSet { // 즉, value의 속성값을 변경하는 버튼의 액션 메소드의 값이 변경되는 것을
            // 관찰하다가 변경이 되면, centerLabel에 스트링값으로 표시해준다.
            self.centerLabel.text = String(value)
            
            // 이 클래스를 사용하는 객체들에게 valueChange 이벤트 신호를 보내준다.
            // sendActions(for:)는 인자값으로 입력된 타입의 이벤트를 발생시키는 메소드
            // 이는 value 값이 바뀌면 valuedChanged 이벤트를 발생시키라는 의미.
            self.sendActions(for: .valueChanged)
            
        }
    }// 스테퍼의 현재값을 저장할 변수
    
    
    // 프로퍼티 옵저버 내에서는 각각의 프로퍼티에 대입된 값을 이용하여 좌우측 버튼의 텍스트를 설정하고있음.
    // 초기값을 설정해두고 어디선가 만약 변경된다면 변경된 값을 버튼의 텍스트로 설정해줌.
    
    // 좌측 버튼의 타이틀 속성
    @IBInspectable
    public var leftTitle: String = "↓" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    // 우측 버튼의 타이틀
    @IBInspectable
    public var rightTitle: String = "↑" {
        didSet {
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan {
        didSet {
            self.centerLabel.backgroundColor = backgroundColor // 옵저버가 바탕색의 변화를 관찰하고 있다가
            // 어딘가에서 색이 변경되면 중앙 라벨에 적용시켜줌.
        }
    }
    
    // 중간값 단위
    @IBInspectable
    public var stepValue: Int = 1
    
    // 최대값과 최소값
    public var maximumValue : Int = 100
    public var minimumValue : Int = -100
    
    
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
        
        //self.leftBtn.setTitle("↓", for: .normal) // 버튼 타이틀
        self.leftBtn.setTitle(self.leftTitle, for: .normal) // 저장프로퍼티를 새로 정의해줬으므로
        // 초기값을 배당해줌.
        
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 폰트
        
        self.leftBtn.layer.borderWidth = borderWidth // 버튼 테두리 두께
        self.leftBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        // 우측 업 버튼 속성 설정
        self.rightBtn.tag = 1 // 태그값 1을 부여
        
        // self.rightBtn.setTitle("↑", for: .normal) // 버튼의 타이틀
        self.rightBtn.setTitle(self.rightTitle, for: .normal) // 저장프로퍼티를 새로 정의해줬으므로
        // 초기값을 배당해줌.
        
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 타이틀의 폰트
        
        self.rightBtn.layer.borderWidth = borderWidth // 버튼 테두리의 두께
        self.rightBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        
        // 중앙 레이블 속성 설정
        self.centerLabel.text = String(value) // 컨트롤의 현재값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center // 가운데 정렬
        
        // self.centerLabel.backgroundColor = UIColor.cyan // 배경색상
        self.centerLabel.backgroundColor = self.bgColor
        // 배경색을 옵저버가 추가된 저장프로퍼티를 추가해 줬으므로 저장프로퍼티로 배경색을 초기화해줌.
        
        self.centerLabel.layer.borderWidth = borderWidth // 레이블의 테두리 두께
        self.centerLabel.layer.borderColor = borderColor // 테두리 색상 파란색
        
        
        // 버튼의 터치 이벤트와 valueChange(_:) 메소드를 연결한다.
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        
        // 영역별 객체를 서브 뷰로 추가한다.
        // 현재 구현하고 있는 CSStepper 자체가 루트뷰이기 때문에 서브뷰로 구현된 객체 3개를 추가해준다,
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
    }
    
 
    
    // value 속성의 값을 변경하는 메소드
    @objc public func valueChange (_ sender: UIButton) {
        
        // 스테퍼의 값을 변경하기 전에, 미리 최소값과 최대값 범위를 벗어나지 않는지 체크한다.
        let sum = self.value + (sender.tag * self.stepValue)
        
        // 더한 결과가 최대값보다 크면 값을 변경하지 않고 종료
        if sum > self.maximumValue {
            return
        }
        
        // 더한 결과가 최소값보다 작으면 값을 변경하지 않고 종료
        if sum < self.minimumValue {
            return
        }
        
        // 현재의 value 값에 +1 또는 -1 한다.
        self.value += (sender.tag * self.stepValue )
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
