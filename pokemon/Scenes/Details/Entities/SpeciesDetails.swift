import Foundation

/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails : Codable{
    let name: String?
    let evolutionChain: EvolutionChain?
}

/// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
struct EvolutionChain: Codable {
    let url: URL?
}


struct SpeciesDetailsViewModel { // data to present
    
    var name: String
    var imageURLString: String
    var evolutionChainName: String
    var evolutionChainImage: String?
    
    init(model:SpeciesDetails?,specie:Species?,evolutionChainModel:EvolutionChainDetails?) {
        self.name = model?.name ?? ""
        self.imageURLString = "\(Constants.SpeciebaseImage)\(specie?.index ?? 0).png"
        
        self.evolutionChainName = "No Evolution"
//        self.evolutionChainImage = "No Image"
        
        if evolutionChainModel?.chain?.species == specie{ // 1st obj
            if let evolves_to = evolutionChainModel?.chain?.evolvesTo , !evolves_to.isEmpty{
                self.evolutionChainName = evolutionChainModel?.chain?.evolvesTo?[0].species?.name ?? ""
                self.evolutionChainImage =  "\(Constants.SpeciebaseImage)\((specie?.index ?? 0) + 1).png"
            }
            
        }else if let evolves_to = evolutionChainModel?.chain?.evolvesTo, !evolves_to.isEmpty ,evolves_to[0].species == specie{ // 2nd obj
            if let evolves_to = evolves_to[0].evolvesTo , !evolves_to.isEmpty{
                self.evolutionChainName = evolves_to[0].species?.name ?? ""
                self.evolutionChainImage =  "\(Constants.SpeciebaseImage)\((specie?.index ?? 0) + 1).png"
            }
        }
       
    }
    

}
