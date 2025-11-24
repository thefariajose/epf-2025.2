import json
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Locador:
    def __init__(self, id, name, email, password, telephone, is_locador, cnpj, veiculos : list, historico_locacoes : list, avaliacao,  n_avaliacoes):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone
        self.is_locador = is_locador
        self.cnpj = cnpj
        self.veiculos = veiculos
        self.historico_locacoes = historico_locacoes
        self.avaliacao = avaliacao
        self.n_avaliacoes = n_avaliacoes


    def __repr__(self):
        return (f"Locador(id={self.id}, name='{self.name}', email='{self.email}', "
                f"password='{self.password}', telephone='{self.telephone}'"
                f"is_locador='{self.is_locador}', cnpj='{self.cnpj}'"
                f"veiculos='{self.veiculos}', historico_locacoes='{self.historico_locacoes}'"
                f"avaliacao='{self.avaliacao}', n_avaliacoes='{self.n_avaliacoes}'")

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'telephone': self.telephone,
            'is_locador': self.is_locador,
            'cnpj': self.cnpj,
            'veiculos': [v.to_dict() for v in self.veiculos],
            'historico_locacoes': """[l.to_dict() for l in self.historico_locacoes]""" ,
            'avaliacao' : self.avaliacao,
            'n_avaliacoes': self.n_avaliacoes
        }

    
    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            email=data['email'],
            password=data['password'],
            telephone=data['telephone'],
            is_locador=data['is_locador'],
            cnpj=data['cnpj'],
            veiculos=data['veiculos'],
            historico_locacoes=data['historico_locacoes'],
            avaliacao=data['avaliacao'],
            n_avaliacoes=data['n_avaliacoes']
        )


class LocadorModel:
    FILE_PATH = os.path.join(DATA_DIR, 'locador.json')
    
    def __init__(self):
        self.locadores = self._load()
  
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [Locador(**item) for item in data]

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([l.to_dict() for l in self.locadores], f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.locadores

    def get_by_id(self, locador_id: int):
        return next((l for l in self.locadores if l.id == locador_id), None)

    def add_locador(self, locador: Locador):
        self.locadores.append(locador)
        self._save()

    def update_locador(self, updated_locador: Locador):
        for i, locador in enumerate(self.locadores):
            if locador.id == updated_locador.id:
                self.locadores[i] = updated_locador
                self._save()
                break

    def delete_locador(self, locador_id: int):
        self.locadores = [l for l in self.locadores if l.id != locador_id]
        self._save()
