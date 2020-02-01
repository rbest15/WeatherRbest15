import Foundation

//Struct Weather Decodable
struct ForecastDecoder : Decodable {
    let list : [Listdecoder]
}
struct Listdecoder : Decodable {
    let dt : Int
    let main : MainFiveDecoder?
    let weather : [WatherDecoder]
    
}
struct MainFiveDecoder : Decodable {
    let temp : Double
    let pressure : Int
}
struct WatherDecoder : Decodable {
    let description : String
}
