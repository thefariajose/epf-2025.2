class Vehicle:
    def __init__(self, id, placa, marca, modelo, ano, quilometragem, status, avaliacao, n_avaliacoes):
        self.id = id
        self.placa = placa
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
        self.quilometragem = quilometragem
        self.status = status
        self.avaliacao = avaliacao
        self.n_avaliacoes = n_avaliacoes
    
    def to_dict(self):
        return {
            'id' : self.id,
            'placa' : self.placa,
            'marca': self.marca,
            'modelo' : self.modelo,
            'ano' : self.ano,
            'quilometragem' : self.quilometragem,
            'status' : self.status,
            'avaliacao' : self.avaliacao,
            'n_avaliacoes' : self.n_avaliacoes
        }
    @classmethod
    def from_dict(cls, data):
        return cls(**data)

class VehicleModel:
    FILE_PATH = 'data/vehicles.json'
    
    def __init__(self):
        self.vehicles = self.load()
    
    def _load(self):
        import json, os
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding = 'utf-8') as f:
            return [Vehicle.from_dict(item) for item in json.load(f)]
    
    #concluir o resto dps, tá tarde já
