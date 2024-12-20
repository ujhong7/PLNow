//
//  TeamRankingViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class TeamRankingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let footballService = FootballNetworkService()
    private var teamRankings: [LeagueResponse] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureTableHeaderView()
        fetchTeamRankings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 선택된 셀이 있을 경우 선택 해제
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamRankingTableViewCell.self, forCellReuseIdentifier: TeamRankingTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func fetchTeamRankings() {
        loadingIndicatorView.show(in: view)
        
        footballService.getTeamRanking(league: premierLeague, season: season2024) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.hide()
            }
            
            switch result {
            case .success(let response):
                print("🔴🔴🔴🔴🔴🔴🔴🔴")
                dump(response)
                self?.teamRankings = response.response
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching team rankings: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension TeamRankingViewController: UITableViewDataSource {
    // 🚨🚨🚨🚨🚨 이 부분 솔직히 잘 모르겠음 🚨🚨🚨🚨🚨🚨
    func numberOfSections(in tableView: UITableView) -> Int {
        return teamRankings.count // 리그의 수를 섹션으로 설정
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 각 섹션에서 해당 리그의 팀 수를 반환
        let leagueResponse = teamRankings[section]
        return leagueResponse.league.standings?.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamRankingTableViewCell.identifier, for: indexPath) as? TeamRankingTableViewCell else {
            return UITableViewCell()
        }
        // standings의 첫 번째 배열에서 현재 인덱스에 해당하는 팀 통계 정보 가져오기
        let leagueResponse = teamRankings.first ?? nil
        // standings의 첫 번째 배열에서 현재 인덱스에 해당하는 팀 통계 정보 가져오기
        if let standings = leagueResponse?.league.standings,
           let teamStats = standings.first?[indexPath.row] {
            cell.configure(with: teamStats)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TeamRankingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueResponse = teamRankings.first ?? nil
        // standings의 첫 번째 배열에서 현재 인덱스에 해당하는 팀 통계 정보 가져오기
        if let standings = leagueResponse?.league.standings,
           let teamStats = standings.first?[indexPath.row] {
            // 팀 정보를 담을 객체 생성
            let teamInfo = TeamInformation(id: teamStats.team.id, name: teamStats.team.name, logo: teamStats.team.logo)
            let teamInformationVC = TeamRankingInformationViewController(teamInfo: teamInfo)
            navigationController?.pushViewController(teamInformationVC, animated: true)
        }
    }
}

extension TeamRankingViewController {
    
    private func configureTableHeaderView() {
        // 헤더 뷰의 높이와 넓이를 설정
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .systemBackground
        
        // separatorLine 추가
        headerView.addSubview(separatorLine)
        
        // 헤더의 UI 요소들 생성
        let rankLabel = UILabel()
        let teamLabel = UILabel()
        let matchesLabel = UILabel()
        let pointsLabel = UILabel()
        let winsLabel = UILabel()
        let drawsLabel = UILabel()
        let lossesLabel = UILabel()
        let goalDifferenceLabel = UILabel()
        let goalsForLabel = UILabel()
        let goalsAgainstLabel = UILabel()
        
        // 텍스트 설정
        rankLabel.text = "순위"
        teamLabel.text = "팀이름"
        matchesLabel.text = "경기수"
        pointsLabel.text = "승점"
        winsLabel.text = "승"
        drawsLabel.text = "무"
        lossesLabel.text = "패"
        goalDifferenceLabel.text = "득실차"
        goalsForLabel.text = "득점"
        goalsAgainstLabel.text = "실점"
        
        // 폰트 설정
        let labels = [rankLabel, teamLabel, matchesLabel, pointsLabel, winsLabel, drawsLabel, lossesLabel, goalDifferenceLabel, goalsForLabel, goalsAgainstLabel]
        labels.forEach { label in
            label.font = UIFont.boldSystemFont(ofSize: 10)
            label.textColor = .black
            headerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            // 순위 레이블 위치 설정
            rankLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            rankLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 팀 이름 레이블 위치 설정
            teamLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 87),
            teamLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 경기 수 레이블 위치 설정
            matchesLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 130),
            matchesLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 승점 레이블 위치 설정
            pointsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 170),
            pointsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 승리 레이블 위치 설정
            winsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 200),
            winsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 무승부 레이블 위치 설정
            drawsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 230),
            drawsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 패배 레이블 위치 설정
            lossesLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 255),
            lossesLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 득실차 레이블 위치 설정
            goalDifferenceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 285),
            goalDifferenceLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 득점 레이블 위치 설정
            goalsForLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 320),
            goalsForLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 실점 레이블 위치 설정
            goalsAgainstLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 345),
            goalsAgainstLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // separatorLine 레이아웃 설정
            separatorLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        // 테이블뷰의 tableHeaderView에 설정
        tableView.tableHeaderView = headerView
    }
    
}

// MARK: - 넘겨줄 팀 정보

///  넘겨줄 팀 정보
struct TeamInformation {
    let id: Int
    let name: String
    let logo: String
}

