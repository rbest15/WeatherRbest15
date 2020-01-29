import Foundation

//Struct Weather Decodable
struct ForecastDecoder : Decodable {
    let list : [Listdecoder]
}
struct Listdecoder : Decodable {
    let dt : Int
    let main : MainFiveDecoder?
    
}
struct MainFiveDecoder : Decodable {
    let temp : Double
}
