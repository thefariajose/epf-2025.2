class Vehicle:
    def __init__(self, id, placa, marca, modelo, ano, quilometragem, status, avaliacao, n_avaliacoes,  is_disponivel, preço_do_aluguel):
        self.id = id
        self.placa = placa
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
        self.quilometragem = quilometragem
        self.status = status
        self.avaliacao = avaliacao
        self.n_avaliacoes = n_avaliacoes
        self.is_disponivel = is_disponivel
        self.preço_do_aluguel = preço_do_aluguel

    def __repr__(self):
        return (f"Vehicle(id={self.id}, name='{self.placa}', email='{self.marca}', "
                f"password='{self.modelo}', telephone='{self.ano}'"
                f"password='{self.quilometragem}', telephone='{self.status}'"
                f"password='{self.avaliacao}', telephone='{self.n_avaliacoes}'"
                f"password='{self.is_disponivel}', telephone='{self.preço_do_aluguel}'")
    
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
            'n_avaliacoes' : self.n_avaliacoes,
            'is_disponivel' : self.is_disponivel,
            'preço_do_aluguel' : self.preço_do_aluguel
        }
    
    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            placa=data['placa'],
            marca=data['marca'],
            modelo=data['modelo'],
            ano=data['ano'],
            quilometragem=data['quilometragem'],
            status=data['status'],
            avaliacao=data['avaliacao'],
            n_avaliacoes=data['n_avaliacoes'],
            is_disponivel=data['is_disponivel'],
            preço_do_aluguel=data['preço_do_aluguel']
        )

class VehicleModel:
    FILE_PATH = 'data/vehicles.json'
    
    def __init__(self):
        self.vehicles = self._load()
    
    def _load(self):
        import json, os
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding = 'utf-8') as f:
            return [Vehicle.from_dict(item) for item in json.load(f)]
        
    def _save(self):
        import json
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([a.to_dict() for a in self.vehicles], f, indent=4, ensure_ascii=False)
    
    def get_all(self):
        return self.vehicles

    def get_by_id(self, vehicles_id):
        return next((a for a in self.vehicles if a.id == vehicles_id), None)

    def add(self, vehicles):
        self.vehicles.append(vehicles)
        self._save()

    def update(self, updated_vehicles):
        for i, a in enumerate(self.vehicles):
            if a.id == updated_vehicles.id:
                self.vehicles[i] = updated_vehicles
                self._save()
                break

    def delete(self, vehicles_id):
        self.vehicles = [a for a in self.vehicles if a.id != vehicles_id]
        self._save()


