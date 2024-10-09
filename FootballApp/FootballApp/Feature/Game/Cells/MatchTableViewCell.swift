//
//  MatchTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MatchTableViewCell"
    
    private let homeTeamLogoImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeGoalsLabel = UILabel()
    private let awayGoalsLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    private let awayTeamLogoImageView = UIImageView()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit
        homeTeamNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        awayTeamNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        homeGoalsLabel.font = .systemFont(ofSize: 12)
        awayGoalsLabel.font = .systemFont(ofSize: 12)
        statusLabel.font = .systemFont(ofSize: 10, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        
        homeTeamNameLabel.numberOfLines = 2
        awayTeamNameLabel.numberOfLines = 2
        
        [homeTeamLogoImageView, homeTeamNameLabel, homeGoalsLabel, awayGoalsLabel,
         awayTeamNameLabel, awayTeamLogoImageView, statusLabel, dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeTeamLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            homeTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            homeTeamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            homeTeamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            homeTeamNameLabel.leadingAnchor.constraint(equalTo: homeTeamLogoImageView.trailingAnchor, constant: 10),
            homeTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            homeGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15),
            
            awayGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            
            awayTeamNameLabel.trailingAnchor.constraint(equalTo: awayTeamLogoImageView.leadingAnchor, constant: -10),
            awayTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            awayTeamLogoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            awayTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            awayTeamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            awayTeamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.topAnchor.constraint(equalTo: homeTeamLogoImageView.bottomAnchor, constant: 5),
            statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
}

extension MatchTableViewCell {
    func configure(with homeTeam: String, homeLogo: String, awayTeam: String, awayLogo: String, homeGoals: Int?, awayGoals: Int?, status: String, date: String) {
        homeTeamNameLabel.text = homeTeam
        awayTeamNameLabel.text = awayTeam
        homeGoalsLabel.text = "\(homeGoals ?? 0)"
        awayGoalsLabel.text = "\(awayGoals ?? 0)"
        statusLabel.text = status
        dateLabel.text = formatDate(date)
        
        // 로고 이미지 로드
        homeTeamLogoImageView.loadImage(from: homeLogo)
        awayTeamLogoImageView.loadImage(from: awayLogo)
    }
    
    private func formatDate(_ dateString: String) -> String {
        // 날짜 형식 변환 로직 (필요한 경우)
        // 예시: ISO8601 문자열을 Date로 변환 후 포맷할 수 있음
        return dateString // 변환된 날짜 문자열 반환
    }
}


// MARK: - UIImageView Extension for Image Loading
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
