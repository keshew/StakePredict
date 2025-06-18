import Foundation

struct MyNote: Codable {
    let title: String
    let textOfNote: String
}

struct LoginResponse: Decodable {
    let success: String
    let email: String
    let username: String
}

struct WholeNote: Identifiable, Codable {
    var id = UUID()
    let image: String?
    let title: String
    let textOfNote: String
    let username: String? 
    
    private enum CodingKeys: String, CodingKey {
        case image, title, textOfNote, username
    }
}

struct MyPrediction: Codable {
    var id: String
    var email: String
    var firstTeamName: String
    var secondTeamName: String
    var firstTeamImage: String
    var secondTeamImage: String
    var date: Date
    var textOfPrediction: String
    var isPredicted: Bool
    var isPredictionRight: Bool
}

struct PredictionsResponse: Decodable {
    let predictions: [MyPrediction]
}

struct ServerSuccessResponse: Decodable {
    let success: String
}

struct WholeNotesResponse: Decodable {
    let wholeNotes: [WholeNote]
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = URL(string: "https://stakenote.cyou/app.php")!
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case serverError(String)
        case decodingError
    }
    
    func sendRequest<T: Decodable>(with body: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode,
                  let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                do {
                    let decoder = JSONDecoder()
                    if let serverError = try? decoder.decode(ServerErrorResponse.self, from: data) {
                        completion(.failure(NetworkError.serverError(serverError.error)))
                    } else {
                        completion(.failure(NetworkError.decodingError))
                    }
                }
            }
        }.resume()
    }

    
    struct ServerErrorResponse: Decodable {
        let error: String
    }
    
    struct SuccessResponse<T: Decodable>: Decodable {
        let success: String
        let task: T?
    }
    
 
    
    struct NotesResponse: Decodable {
        let notes: [MyNote]
    }
    
    struct Task: Codable {
        let id: String?
        let title: String
        let date: String
        let finishDate: String
        let category: String
        let priority: String
        let color: String
        let repeatField: String
        let time: String
        let isDone: Bool
        
        enum CodingKeys: String, CodingKey {
            case id, title, date, finishDate, category, priority, color, time, isDone
            case repeatField = "repeat"
        }
    }
    
    typealias TasksArray = [Task]
    typealias AllTasksResponse = [String: TasksArray]
    
    struct ServerSuccessResponse: Decodable {
        let success: String
    }
    
    //MARK: - AUTH
    func register(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "register",
            "username": username,
            "email": email,
            "pass": password
        ]
        
        sendRequest(with: body) { (result: Result<SuccessResponse<Task>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "login",
            "email": email,
            "pass": password
        ]
        sendRequest(with: body) { (result: Result<LoginResponse, Error>) in
            completion(result)
        }
    }
    
    func logOut(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "logOut",
            "email": email,
            "pass": password
        ]
        sendRequest(with: body) { (result: Result<SuccessResponse<Task>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func changeUser(oldEmail: String, newUsername: String, newEmail: String, completion: @escaping (Result<SuccessResponse<Task>, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "changeUser",
            "oldEmail": oldEmail,
            "newUsername": newUsername,
            "newEmail": newEmail
        ]
        
        sendRequest(with: body) { (result: Result<SuccessResponse<Task>, Error>) in
            completion(result)
        }
    }
    
    //MARK: -  MY NOTE
    
    func addNote(email: String, title: String, textOfNote: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "addNote",
            "email": email,
            "title": title,
            "textOfNote": textOfNote
        ]
        sendRequest(with: body) { (result: Result<SuccessResponse<MyNote>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNotes(email: String, completion: @escaping (Result<[MyNote], Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "getNotes",
            "email": email
        ]
        sendRequest(with: body) { (result: Result<NotesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - WHOLE NOTE
    
    func addWholeNote(
        title: String,
        textOfNote: String,
        image: String? = nil,
        username: String? = nil,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        var body: [String: Any] = [
            "metod": "addWholeNote",
            "title": title,
            "textOfNote": textOfNote
        ]
        if let image = image {
            body["image"] = image
        }
        if let username = username {
            body["username"] = username
        }
        sendRequest(with: body) { (result: Result<ServerSuccessResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getWholeNotes(completion: @escaping (Result<[WholeNote], Error>) -> Void) {
        let body: [String: Any] = [
            "metod": "getWholeNotes"
        ]
        sendRequest(with: body) { (result: Result<WholeNotesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.wholeNotes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    //MARK: - Predictions
    
    func addPrediction(
        email: String,
        firstTeamName: String,
        secondTeamName: String,
        firstTeamImage: String,
        secondTeamImage: String,
        date: Date,
        textOfPrediction: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: date)
        let body: [String: Any] = [
            "metod": "addPrediction",
            "email": email,
            "firstTeamName": firstTeamName,
            "secondTeamName": secondTeamName,
            "firstTeamImage": firstTeamImage,
            "secondTeamImage": secondTeamImage,
            "date": dateString,
            "textOfPrediction": textOfPrediction
        ]
        sendRequest(with: body) { (result: Result<ServerSuccessResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPredictions(
        email: String,
        completion: @escaping (Result<[MyPrediction], Error>) -> Void
    ) {
        let body: [String: Any] = [
            "metod": "getPredictions",
            "email": email
        ]
        sendRequest(with: body) { (result: Result<PredictionsResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.predictions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updatePredictionStatus(
        id: String,
        email: String,
        isPredicted: Bool,
        isPredictionRight: Bool,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let body: [String: Any] = [
            "metod": "updatePredictionStatus",
            "id": id,
            "email": email,
            "isPredicted": isPredicted,
            "isPredictionRight": isPredictionRight
        ]
        sendRequest(with: body) { (result: Result<ServerSuccessResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
