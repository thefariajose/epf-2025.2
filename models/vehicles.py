import json
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Vehicle:
    def __init__(self, id, placa, marca, modelo, ano, quilometragem, status, avaliacao, n_avaliacoes,  is_disponivel, preco_diaria):
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
        self.preco_diaria = preco_diaria

    def __repr__(self):
        return (f"Vehicle(id={self.id}, placa='{self.placa}', marca='{self.marca}', "
                f"modelo='{self.modelo}', ano='{self.ano}',"
                f"quilometragem='{self.quilometragem}', status='{self.status}',"
                f"avaliacao='{self.avaliacao}', n_avaliacoes='{self.n_avaliacoes}',"
                f"is_disponivel='{self.is_disponivel}', preco_diaria='{self.preco_diaria}')")
    
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
            'preco_diaria' : self.preco_diaria
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
            preco_diaria=data['preco_diaria']
        )

class VehicleModel:
    FILE_PATH = os.path.join(DATA_DIR, 'vehicles.json')
    
    def __init__(self):
        self.vehicles = self._load()
    
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding = 'utf-8') as f:
            # Olhar classe Ciliente
            return [Vehicle.from_dict(item) for item in json.load(f)]
        
    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([v.to_dict() for v in self.vehicles], f, indent=4, ensure_ascii=False)
    
    def get_all(self):
        return self.vehicles

    def get_by_id(self, vehicle_id):
        return next((v for v in self.vehicles if v.id == vehicle_id), None)

    def add(self, vehicle):
        self.vehicles.append(vehicle)
        self._save()

    def update(self, updated_vehicle):
        for i, v in enumerate(self.vehicles):
            if v.id == updated_vehicle.id:
                self.vehicles[i] = updated_vehicle
                self._save()
                break

    def delete(self, vehicle_id):
        self.vehicles = [v for v in self.vehicles if v.id != vehicle_id]
        self._save()


