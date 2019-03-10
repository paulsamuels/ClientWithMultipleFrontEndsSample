import Shared
import UIKit

final class PeopleViewController: UITableViewController {
    private let fetch: (@escaping (Result<Decoded<[Person]>>) -> Void) -> JSONPlaceholderClient.Cancellation
    private var data = [Person]()
    
    init(fetch: @escaping (@escaping (Result<Decoded<[Person]>>) -> Void) -> JSONPlaceholderClient.Cancellation) {
        self.fetch = fetch
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = fetch { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(.prod(let value)):
                    self.data = value
                default:
                    fatalError("The client should not be in debugEnabled mode.")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath)
        
        let person = data[indexPath.row]
        
        cell.textLabel?.text       = "(\(person.id)) \(person.name)"
        cell.detailTextLabel?.text = person.website.absoluteString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Bit of a hack to get a `DetailTableViewCell` by only registering the class.
    private class DetailTableViewCell: UITableViewCell {
        static var reuseIdentifier: String { return String(describing: DetailTableViewCell.self) }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: DetailTableViewCell.reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
